use core::cell::RefCell;

use alloc::rc::Rc;

use crate::{
    config::{
        seL4_ASIDPoolBits, seL4_PageBits, seL4_PageTableBits, seL4_SlotBits, seL4_TCBBits,
        seL4_VSpaceBits, BI_FRAME_SIZE_BITS, CONFIG_ROOT_CNODE_SIZE_BITS, MAX_NUM_FREEMEM_REG,
        MAX_NUM_RESV_REG,
    },
    println, BIT, ROUND_DOWN, ROUND_UP,
};

use super::{
    object::structures::{
        cap_t, cte_t, mdb_node_set_mdbFirstBadged, mdb_node_set_mdbRevocable, mdb_node_t, cap_cnode_cap_new,
    },
    vspace::{arch_get_n_paging, paddr_to_pptr, pptr_to_paddr},
};

type seL4_SlotPos = usize;

#[derive(Copy, Clone)]
pub struct seL4_SlotRegion {
    pub start: seL4_SlotPos,
    pub end: seL4_SlotPos,
}

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
    cnode: usize,
    vspace: usize,
    asid_pool: usize,
    ipc_buf: usize,
    boot_info: usize,
    extra_bi: usize,
    tcb: usize,
    paging: region_t,
}

#[inline]
pub fn is_reg_empty(reg: region_t) -> bool {
    reg.start == reg.end
}

static mut rootserver: rootserver_mem_t = rootserver_mem_t {
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
static mut ndks_boot: ndks_boot_t = unsafe {
    ndks_boot_t {
        reserved: [p_region_t { start: 0, end: 0 }; MAX_NUM_RESV_REG],
        resv_count: 16,
        freemem: [region_t { start: 0, end: 0 }; MAX_NUM_FREEMEM_REG],
        bi_frame: 0 as *const seL4_BootInfo,
        slot_pos_cur: 0,
    }
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
        core::slice::from_raw_parts_mut(allocated as *mut u8, n * BIT!(size_bits)).fill(0);
        allocated
    }
}

// pub fn rootserver_max_size_bits(extra_bi_size_bits: usize) -> usize {
//     let cnode_size_bits = CONFIG_ROOT_CNODE_SIZE_BITS + seL4_SlotBits;
// }

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
        rootserver_mem.start = start;
        rootserver_mem.end = start + size;
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

pub fn write_slot(slot_ptr: Rc<RefCell<cte_t>>, cap: Rc<RefCell<cap_t>>) {
    slot_ptr.borrow_mut().cap = cap.clone();
    slot_ptr.borrow_mut().cteMDBNode = Rc::new(RefCell::new(mdb_node_t::default()));
    slot_ptr.borrow_mut().cteMDBNode =
        mdb_node_set_mdbRevocable(slot_ptr.borrow().cteMDBNode.clone(), 1);
    slot_ptr.borrow_mut().cteMDBNode =
        mdb_node_set_mdbFirstBadged(slot_ptr.borrow().cteMDBNode.clone(), 1);
}

pub fn create_root_cnode() -> Rc<RefCell<cap_t>> {
    unsafe {
        let cap = cap_cnode_cap_new(
            CONFIG_ROOT_CNODE_SIZE_BITS,
            6 - CONFIG_ROOT_CNODE_SIZE_BITS,
            0,
            rootserver.cnode,
        );
        cap
        //FIXEME :: HOW to use insert the cap slot???
        // write_slot(,cap.clone());
    }
}

