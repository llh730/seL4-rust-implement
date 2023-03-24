use core::arch::asm;
use core::cell::RefCell;
use core::mem;
use lazy_static::*;
use riscv::register::satp;

use crate::{config::*, println, BIT, MASK, ROUND_DOWN};

use super::boot::{get_n_paging, rootserver, v_region_t, write_slot};
use super::object::structures::{
    cap_capType_equals, cap_frame_cap_get_capFMappedAddress, cap_frame_cap_new, cap_get_capType,
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

#[inline]
pub fn pageBitsForSize(pagesize: vm_page_size_t) -> usize {
    match pagesize {
        vm_page_size_t::RISCV_4K_Page => RISCVPageBits,
        vm_page_size_t::RISCV_Mega_Page => RISCVMegaPageBits,
        vm_page_size_t::RISCV_Giga_Page => RISCVGigaPageBits,
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
    core::arch::asm!("sfence.vma x0,x0");
}

#[inline]
#[no_mangle]
pub fn setVSpaceRoot(addr: paddr_t, asid: usize) {
    let satp = satp_new(8usize, asid, addr >> 12);
    unsafe {
        let mut temp: usize = 1 << 13;
        unsafe {
            satp::write(satp.words);
            sfence();
        }
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
    let index = 0;
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
    let mut temp: usize;

    // extern "C" {
    //     fn stext();
    //     fn etext();
    // }
    // unsafe {
    //     let mut text_ptr = stext as usize;
    //     while text_ptr < etext as usize {
    //         kernel_root_pageTable[RISCV_GET_PT_INDEX(text_ptr, 0)] =
    //             pte_next(text_ptr as usize, true);
    //         text_ptr+=RISCV_GET_LVL_PGSIZE(0);
    //     }
    // }
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
            pptr_to_paddr(pt) >> seL4_PageBits,
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
            pptr_to_paddr(frame_pptr) >> seL4_PageBits,
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
    let mut ret = lookupPTSlot_ret_t {
        ptBitsLeft: PT_INDEX_BITS * level + seL4_PageBits,
        ptSlot: pt + ((vptr >> (PT_INDEX_BITS * level + seL4_PageBits)) & MASK!(PT_INDEX_BITS)),
    };

    while isPTEPageTable(ret.ptSlot) && level > 0 {
        level -= 1;
        ret.ptBitsLeft -= PT_INDEX_BITS;
        pt = getPPtrFromHWPTE(ret.ptSlot);
        ret.ptSlot = pt + ((vptr >> ret.ptBitsLeft) & MASK!(PT_INDEX_BITS));
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

pub fn copyGlobalMappings(Lvl1pt: usize) {
    let i: usize = RISCV_GET_PT_INDEX(PPTR_BASE, 0);
    while i < BIT!(PT_INDEX_BITS) {
        unsafe {
            let newLvl1pt = (Lvl1pt + i * 8) as *mut usize;
            *newLvl1pt = kernel_root_pageTable[i];
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

pub fn unmapPage(page_size: vm_page_size_t, asid: asid_t, vptr: vptr_t, pptr: pptr_t) {
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
        let threadRoot = (*thread).rootCap[tcbVTable];
        if cap_get_capType(threadRoot) != cap_page_table_cap {
            setVSpaceRoot(kernel_root_pageTable.as_ptr() as usize, 0);
            return;
        }
        let lvl1pt = cap_page_table_cap_get_capPTBasePtr(threadRoot);
        let asid = cap_page_table_cap_get_capPTMappedASID(threadRoot);
        let find_ret = findVSpaceForASID(asid);
        if find_ret.status != exception_t::EXCEPTION_NONE || find_ret.vspace_root != lvl1pt {
            setVSpaceRoot(kernel_root_pageTable.as_ptr() as usize, 0);
            return;
        }
        setVSpaceRoot(pptr_to_paddr(lvl1pt), asid);
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

pub fn create_it_address_space(root_cnode_cap: *const cap_t, it_v_reg: v_region_t) -> *const cap_t {
    unsafe {
        copyGlobalMappings(rootserver.vspace);
        let lvl1pt_cap = cap_page_table_cap_new(IT_ASID, rootserver.vspace, 1, rootserver.vspace);
        write_slot(
            (rootserver.cnode + mem::size_of::<cte_t>() * seL4_CapInitThreadVspace) as *const cte_t,
            lvl1pt_cap,
        );

        let mut i = 0;
        while i < CONFIG_PT_LEVELS - 1 {
            let mut pt_vptr = ROUND_DOWN!(it_v_reg.start, RISCV_GET_LVL_PGSIZE_BITS(i));
            while pt_vptr < it_v_reg.end {
                pt_vptr += RISCV_GET_LVL_PGSIZE(i);
            }
            i += 1;
        }
        lvl1pt_cap
    }
}
