use core::{alloc::Layout, arch::asm, mem};

use crate::{
    config::{
        seL4_ASIDPoolBits, seL4_CapDomain, seL4_CapInitThreadCNode, seL4_MsgMaxExtraCaps,
        seL4_NumInitialCaps, seL4_PageBits, seL4_PageTableBits, seL4_SlotBits, seL4_TCBBits,
        seL4_VSpaceBits, BI_FRAME_SIZE_BITS, CONFIG_ROOT_CNODE_SIZE_BITS, MAX_NUM_FREEMEM_REG,
        MAX_NUM_RESV_REG, SIE_SEIE, SIE_STIE,
    },
    println, traps, BIT, ROUND_DOWN, ROUND_UP, trap,
};

use super::{
    object::{
        objecttype::cap_get_capPtr,
        structures::{
            cap_cnode_cap_new, cap_domain_cap_new, cap_t, cte_t, mdb_node_set_mdbFirstBadged,
            mdb_node_set_mdbRevocable, mdb_node_t,
        },
    },
    vspace::{
        activate_kernel_vspace, arch_get_n_paging, map_kernel_window, paddr_to_pptr, pptr_to_paddr,
    },
};

type seL4_SlotPos = usize;

#[derive(Copy, Clone)]
pub struct seL4_SlotRegion {
    pub start: seL4_SlotPos,
    pub end: seL4_SlotPos,
}
#[derive(Copy, Clone)]
pub struct extra_caps_t {
    pub excaprefs: [*const cte_t; seL4_MsgMaxExtraCaps],
}
pub static mut current_extra_caps: extra_caps_t = extra_caps_t {
    excaprefs: [0 as *const cte_t; seL4_MsgMaxExtraCaps],
};
#[derive(Copy, Clone)]
pub struct seL4_BootInfo {
    pub extraLen: usize,
    pub nodeID: usize,
    pub numNodes: usize,
    pub numIOPTLevels: usize,
    pub ipcBuffer: *const usize,
    pub empty: seL4_SlotRegion,
    pub sharedFrames: seL4_SlotRegion,
    pub userImageFrames: seL4_SlotRegion,
    pub initThreadCNodeSizeBits: usize,
    pub initThreadDomain: usize,
    pub untyped: seL4_SlotRegion,
}

#[derive(Copy, Clone)]
pub struct region_t {
    pub start: usize,
    pub end: usize,
}

#[derive(Copy, Clone)]
pub struct p_region_t {
    pub start: usize,
    pub end: usize,
}

#[derive(Copy, Clone)]
pub struct v_region_t {
    pub start: usize,
    pub end: usize,
}

#[derive(Copy, Clone)]
pub struct ndks_boot_t {
    pub reserved: [p_region_t; MAX_NUM_RESV_REG],
    pub resv_count: usize,
    pub freemem: [region_t; MAX_NUM_FREEMEM_REG],
    pub bi_frame: *const seL4_BootInfo,
    pub slot_pos_cur: seL4_SlotPos,
}

#[derive(Copy, Clone)]
pub struct rootserver_mem_t {
    pub cnode: usize,
    pub vspace: usize,
    pub asid_pool: usize,
    pub ipc_buf: usize,
    pub boot_info: usize,
    pub extra_bi: usize,
    pub tcb: usize,
    pub paging: region_t,
}

#[inline]
pub fn is_reg_empty(reg: region_t) -> bool {
    reg.start == reg.end
}

pub static mut rootserver: rootserver_mem_t = rootserver_mem_t {
    cnode: 0,
    vspace: 0,
    asid_pool: 0,
    ipc_buf: 0,
    boot_info: 0,
    extra_bi: 0,
    tcb: 0,
    paging: region_t {
        start: (0),
        end: (0),
    },
};
static mut rootserver_mem: region_t = region_t { start: 0, end: 0 };
static mut ndks_boot: ndks_boot_t = ndks_boot_t {
    reserved: [p_region_t { start: 0, end: 0 }; MAX_NUM_RESV_REG],
    resv_count: 16,
    freemem: [region_t { start: 0, end: 0 }; MAX_NUM_FREEMEM_REG],
    bi_frame: 0 as *const seL4_BootInfo,
    slot_pos_cur: seL4_NumInitialCaps,
};

#[inline]
pub fn merge_regions() {
    unsafe {
        let mut i = 1;
        while i < ndks_boot.resv_count {
            if ndks_boot.reserved[i - 1].end == ndks_boot.reserved[i].start {
                ndks_boot.reserved[i - 1].end = ndks_boot.reserved[i].end;
                let mut j = i + 1;
                while j < ndks_boot.resv_count {
                    ndks_boot.reserved[j - 1] = ndks_boot.reserved[j];
                    j += 1;
                }
                ndks_boot.resv_count -= 1;
            } else {
                i += 1;
            }
        }
    }
}

pub fn reserve_region(reg: p_region_t) -> bool {
    unsafe {
        assert!(reg.start <= reg.end);
        if reg.start <= reg.end {
            return true;
        }

        let mut i = 0;
        while i < ndks_boot.resv_count {
            if ndks_boot.reserved[i].start == reg.end {
                ndks_boot.reserved[i].start = reg.start;
                merge_regions();
                return true;
            }
            if ndks_boot.reserved[i].end == reg.start {
                ndks_boot.reserved[i].end = reg.end;
                merge_regions();
                return true;
            }
            if ndks_boot.reserved[i].start > reg.end {
                if ndks_boot.resv_count + 1 >= MAX_NUM_RESV_REG {
                    println!("Can't mark region 0x{}-0x{} as reserved, try increasing MAX_NUM_RESV_REG (currently {})\n",reg.start,reg.end,MAX_NUM_RESV_REG);
                    return false;
                }
                let mut j = ndks_boot.resv_count;
                while j > i {
                    ndks_boot.reserved[j] = ndks_boot.reserved[j - 1];
                    j -= 1;
                }
                ndks_boot.reserved[i] = reg;
                ndks_boot.resv_count += 1;
                return true;
            }
            i += 1;
        }
        if i + 1 == MAX_NUM_RESV_REG {
            println!("Can't mark region 0x{}-0x{} as reserved, try increasing MAX_NUM_RESV_REG (currently {})\n",reg.start,reg.end,MAX_NUM_RESV_REG);
            return false;
        }
        ndks_boot.reserved[i] = reg;
        ndks_boot.resv_count += 1;
        return true;
    }
}

#[inline]
pub fn pptr_to_paddr_reg(reg: region_t) -> p_region_t {
    p_region_t {
        start: pptr_to_paddr(reg.start),
        end: pptr_to_paddr(reg.end),
    }
}

#[inline]
pub fn paddr_to_pptr_reg(reg: p_region_t) -> region_t {
    region_t {
        start: paddr_to_pptr(reg.start),
        end: paddr_to_pptr(reg.end),
    }
}

pub fn insert_region(reg: region_t) -> bool {
    unsafe {
        assert!(reg.start <= reg.end);

        if is_reg_empty(reg) {
            return true;
        }
        let mut i = 0;
        while i < ndks_boot.freemem.len() {
            if is_reg_empty(ndks_boot.freemem[i]) {
                reserve_region(pptr_to_paddr_reg(reg));
                ndks_boot.freemem[i] = reg;
                return true;
            }
            i += 1;
        }
    }
    println!(
        "no free memory slot left for [{}..{}],
     consider increasing MAX_NUM_FREEMEM_REG (%{})\n",
        reg.start, reg.end, MAX_NUM_FREEMEM_REG
    );
    assert!(false);
    return false;
}

pub fn alloc_rootserver_obj(size_bits: usize, n: usize) -> usize {
    unsafe {
        let allocated = rootserver_mem.start;
        assert!(allocated % BIT!(size_bits) == 0);
        rootserver_mem.start += n * BIT!(size_bits);
        assert!(rootserver_mem.start <= rootserver_mem.end);
        allocated
    }
}

pub fn maybe_alloc_extra_bi(cmp_size_bits: usize, extra_bi_size_bits: usize) {
    unsafe {
        if extra_bi_size_bits >= cmp_size_bits && rootserver.extra_bi == 0 {
            rootserver.extra_bi = alloc_rootserver_obj(extra_bi_size_bits, 1);
        }
    }
}

pub fn calcaulate_rootserver_size(it_v_reg: v_region_t, extra_bi_size_bits: usize) -> usize {
    let mut size = BIT!(CONFIG_ROOT_CNODE_SIZE_BITS + seL4_SlotBits);
    size += BIT!(seL4_TCBBits);
    size += BIT!(seL4_PageBits);
    size += BIT!(BI_FRAME_SIZE_BITS);
    size += BIT!(seL4_ASIDPoolBits);
    size += if extra_bi_size_bits > 0 {
        BIT!(extra_bi_size_bits)
    } else {
        0
    };
    size += BIT!(seL4_VSpaceBits);
    return size + arch_get_n_paging(it_v_reg);
}

#[inline]
pub fn get_n_paging(v_reg: v_region_t, bits: usize) -> usize {
    let start = ROUND_DOWN!(v_reg.start, bits);
    let end = ROUND_UP!(v_reg.end, bits);
    (end - start) / BIT!(bits)
}

#[inline]
pub fn it_alloc_paging() -> usize {
    unsafe {
        let allocated = rootserver.paging.start;
        rootserver.paging.start += BIT!(seL4_PageTableBits);
        assert!(rootserver.paging.start <= rootserver.paging.end);
        allocated
    }
}

pub fn rootserver_max_size_bits(extra_bi_size_bits: usize) -> usize {
    let cnode_size_bits = CONFIG_ROOT_CNODE_SIZE_BITS + seL4_SlotBits;
    let maxx = if cnode_size_bits > seL4_VSpaceBits {
        cnode_size_bits
    } else {
        seL4_VSpaceBits
    };
    if maxx > extra_bi_size_bits {
        maxx
    } else {
        extra_bi_size_bits
    }
}

pub fn create_rootserver_objects(start: usize, it_v_reg: v_region_t, extra_bi_size_bits: usize) {
    unsafe {
        let cnode_size_bits = CONFIG_ROOT_CNODE_SIZE_BITS + seL4_SlotBits;
        let max = rootserver_max_size_bits(extra_bi_size_bits);

        let size = calcaulate_rootserver_size(it_v_reg, extra_bi_size_bits);
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr: *mut u8 = alloc::alloc::alloc(layout);
        rootserver_mem.start = ptr as usize;
        rootserver_mem.end = ptr as usize + size;
        maybe_alloc_extra_bi(max, extra_bi_size_bits);

        rootserver.cnode = alloc_rootserver_obj(cnode_size_bits, 1);
        maybe_alloc_extra_bi(seL4_VSpaceBits, extra_bi_size_bits);
        rootserver.vspace = alloc_rootserver_obj(seL4_VSpaceBits, 1);

        maybe_alloc_extra_bi(seL4_PageBits, extra_bi_size_bits);
        rootserver.asid_pool = alloc_rootserver_obj(seL4_ASIDPoolBits, 1);
        rootserver.ipc_buf = alloc_rootserver_obj(seL4_PageBits, 1);
        rootserver.boot_info = alloc_rootserver_obj(BI_FRAME_SIZE_BITS, 1);

        let n = arch_get_n_paging(it_v_reg);
        rootserver.paging.start = alloc_rootserver_obj(seL4_PageTableBits, n);
        rootserver.paging.end = rootserver.paging.start + n * BIT!(seL4_PageTableBits);
        rootserver.tcb = alloc_rootserver_obj(seL4_TCBBits, 1);

        assert!(rootserver_mem.start == rootserver_mem.end);
    }
}

pub fn write_slot(_slot_ptr: *const cte_t, cap: *const cap_t) {
    unsafe {
        let slot_ptr = _slot_ptr as *mut cte_t;
        (*slot_ptr).cap = cap as *mut cap_t;
        *(*slot_ptr).cteMDBNode = mdb_node_t::default();
        (*slot_ptr).cteMDBNode =
            mdb_node_set_mdbRevocable((*slot_ptr).cteMDBNode, 1) as *mut mdb_node_t;
        (*slot_ptr).cteMDBNode =
            mdb_node_set_mdbFirstBadged((*slot_ptr).cteMDBNode, 1) as *mut mdb_node_t;
    }
}

pub fn create_root_cnode() -> *const cap_t {
    unsafe {
        let cap = cap_cnode_cap_new(
            CONFIG_ROOT_CNODE_SIZE_BITS,
            BIT!(6) - CONFIG_ROOT_CNODE_SIZE_BITS,
            0,
            rootserver.cnode,
        );
        write_slot(
            (rootserver.cnode + mem::size_of::<cte_t>() * seL4_CapInitThreadCNode) as *const cte_t,
            cap,
        );
        cap
    }
}

#[inline]
pub fn clearMemory(ptr: *mut u8, bits: usize) {
    unsafe {
        core::slice::from_raw_parts_mut(ptr, BIT!(bits)).fill(0);
    }
}

pub fn create_domain_cap(root_cnode_cap: *const cap_t) {
    let cap = cap_domain_cap_new();
    write_slot(
        (cap_get_capPtr(root_cnode_cap) + seL4_CapDomain * mem::size_of::<cte_t>()) as *const cte_t,
        cap,
    );
}

#[inline]
pub fn set_sie_mask(mask_high: usize) {
    unsafe {
        let mut temp: usize;
        asm!("csrrs {0},sie,{1}",out(reg)temp,in(reg)mask_high);
    }
}

pub fn provide_cap(root_cnode_cap: *const cap_t, cap: *const cap_t) -> bool {
    unsafe {
        if ndks_boot.slot_pos_cur >= BIT!(CONFIG_ROOT_CNODE_SIZE_BITS) {
            println!(
                "ERROR: can't add another cap, all {} slots used\n",
                BIT!(CONFIG_ROOT_CNODE_SIZE_BITS)
            );
            return false;
        }
        write_slot(
            (rootserver.cnode + mem::size_of::<cte_t>() * ndks_boot.slot_pos_cur) as *const cte_t,
            cap,
        );
        ndks_boot.slot_pos_cur += 1;
        true
    }
}

pub fn try_inital_kernel() {
    // traps::init();
    trap::init();
    set_sie_mask(BIT!(SIE_SEIE) | BIT!(SIE_STIE));
    // traps::enable_timer_interrupt();
    trap::enable_timer_interrupt();
    // let size=calcaulate_rootserver_size(it_v_reg, extra_bi_size_bits);
    // let root_cnode_cap = create_root_cnode();
    // create_domain_cap(root_cnode_cap);
}
