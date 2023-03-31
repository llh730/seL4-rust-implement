use core::alloc::Layout;
use core::arch::asm;
use core::cell::RefCell;
use core::mem;
use lazy_static::*;
use riscv::register::satp;

use crate::{config::*, println, BIT, MASK, ROUND_DOWN};

use super::boot::{
    get_n_paging, it_alloc_paging, p_region_t, provide_cap, rootserver, v_region_t, write_slot,
};
use super::object::structures::{
    cap_capType_equals, cap_frame_cap_get_capFBasePtr, cap_frame_cap_get_capFIsDevice,
    cap_frame_cap_get_capFMappedAddress, cap_frame_cap_get_capFSize,
    cap_frame_cap_get_capFVMRights, cap_frame_cap_new, cap_get_capType, cap_null_cap_new,
    cap_page_table_cap_get_capPTBasePtr, cap_page_table_cap_get_capPTMappedASID,
    cap_page_table_cap_get_capPTMappedAddress, cap_page_table_cap_new, cap_t, cte_t, exception_t,
    pte_ptr_get_execute, pte_ptr_get_ppn, pte_ptr_get_read, pte_ptr_get_valid, pte_ptr_get_write,
};

use super::object::objecttype::*;
use super::thread::tcb_t;

type pptr_t = usize;
type paddr_t = usize;
type vptr_t = usize;
type pte_t = usize;
type asid_t = usize;
type vm_rights_t = usize;

pub enum vm_page_size_t {
    RISCV_4K_Page,
    RISCV_Mega_Page,
    RISCV_Giga_Page,
    RISCV_Tera_Page,
}
pub const RISCV_4K_Page: usize = 0;
pub const RISCV_Mega_Page: usize = 1;
pub const RISCV_Giga_Page: usize = 2;
pub const RISCV_Tera_Page: usize = 3;

pub const VMKernelOnly: usize = 1;
pub const VMReadOnly: usize = 2;
pub const VMReadWrite: usize = 3;

#[inline]
pub fn pageBitsForSize(page_size: usize) -> usize {
    match page_size {
        RISCV_4K_Page => RISCVPageBits,
        RISCV_Mega_Page => RISCVMegaPageBits,
        RISCV_Giga_Page => RISCVGigaPageBits,
        _ => panic!("Invalid page size!"),
    }
}

pub struct satp_t {
    pub words: usize,
}

pub struct lookupPTSlot_ret_t {
    pub ptSlot: usize,
    pub ptBitsLeft: usize,
}

pub struct asid_pool_t {
    array: [pte_t; BIT!(asidLowBits)],
}
pub struct findVSpaceForASID_ret {
    pub status: exception_t,
    pub vspace_root: pte_t,
}

#[link_section = ".page_table"]
static mut kernel_root_pageTable: [pte_t; BIT!(PT_INDEX_BITS)] = [0; BIT!(PT_INDEX_BITS)];

#[link_section = ".page_table"]
static mut kernel_image_level2_pt: [pte_t; BIT!(PT_INDEX_BITS)] = [0; BIT!(PT_INDEX_BITS)];

static mut riscvKSASIDTable: [usize; BIT!(asidHighBits)] = [0; BIT!(asidHighBits)];

#[inline]
pub fn satp_new(mode: usize, asid: usize, ppn: usize) -> satp_t {
    let satp = satp_t {
        words: 0
            | (mode & 0xfusize) << 60
            | (asid & 0xffffusize) << 44
            | (ppn & 0xfffffffffffusize) << 0,
    };
    satp
}

#[inline]
pub unsafe fn write_satp(value: usize) {
    core::arch::asm!("csrw satp,{0}",in(reg) value);
}

#[inline]
pub unsafe fn read_satp() -> usize {
    let temp: usize;
    core::arch::asm!("csrr {0},satp",out(reg) temp);
    temp
}

#[inline]
#[no_mangle]
pub unsafe fn sfence() {
    core::arch::asm!("sfence.vma");
}

#[inline]
#[no_mangle]
pub fn setVSpaceRoot(addr: paddr_t, asid: usize) {
    let satp = satp_new(8usize, asid, addr >> 12);
    // println!("addr:{:#x}",addr);
    unsafe {
        satp::write(satp.words);
        sfence();
    }
}

#[inline]
pub fn pte_new(
    ppn: usize,
    sw: usize,
    dirty: usize,
    accessed: usize,
    global: usize,
    user: usize,
    execute: usize,
    write: usize,
    read: usize,
    valid: usize,
) -> pte_t {
    let pte = 0
        | (ppn & 0xfffffffffffusize) << 10
        | (sw & 0x3usize) << 8
        | (dirty & 0x1usize) << 7
        | (accessed & 0x1usize) << 6
        | (global & 0x1usize) << 5
        | (user & 0x1usize) << 4
        | (execute & 0x1usize) << 3
        | (write & 0x1usize) << 2
        | (read & 0x1usize) << 1
        | (valid & 0x1usize) << 0;
    pte
}

pub fn pte_next(phys_addr: usize, is_leaf: bool) -> pte_t {
    let ppn = (phys_addr >> 12) as usize;

    let read = is_leaf as u8;
    let write = read;
    let exec = read;
    return pte_new(
        ppn,
        0,                /* sw */
        is_leaf as usize, /* dirty (leaf)/reserved (non-leaf) */
        is_leaf as usize, /* accessed (leaf)/reserved (non-leaf) */
        1,                /* global */
        0,                /* user (leaf)/reserved (non-leaf) */
        exec as usize,    /* execute */
        write as usize,   /* write */
        read as usize,    /* read */
        1,                /* valid */
    );
}

pub fn user_pte_next(phys_addr: usize, is_leaf: bool) -> pte_t {
    let ppn = (phys_addr >> 12) as usize;

    let read = is_leaf as u8;
    let write = read;
    let exec = read;
    return pte_new(
        ppn,
        0,                /* sw */
        is_leaf as usize, /* dirty (leaf)/reserved (non-leaf) */
        is_leaf as usize, /* accessed (leaf)/reserved (non-leaf) */
        1,                /* global */
        1,                /* user (leaf)/reserved (non-leaf) */
        exec as usize,    /* execute */
        write as usize,   /* write */
        read as usize,    /* read */
        1,                /* valid */
    );
}

pub fn RISCV_GET_PT_INDEX(addr: usize, n: usize) -> usize {
    ((addr) >> (((PT_INDEX_BITS) * (((CONFIG_PT_LEVELS) - 1) - (n))) + seL4_PageBits))
        & MASK!(PT_INDEX_BITS)
}

fn RISCV_GET_LVL_PGSIZE_BITS(n: usize) -> usize {
    ((PT_INDEX_BITS) * (((CONFIG_PT_LEVELS) - 1) - (n))) + seL4_PageBits
}

fn RISCV_GET_LVL_PGSIZE(n: usize) -> usize {
    BIT!(RISCV_GET_LVL_PGSIZE_BITS(n))
}

pub fn kpptr_to_paddr(x: usize) -> paddr_t {
    x - KERNEL_ELF_BASE_OFFSET
}
pub fn pptr_to_paddr(x: usize) -> paddr_t {
    x - PPTR_BASE_OFFSET
}
pub fn paddr_to_pptr(x: usize) -> paddr_t {
    x + PPTR_BASE_OFFSET
}

pub fn map_kernel_window() {
    let mut pptr = PPTR_BASE;

    let mut paddr = PADDR_BASE;
    while pptr < PPTR_TOP {
        unsafe {
            kernel_root_pageTable[RISCV_GET_PT_INDEX(pptr, 0)] = pte_next(paddr, true);
        }
        pptr += RISCV_GET_LVL_PGSIZE(0);
        paddr += RISCV_GET_LVL_PGSIZE(0);
    }
    pptr = ROUND_DOWN!(KERNEL_ELF_BASE, RISCV_GET_LVL_PGSIZE_BITS(0));
    paddr = ROUND_DOWN!(KERNEL_ELF_PADDR_BASE, RISCV_GET_LVL_PGSIZE_BITS(0));
    unsafe {
        kernel_root_pageTable[RISCV_GET_PT_INDEX(KERNEL_ELF_PADDR_BASE + PPTR_BASE_OFFSET, 0)] =
            pte_next(kernel_image_level2_pt.as_ptr() as usize, false);
        kernel_root_pageTable[RISCV_GET_PT_INDEX(pptr, 0)] =
            pte_next(kernel_image_level2_pt.as_ptr() as usize, false);
        kernel_root_pageTable[RISCV_GET_PT_INDEX(paddr, 0)] =
            pte_next(kernel_image_level2_pt.as_ptr() as usize, false);
    }

    let mut index = 0;
    while pptr < PPTR_TOP + RISCV_GET_LVL_PGSIZE(0) {
        unsafe {
            kernel_image_level2_pt[RISCV_GET_PT_INDEX(pptr, 1)] = pte_next(paddr, true);
        }
        index += 1;
        pptr += RISCV_GET_LVL_PGSIZE(1);
        paddr += RISCV_GET_LVL_PGSIZE(1);
    }
}

pub fn activate_kernel_vspace() {
    unsafe {
        setVSpaceRoot(kernel_root_pageTable.as_ptr() as usize, 0);
    }
}

pub fn map_it_pt_cap(_vspace_cap: *const cap_t, _pt_cap: *const cap_t) {
    let vptr = cap_page_table_cap_get_capPTMappedAddress(_pt_cap);
    let lvl1pt = cap_get_capPtr(_vspace_cap);
    let pt: usize = cap_get_capPtr(_pt_cap);

    let pt_ret = lookupPTSlot(lvl1pt, vptr);
    let targetSlot = pt_ret.ptSlot as *mut usize;
    unsafe {
        *targetSlot = pte_new(
            pt >> seL4_PageBits,
            0, /* sw */
            0, /* dirty (reserved non-leaf) */
            0, /* accessed (reserved non-leaf) */
            0, /* global */
            0, /* user (reserved non-leaf) */
            0, /* execute */
            0, /* write */
            0, /* read */
            1, /* valid */
        );
        sfence();
        // println!(
        //     "targetSlot:{:#x} after write:{:#x}",
        //     targetSlot as usize, *targetSlot
        // );
    }
}

pub fn map_it_frame_cap(_vspace_cap: *const cap_t, _frame_cap: *const cap_t) {
    let vptr = cap_frame_cap_get_capFMappedAddress(_frame_cap);
    let lvl1pt = cap_get_capPtr(_vspace_cap);
    let frame_pptr: usize = cap_get_capPtr(_frame_cap);
    let pt_ret = lookupPTSlot(lvl1pt, vptr);

    let targetSlot = pt_ret.ptSlot as *mut usize;
    unsafe {
        *targetSlot = pte_new(
            frame_pptr >> seL4_PageBits,
            0, /* sw */
            1, /* dirty (reserved non-leaf) */
            1, /* accessed (reserved non-leaf) */
            0, /* global */
            1, /* user (reserved non-leaf) */
            1, /* execute */
            1, /* write */
            1, /* read */
            1, /* valid */
        );
        sfence();
        // println!(
        //     "frame cap targetSlot:{:#x} *targetSlot:{:#x}",
        //     targetSlot as usize, *targetSlot
        // );
    }
}

#[inline]
pub fn isPTEPageTable(_pte: usize) -> bool {
    let pte = _pte as *const usize;
    pte_ptr_get_valid(pte) != 0
        && !(pte_ptr_get_read(pte) != 0
            || pte_ptr_get_write(pte) != 0
            || pte_ptr_get_execute(pte) != 0)
}

#[inline]
pub fn getPPtrFromHWPTE(pte: usize) -> usize {
    paddr_to_pptr(pte_ptr_get_ppn(pte as *const usize) << seL4_PageTableBits)
}

pub fn lookupPTSlot(lvl1pt: usize, vptr: vptr_t) -> lookupPTSlot_ret_t {
    let mut level = CONFIG_PT_LEVELS - 1;
    let mut pt = lvl1pt;
    // println!("vptr:{:#x}", vptr);
    let mut ret = lookupPTSlot_ret_t {
        ptBitsLeft: PT_INDEX_BITS * level + seL4_PageBits,
        ptSlot: pt + ((vptr >> (PT_INDEX_BITS * level + seL4_PageBits)) & MASK!(PT_INDEX_BITS)) * 8,
    };
    // unsafe {
    //     println!(
    //         "ptSlot:{:#x} , isPTEPageTable:{},*ptSlot:{:#x}",
    //         ret.ptSlot,
    //         isPTEPageTable(ret.ptSlot),
    //         *(ret.ptSlot as *const usize)
    //     );
    // }
    while isPTEPageTable(ret.ptSlot) && level > 0 {
        // unsafe {
        //     println!(
        //         "i:{} ptSlot:{:#x} , isPTEPageTable:{},*ptSlot:{:#x}",
        //         level,
        //         ret.ptSlot,
        //         isPTEPageTable(ret.ptSlot),
        //         *(ret.ptSlot as *const usize)
        //     );
        // }
        level -= 1;
        ret.ptBitsLeft -= PT_INDEX_BITS;
        pt = pte_ptr_get_ppn(ret.ptSlot as *const usize) << seL4_PageTableBits;
        ret.ptSlot = pt + ((vptr >> ret.ptBitsLeft) & MASK!(PT_INDEX_BITS)) * 8;
    }
    ret
}

pub fn create_unmapped_it_frame_cap(pptr: pptr_t, use_large: bool) -> *const cap_t {
    cap_frame_cap_new(0, pptr, 0, 0, 0, 0)
}

pub fn create_it_pt_cap(
    vspace_cap: *const cap_t,
    pptr: pptr_t,
    vptr: vptr_t,
    asid: usize,
) -> *const cap_t {
    let cap = cap_page_table_cap_new(asid, pptr, 1, vptr);
    map_it_pt_cap(vspace_cap, cap);
    return cap;
}

pub fn create_it_frame_cap(vspace_cap: *const cap_t,
    pptr: pptr_t,
    vptr: vptr_t,
    asid: usize)->*const cap_t{
    let cap=cap_frame_cap_new(asid,pptr,12,VMReadWrite,0,vptr);
    map_it_frame_cap(vspace_cap, cap);
    cap
}

pub fn copyGlobalMappings(Lvl1pt: usize) {
    let mut i: usize = RISCV_GET_PT_INDEX(0x80000000, 0);
    while i < BIT!(PT_INDEX_BITS) {
        unsafe {
            let newLvl1pt = (Lvl1pt + i * 8) as *mut usize;
            *newLvl1pt = kernel_root_pageTable[i];
            i += 1;
        }
    }
}

// pub fn unmapPageTable(asid:usize,vptr:vptr_t,target_pt:pte_t){

// }

pub fn write_it_asid_pool(it_ap_cap: *const cap_t, it_lvl1pt_cap: *const cap_t) {
    let ap = cap_get_capPtr(it_ap_cap);
    unsafe {
        let ptr = (ap + 8 * IT_ASID) as *mut usize;
        *ptr = cap_get_capPtr(it_lvl1pt_cap);
        riscvKSASIDTable[IT_ASID >> asidLowBits] = ap;
    }
}

pub fn findVSpaceForASID(asid: asid_t) -> findVSpaceForASID_ret {
    let mut ret = findVSpaceForASID_ret {
        status: exception_t::EXCEPTION_FAULT,
        vspace_root: 0,
    };
    let mut vspace_root: usize = 0;
    let mut poolPtr: usize = 0;
    unsafe {
        poolPtr = riscvKSASIDTable[asid >> asidLowBits];
    }
    if poolPtr == 0 {
        return ret;
    }
    unsafe {
        vspace_root = *((poolPtr + (asid & MASK!(asidLowBits)) * 8) as *const usize);
    }
    if vspace_root == 0 {
        return ret;
    }
    ret.vspace_root = vspace_root;
    ret.status = exception_t::EXCEPTION_NONE;
    return ret;
}

pub fn unmapPageTable(asid: asid_t, vptr: vptr_t, target_pt: pte_t) {
    let find_ret = findVSpaceForASID(asid);
    if find_ret.status != exception_t::EXCEPTION_NONE {
        return;
    }
    let mut pt = find_ret.vspace_root;
    let mut ptSlot = 0;
    let mut i = 0;
    while i < CONFIG_PT_LEVELS - 1 && pt != target_pt {
        ptSlot = pt + RISCV_GET_PT_INDEX(vptr, i);
        if isPTEPageTable(ptSlot) {
            return;
        }
        pt = getPPtrFromHWPTE(ptSlot);
        i += 1;
    }

    if pt != target_pt {
        return;
    }
    unsafe {
        let slot = ptSlot as *mut usize;
        *slot = pte_new(
            0, /* phy_address */
            0, /* sw */
            0, /* dirty (reserved non-leaf) */
            0, /* accessed (reserved non-leaf) */
            0, /* global */
            0, /* user (reserved non-leaf) */
            0, /* execute */
            0, /* write */
            0, /* read */
            0, /* valid */
        );
        sfence();
    }
}

pub fn unmapPage(page_size: usize, asid: asid_t, vptr: vptr_t, pptr: pptr_t) {
    let find_ret = findVSpaceForASID(asid);
    if find_ret.status != exception_t::EXCEPTION_NONE {
        return;
    }
    let lu_ret = lookupPTSlot(find_ret.vspace_root, vptr);

    if lu_ret.ptBitsLeft != pageBitsForSize(page_size) {
        return;
    }

    if !(pte_ptr_get_valid(lu_ret.ptSlot as *const usize) != 0)
        || isPTEPageTable(lu_ret.ptBitsLeft)
        || (pte_ptr_get_ppn(lu_ret.ptSlot as *const usize) << seL4_PageBits) != pptr_to_paddr(pptr)
    {
        return;
    }
    unsafe {
        let slot = lu_ret.ptSlot as *mut usize;
        *slot = 0;
        sfence();
    }
}

pub fn setVMRoot(thread: *mut tcb_t) {
    unsafe {
        let threadRoot = (*(*thread).rootCap[tcbVTable]).cap;
        if cap_get_capType(threadRoot) != cap_page_table_cap {
            setVSpaceRoot(kernel_root_pageTable.as_ptr() as usize, 0);
            return;
        }
        let lvl1pt = cap_page_table_cap_get_capPTBasePtr(threadRoot);
        let asid = cap_page_table_cap_get_capPTMappedASID(threadRoot);
        // let find_ret = findVSpaceForASID(asid);
        // if find_ret.status != exception_t::EXCEPTION_NONE || find_ret.vspace_root != lvl1pt {
        //     setVSpaceRoot(kernel_root_pageTable.as_ptr() as usize, 0);
        //     return;
        // }
        setVSpaceRoot(lvl1pt, asid);
        // let slot = lookupPTSlot(lvl1pt, 0xc0000000);
        // println!(
        //     "lvl1pt:{:#x} ,slot:{:#x}, *slot:{:#x}",
        //     lvl1pt,
        //     slot.ptSlot,
        //     *(slot.ptSlot as *const usize)
        // );
    }
}

pub fn arch_get_n_paging(it_v_reg: v_region_t) -> usize {
    let mut n: usize = 0;
    let mut i = 0;
    while i < CONFIG_PT_LEVELS - 1 {
        n += get_n_paging(it_v_reg, RISCV_GET_LVL_PGSIZE_BITS(i));
        i += 1;
    }
    return n;
}

// pub fn deleteASID(asid:asid_t,vspace:pte_t){
//     unsafe{
//         let poolPtr = riscvKSASIDTable[asid>>asidLowBits];
//         if poolPtr!=0 &&
//     }
// }

pub fn create_it_address_space(
    root_cnode_cap: *const cap_t,
    it_v_reg: v_region_t,
    vspace: usize,
) -> *const cap_t {
    unsafe {
        copyGlobalMappings(vspace);
        let lvl1pt_cap = cap_page_table_cap_new(IT_ASID, vspace, 1, vspace);
        write_slot(
            (rootserver.cnode + mem::size_of::<cte_t>() * seL4_CapInitThreadVspace) as *const cte_t,
            lvl1pt_cap,
        );
        let mut i = 0;
        while i < CONFIG_PT_LEVELS - 1 {
            let mut pt_vptr = ROUND_DOWN!(it_v_reg.start, RISCV_GET_LVL_PGSIZE_BITS(i));
            while pt_vptr < it_v_reg.end {
                if !provide_cap(
                    root_cnode_cap,
                    create_it_pt_cap(lvl1pt_cap, it_alloc_paging(), pt_vptr, IT_ASID),
                ) {
                    return cap_null_cap_new();
                }
                pt_vptr += RISCV_GET_LVL_PGSIZE(i);
            }
            i += 1;
        }
        lvl1pt_cap
    }
}

pub fn create_address_space_unalloced(
    root_cnode_cap: *const cap_t,
    it_v_reg: v_region_t,
    vspace: usize,
) -> *const cap_t {
    copyGlobalMappings(vspace);
    let lvl1pt_cap = cap_page_table_cap_new(2, vspace, 1, vspace);
    let n = arch_get_n_paging(it_v_reg);
    let size = n * PAGE_SIZE;
    let layout = Layout::from_size_align(size, 4).ok().unwrap();
    let ptr1: usize;
    unsafe {
        ptr1 = alloc::alloc::alloc(layout) as usize;
    }
    let mut i = 0;
    let mut cnt = seL4_NumInitialCaps;
    while i < CONFIG_PT_LEVELS - 1 {
        let mut pt_vptr = ROUND_DOWN!(it_v_reg.start, RISCV_GET_LVL_PGSIZE_BITS(i));
        let mut ptr = ptr1;
        while pt_vptr < it_v_reg.end {
            write_slot(
                (cap_get_capPtr(root_cnode_cap) + mem::size_of::<cte_t>() * cnt) as *const cte_t,
                create_it_pt_cap(lvl1pt_cap, ptr, pt_vptr, IT_ASID),
            );
            ptr += RISCV_GET_LVL_PGSIZE(i);
            pt_vptr += RISCV_GET_LVL_PGSIZE(i);
            cnt += 1;
        }
        i += 1;
    }
    lvl1pt_cap
}

pub fn create_address_space_alloced(
    cnode: usize,
    root_cnode_cap: *const cap_t,
    it_v_reg: v_region_t,
    it_p_reg: p_region_t,
    vspace: usize,
) -> *const cap_t {
    copyGlobalMappings(vspace);
    let lvl1pt_cap = cap_page_table_cap_new(0, vspace, 1, vspace);
    write_slot(
        (cnode + mem::size_of::<cte_t>() * seL4_CapInitThreadVspace) as *const cte_t,
        lvl1pt_cap,
    );
    let mut allocated = vspace;
    let mut i = 0;
    let mut cnt = seL4_NumInitialCaps + 20;
    while i < CONFIG_PT_LEVELS - 1 {
        let mut pt_vptr = ROUND_DOWN!(it_v_reg.start, RISCV_GET_LVL_PGSIZE_BITS(i));
        allocated += BIT!(seL4_PageTableBits);
        while pt_vptr < it_v_reg.end {
            write_slot(
                (cap_get_capPtr(root_cnode_cap) + mem::size_of::<cte_t>() * cnt) as *const cte_t,
                create_it_pt_cap(lvl1pt_cap, allocated, pt_vptr, 0),
            );
            pt_vptr += RISCV_GET_LVL_PGSIZE(i);
            cnt += 1;
        }
        i += 1;
    }

    let mut pt_vptr = ROUND_DOWN!(it_v_reg.start, RISCV_GET_LVL_PGSIZE_BITS(2));
    let mut ptr: usize = ROUND_DOWN!(it_p_reg.start, RISCV_GET_LVL_PGSIZE_BITS(2));
    while ptr < it_p_reg.end {
        // println!("ptr :{:#x} , vptr:{:#x}", ptr, pt_vptr);
        unsafe {
            let target_slot = lookupPTSlot(vspace, pt_vptr).ptSlot as *mut usize;
            *target_slot = user_pte_next(ptr, true);
            // println!(
            //     "slot:{:#x}, *target_slot:{:#x}",
            //     target_slot as usize, *target_slot
            // );
        }
        pt_vptr += RISCV_GET_LVL_PGSIZE(2);
        ptr += RISCV_GET_LVL_PGSIZE(2);
    }
    lvl1pt_cap
}

pub fn lookupIPCBuffer(isReceiver: bool, thread: *mut tcb_t) -> usize {
    unsafe {
        let w_bufferPtr = (*thread).tcbIPCBuffer;
        let bufferCap = (*(*thread).rootCap[tcbBuffer]).cap;
        if cap_get_capType(bufferCap) != cap_frame_cap {
            return 0;
        }
        if cap_frame_cap_get_capFIsDevice(bufferCap) != 0 {
            return 0;
        }

        let vm_rights = cap_frame_cap_get_capFVMRights(bufferCap);
        if vm_rights == VMReadWrite || (!isReceiver && vm_rights == VMReadOnly) {
            let basePtr = cap_frame_cap_get_capFBasePtr(bufferCap);
            let pageBits = pageBitsForSize(cap_frame_cap_get_capFSize(bufferCap));
            return basePtr + w_bufferPtr & MASK!(pageBits);
        }
        0
    }
}


// 0x8021c000
// 0x8021d000
// 0x8021e000