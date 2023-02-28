extern crate alloc;

use crate::kernel::object::{objecttype::*, structures::*};
use alloc::rc::Rc;
use core::default::Default;
use core::intrinsics::likely;
use core::{cell::RefCell, intrinsics::unlikely};

use super::structures::{cap_t, cte_t, exception_t};

pub const wordRadix:u64=6;


#[derive(PartialEq)]
pub struct lookupCap_ret_t {
    status: exception_t,
    cap: Rc<RefCell<cap_t>>,
}

impl Default for lookupCap_ret_t {
    fn default() -> Self {
        lookupCap_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: Rc::new(RefCell::new(Default::default())),
        }
    }
}

#[derive(PartialEq)]
pub struct lookupCapAndSlot_ret_t {
    status: exception_t,
    cap: Rc<RefCell<cap_t>>,
    slot: Option<Rc<RefCell<cte_t>>>,
}

impl Default for lookupCapAndSlot_ret_t {
    fn default() -> Self {
        lookupCapAndSlot_ret_t {
            status: exception_t::EXCEPTION_NONE,
            cap: Rc::new(RefCell::new(Default::default())),
            slot: None,
        }
    }
}

#[derive(PartialEq)]

pub struct lookupSlot_raw_ret_t {
    status: exception_t,
    slot: Option<Rc<RefCell<cte_t>>>,
}

impl Default for lookupSlot_raw_ret_t {
    fn default() -> Self {
        lookupSlot_raw_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: None,
        }
    }
}

pub struct lookupSlot_ret_t {
    status: exception_t,
    slot: Option<Rc<RefCell<cte_t>>>,
}

impl Default for lookupSlot_ret_t {
    fn default() -> Self {
        lookupSlot_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: None,
        }
    }
}

pub struct resolveAddressBits_ret_t {
    status: exception_t,
    slot: Option<Rc<RefCell<cte_t>>>,
    bitsRemaining: u64,
}

impl Default for resolveAddressBits_ret_t {
    fn default() -> Self {
        resolveAddressBits_ret_t {
            status: exception_t::EXCEPTION_NONE,
            slot: None,
            bitsRemaining: 0,
        }
    }
}

pub fn resolveAddressBits(
    _nodeCap: Rc<RefCell<cap_t>>,
    capptr: u64,
    mut n_bits: u64,
) -> resolveAddressBits_ret_t {
    let mut nodeCap=Rc::new(RefCell::new(cap_t { words: [_nodeCap.borrow().words[0],_nodeCap.borrow().words[1]] }));
    let mut ret = resolveAddressBits_ret_t::default();
    ret.bitsRemaining = n_bits;
    let mut radixBits: u64;
    let mut guardBits: u64;
    let mut guard: u64;
    let mut levelBits: u64;
    let mut capGuard: u64;
    let mut offset: u64;
    let mut slot:Rc<RefCell<cte_t>>;
    if unlikely(cap_get_capType(nodeCap.clone()) != cap_cnode_cap) {
        ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
        return ret;
    }

    while true {
        radixBits = cap_cnode_cap_get_capCNodeRadix(nodeCap.clone());
        guardBits = cap_cnode_cap_get_capCNodeGuardSize(nodeCap.clone());
        levelBits = radixBits + guardBits;
        assert!(levelBits != 0);
        capGuard = cap_cnode_cap_get_capCNodeGuard(nodeCap.clone());
        guard = (capptr >> ((n_bits - guardBits) & MASK(wordRadix))) & MASK(guardBits);

        if unlikely(guardBits > n_bits || guard != capGuard) {
            ret.status = exception_t::EXCEPTION_LOOKUP_FAULT;
            return ret;
        }

        if unlikely(levelBits > n_bits) {
            ret.status =  exception_t::EXCEPTION_LOOKUP_FAULT;
            return ret;
        }
        offset = (capptr >> (n_bits - levelBits)) & MASK(radixBits);
        unsafe {
            slot = Rc::from_raw(
                ((cap_cnode_cap_get_capCNodePtr(nodeCap.clone())) + offset)
                    as *const RefCell<cte_t>,
            );
        }


        if likely(n_bits == levelBits) {
            ret.slot = Some(slot.clone());
            ret.bitsRemaining = 0;
            return ret;
        }

        n_bits -= levelBits;
        nodeCap = slot.borrow().cap.clone();
        if unlikely(cap_get_capType(nodeCap.clone()) != cap_cnode_cap) {
            ret.slot = Some(slot.clone());
            ret.bitsRemaining = n_bits;
            return ret;
        }
    }
    panic!("UNREACHABLE");
}


pub fn lookupSlotFroCNodeOp(_isSource:bool,root:Rc<RefCell<cap_t>>,capptr:u64,depth:u64)->lookupSlot_ret_t{
    let mut ret:lookupSlot_ret_t=lookupSlot_ret_t::default();
    let wordBits=BIT(wordRadix);
    if unlikely(cap_get_capType(root.clone()) != cap_cnode_cap) {
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
    ret.slot = Some(res_ret.slot.unwrap().clone());
    ret.status = exception_t:: EXCEPTION_NONE;
    return ret;
}