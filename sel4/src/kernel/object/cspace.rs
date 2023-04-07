extern crate alloc;

use crate::config::{tcbCTable, wordBits};
use crate::kernel::object::{objecttype::*, structures::*};
use crate::kernel::thread::tcb_t;
use crate::{MASK, println};
use core::default::Default;
use core::intrinsics::likely;
use core::intrinsics::unlikely;
use core::mem::forget;

use super::structures::{cap_t, cte_t, exception_t};

pub const wordRadix: usize = 6;

#[derive(PartialEq)]
pub struct lookupCap_ret_t {
    pub status: exception_t,
    pub cap: *const cap_t,
}

impl Default for lookupCap_ret_t {
    fn default() -> Self {
        lookupCap_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: (&cap_t::default()) as *const cap_t,
        }
    }
}

#[derive(Clone, Copy)]
pub struct cap_transfer_t {
    pub ctReceiveRoot: usize,
    pub ctReceiveIndex: usize,
    pub ctReceiveDepth: usize,
}

#[derive(PartialEq)]
pub struct lookupCapAndSlot_ret_t {
    pub status: exception_t,
    pub cap: *const cap_t,
    pub slot: *const cte_t,
}

impl Default for lookupCapAndSlot_ret_t {
    fn default() -> Self {
        lookupCapAndSlot_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: (&cap_t::default()) as *const cap_t,
            slot: 0 as *const cte_t,
        }
    }
}

#[derive(PartialEq)]

pub struct lookupSlot_raw_ret_t {
    pub status: exception_t,
    pub slot: *const cte_t,
}

impl Default for lookupSlot_raw_ret_t {
    fn default() -> Self {
        lookupSlot_raw_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: 0 as *const cte_t,
        }
    }
}

pub struct lookupSlot_ret_t {
    pub status: exception_t,
    pub slot: *const cte_t,
}

impl Default for lookupSlot_ret_t {
    fn default() -> Self {
        lookupSlot_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: 0 as *const cte_t,
        }
    }
}

pub struct resolveAddressBits_ret_t {
    status: exception_t,
    slot: *mut cte_t,
    bitsRemaining: usize,
}

impl Default for resolveAddressBits_ret_t {
    fn default() -> Self {
        resolveAddressBits_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: 0 as *mut cte_t,
            bitsRemaining: 0,
        }
    }
}

pub fn lookupSlot(thread: *const tcb_t, capptr: usize) -> lookupSlot_raw_ret_t {
    unsafe {
        let threadRoot = (*(*thread).rootCap[tcbCTable]).cap;
        let res_ret = resolveAddressBits(threadRoot, capptr, wordBits);
        let ret = lookupSlot_raw_ret_t {
            status: res_ret.status,
            slot: res_ret.slot,
        };
        return ret;
    }
}

pub fn lookupCapAndSlot(thread: *const tcb_t, cPtr: usize) -> lookupCapAndSlot_ret_t {
    let lu_ret = lookupSlot(thread, cPtr);
    if lu_ret.status != exception_t::EXCEPTION_NONE {
        panic!("can not find right slot");
    }
    unsafe {
        let ret = lookupCapAndSlot_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: lu_ret.slot,
            cap: (*lu_ret.slot).cap,
        };
        ret
    }
}

pub fn resolveAddressBits(
    _nodeCap: *const cap_t,
    capptr: usize,
    mut n_bits: usize,
) -> resolveAddressBits_ret_t {
    unsafe {
        let mut nodeCap = _nodeCap as *mut cap_t;
        let mut ret = resolveAddressBits_ret_t::default();
        ret.bitsRemaining = n_bits;
        let mut radixBits: usize;
        let mut guardBits: usize;
        let mut guard: usize;
        let mut levelBits: usize;
        let mut capGuard: usize;
        let mut offset: usize;
        let mut slot: *mut cte_t;
        if unlikely(cap_get_capType(nodeCap) != cap_cnode_cap) {
            ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
            return ret;
        }

        while true {
            radixBits = cap_cnode_cap_get_capCNodeRadix(nodeCap);
            guardBits = cap_cnode_cap_get_capCNodeGuardSize(nodeCap);
            levelBits = radixBits + guardBits;
            assert!(levelBits != 0);
            capGuard = cap_cnode_cap_get_capCNodeGuard(nodeCap);
            guard = (capptr >> ((n_bits - guardBits) & MASK!(wordRadix))) & MASK!(guardBits);
            if unlikely(guardBits > n_bits || guard != capGuard) {
                panic!(
                    "guardBits and cap Guard bits not matched ! guard :{:#x}  capGuard :{:#x}",
                    guard, capGuard
                );
            }

            if unlikely(levelBits > n_bits) {
                ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
                return ret;
            }
            offset = (capptr >> (n_bits - levelBits)) & MASK!(radixBits);
            slot = ((cap_cnode_cap_get_capCNodePtr(nodeCap)) + offset) as *mut cte_t;
            if likely(n_bits == levelBits) {
                ret.slot = slot;
                ret.bitsRemaining = 0;
                return ret;
            }
            n_bits -= levelBits;
            nodeCap = (*slot).cap;
            if unlikely(cap_get_capType(nodeCap) != cap_cnode_cap) {
                ret.slot = slot;
                ret.bitsRemaining = n_bits;
                return ret;
            }
        }
        panic!("UNREACHABLE");
    }
}

pub fn lookupSlotFroCNodeOp(
    _isSource: bool,
    root: *const cap_t,
    capptr: usize,
    depth: usize,
) -> lookupSlot_ret_t {
    let mut ret: lookupSlot_ret_t = lookupSlot_ret_t::default();
    if unlikely(cap_get_capType(root) != cap_cnode_cap) {
        ret.status = exception_t::EXCEPTION_SYSCALL_ERROR;
        return ret;
    }
    if unlikely(depth < 1 || depth > wordBits) {
        ret.status = exception_t::EXCEPTION_SYSCALL_ERROR;
        return ret;
    }
    let res_ret = resolveAddressBits(root, capptr, depth);

    if unlikely(res_ret.status != exception_t::EXCEPTION_NONE) {
        ret.status = exception_t::EXCEPTION_SYSCALL_ERROR;
        return ret;
    }

    if unlikely(res_ret.bitsRemaining != 0) {
        ret.status = exception_t::EXCEPTION_SYSCALL_ERROR;
        return ret;
    }
    ret.slot = res_ret.slot;
    ret.status = exception_t::EXCEPTION_NONE;
    return ret;
}

pub fn capTransferFromWords(wptr: usize) -> cap_transfer_t {
    let ptr0 = wptr as *const usize;
    let ptr1 = (wptr + 8) as *const usize;
    let ptr2 = (wptr + 16) as *const usize;
    unsafe {
        let transfer = cap_transfer_t {
            ctReceiveRoot: *ptr0,
            ctReceiveIndex: *ptr1,
            ctReceiveDepth: *ptr2,
        };
        transfer
    }
}

pub fn lookupCap(thread: *const tcb_t, cPtr: usize) -> lookupCap_ret_t {
    let lu_ret = lookupSlot(thread, cPtr);
    if lu_ret.status != exception_t::EXCEPTION_NONE {
        panic!("can not find cap!");
    }
    unsafe {
        lookupCap_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: (*lu_ret.slot).cap,
        }
    }
}

pub fn lookupSlotForCNodeOp(
    _isSource: bool,
    root: *const cap_t,
    capptr: usize,
    depth: usize,
) -> lookupSlot_ret_t {
    if cap_get_capType(root) != cap_cnode_cap {
        panic!(
            "error : root cap is not cnode cap current cap:{}",
            cap_get_capType(root)
        );
    }
    if depth < 1 || depth > wordBits {
        panic!(
            "error : depth should be in range(1,wordBits),current depth:{} ",
            depth
        );
    }
    let res_ret = resolveAddressBits(root, capptr, depth);

    if res_ret.status != exception_t::EXCEPTION_NONE {
        panic!("error : occour in lookup slot");
    }

    if res_ret.bitsRemaining != 0 {
        panic!(" bits Remaining is not zero , current bits Remaining");
    }
    lookupSlot_ret_t {
        status: exception_t::EXCEPTION_NONE,
        slot: res_ret.slot,
    }
}

pub fn lookupTargetSlot(root: *const cap_t, capptr: usize, depth: usize) -> lookupSlot_ret_t {
    lookupSlotForCNodeOp(false, root, capptr, depth)
}

pub fn lookupSourceSlot(root: *const cap_t, capptr: usize, depth: usize) -> lookupSlot_ret_t {
    lookupSlotForCNodeOp(true, root, capptr, depth)
}

pub fn lookupPivotSlot(root: *const cap_t, capptr: usize, depth: usize) -> lookupSlot_ret_t {
    lookupSlotForCNodeOp(true, root, capptr, depth)
}
