extern crate alloc;

use crate::kernel::object::{objecttype::*, structures::*};
use crate::{BIT, MASK};
use core::default::Default;
use core::intrinsics::likely;
use core::{cell::RefCell, intrinsics::unlikely};

use super::structures::{cap_t, cte_t, exception_t};

pub const wordRadix: usize = 6;

#[derive(PartialEq)]
pub struct lookupCap_ret_t {
    status: exception_t,
    cap: *const cap_t,
}

impl Default for lookupCap_ret_t {
    fn default() -> Self {
        lookupCap_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: (&cap_t::default()) as *const cap_t,
        }
    }
}

#[derive(PartialEq)]
pub struct lookupCapAndSlot_ret_t {
    status: exception_t,
    cap: *const cap_t,
    slot: *const cte_t,
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
    status: exception_t,
    slot: *const cte_t,
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
    status: exception_t,
    slot: *const cte_t,
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
        if unlikely(cap_get_capType(_nodeCap) != cap_cnode_cap) {
            ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
            return ret;
        }

        while true {
            radixBits = cap_cnode_cap_get_capCNodeRadix(_nodeCap);
            guardBits = cap_cnode_cap_get_capCNodeGuardSize(_nodeCap);
            levelBits = radixBits + guardBits;
            assert!(levelBits != 0);
            capGuard = cap_cnode_cap_get_capCNodeGuard(_nodeCap);
            guard = (capptr >> ((n_bits - guardBits) & MASK!(wordRadix))) & MASK!(guardBits);

            if unlikely(guardBits > n_bits || guard != capGuard) {
                ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
                return ret;
            }

            if unlikely(levelBits > n_bits) {
                ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
                return ret;
            }
            offset = (capptr >> (n_bits - levelBits)) & MASK!(radixBits);
            slot = ((cap_cnode_cap_get_capCNodePtr(_nodeCap)) + offset) as *mut cte_t;

            if likely(n_bits == levelBits) {
                ret.slot = slot;
                ret.bitsRemaining = 0;
                return ret;
            }

            n_bits -= levelBits;
            nodeCap = (*slot).cap;
            if unlikely(cap_get_capType(_nodeCap) != cap_cnode_cap) {
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
    let wordBits = BIT!(wordRadix);
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
