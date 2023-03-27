use crate::{config::seL4_SlotBits, kernel::object::structures::*, MASK};
extern crate alloc;
use core::cell::RefCell;

use super::cap::ensureNoChildren;

//bits

pub const seL4_EndpointBits: usize = 4;
pub const seL4_NotificationBits: usize = 4;
pub const seL4_ReplyBits: usize = 4;
pub const PT_SIZE_BITS: usize = 12;

//cap_tag_t
pub const cap_null_cap: usize = 0;
pub const cap_untyped_cap: usize = 2;
pub const cap_endpoint_cap: usize = 4;
pub const cap_notification_cap: usize = 6;
pub const cap_reply_cap: usize = 8;
pub const cap_cnode_cap: usize = 10;
pub const cap_thread_cap: usize = 12;
pub const cap_irq_control_cap: usize = 14;
pub const cap_irq_handler_cap: usize = 16;
pub const cap_zombie_cap: usize = 18;
pub const cap_domain_cap: usize = 20;
pub const cap_frame_cap: usize = 1;
pub const cap_page_table_cap: usize = 3;
pub const cap_asid_control_cap: usize = 11;
pub const cap_asid_pool_cap: usize = 13;

pub struct deriveCap_ret {
    pub status: exception_t,
    pub cap: *const cap_t,
}

pub fn isCapRevocable(_derivedCap: *const cap_t, _srcCap: *const cap_t) -> bool {
    if isArchCap(_derivedCap) {
        return false;
    }
    match cap_get_capType(_derivedCap) {
        cap_endpoint_cap => {
            return cap_endpoint_cap_get_capEPBadge(_derivedCap)
                != cap_endpoint_cap_get_capEPBadge(_srcCap)
        }
        cap_untyped_cap => return true,
        _ => return false,
    }
}

pub fn cap_get_capPtr(cap: *const cap_t) -> usize {
    match cap_get_capType(cap) {
        cap_untyped_cap => return cap_untyped_cap_get_capPtr(cap),
        cap_endpoint_cap => return cap_endpoint_cap_get_capEPPtr(cap),
        cap_notification_cap => return 0,
        cap_cnode_cap => return cap_cnode_cap_get_capCNodePtr(cap),
        cap_page_table_cap => return cap_page_table_cap_get_capPTBasePtr(cap),
        cap_frame_cap => return cap_frame_cap_get_capFBasePtr(cap),
        cap_asid_pool_cap => return cap_asid_pool_cap_get_capASIDPool(cap),
        _ => return 0,
    }
}

pub fn cap_get_capSizeBits(cap: *const cap_t) -> usize {
    match cap_get_capType(cap) {
        cap_untyped_cap => return cap_untyped_cap_get_capBlockSize(cap),
        cap_endpoint_cap => return seL4_EndpointBits,
        cap_notification_cap => return seL4_NotificationBits,
        cap_cnode_cap => return cap_cnode_cap_get_capCNodeRadix(cap) + seL4_SlotBits,
        cap_page_table_cap => return PT_SIZE_BITS,
        cap_null_cap => return 0,
        cap_reply_cap => seL4_ReplyBits,
        _ => return 0,
    }
}

pub fn sameRegionAs(cap1: *const cap_t, cap2: *const cap_t) -> bool {
    match cap_get_capType(cap1) {
        cap_untyped_cap => {
            if cap_get_capIsPhyaical(cap2) {
                let aBase = cap_untyped_cap_get_capPtr(cap1);
                let bBase = cap_get_capPtr(cap2);

                let aTop = aBase + MASK!(cap_untyped_cap_get_capBlockSize(cap1));
                let bTop = bBase + MASK!(cap_get_capSizeBits(cap2));
                return (aBase <= bBase) && (bTop <= aTop) && (bBase <= bTop);
            }

            return false;
        }
        cap_endpoint_cap => {
            if cap_get_capType(cap2) == cap_endpoint_cap {
                return cap_endpoint_cap_get_capEPPtr(cap1) == cap_endpoint_cap_get_capEPPtr(cap2);
            }
            return false;
        }
        cap_cnode_cap => {
            if cap_get_capType(cap2) == cap_cnode_cap {
                return (cap_cnode_cap_get_capCNodePtr(cap1)
                    == cap_cnode_cap_get_capCNodePtr(cap2))
                    && (cap_cnode_cap_get_capCNodeRadix(cap1)
                        == cap_cnode_cap_get_capCNodeRadix(cap2));
            }
            return false;
        }
        _ => {
            return false;
        }
    }
}

pub fn Arch_sameObjectAs(cap_a: *const cap_t, cap_b: *const cap_t) -> bool {
    return false;
}
pub fn sameObjectAs(cap_a: *const cap_t, cap_b: *const cap_t) -> bool {
    if cap_get_capType(cap_a) == cap_untyped_cap {
        return false;
    }
    if cap_get_capType(cap_a) == cap_irq_control_cap
        && cap_get_capType(cap_b) == cap_irq_handler_cap
    {
        return false;
    }
    if isArchCap(cap_a) && isArchCap(cap_b) {
        return Arch_sameObjectAs(cap_a, cap_b);
    }
    return sameRegionAs(cap_a, cap_b);
}

fn cap_get_capIsPhyaical(cap: *const cap_t) -> bool {
    match cap_get_capType(cap) {
        cap_untyped_cap => return true,
        cap_endpoint_cap => return true,
        cap_notification_cap => return true,
        cap_cnode_cap => return true,
        cap_page_table_cap => return true,
        _ => return false,
    }
}

pub fn Arch_finaliseCap(cap: *const cap_t, _final: bool) -> finaliseCap_ret {
    let mut fc_ret = finaliseCap_ret::default();
    fc_ret.remainder = cap_null_cap_new();
    fc_ret.cleanupInfo = cap_null_cap_new();
    fc_ret
}

pub fn finaliseCap(cap: *const cap_t, _final: bool, exposed: bool) -> finaliseCap_ret {
    let mut fc_ret = finaliseCap_ret::default();

    if isArchCap(cap) {
        return Arch_finaliseCap(cap, _final);
    }

    match cap_get_capType(cap) {
        cap_endpoint_cap => {
            if _final {
                //TODO: cancelALLIPC()
            }
            fc_ret.remainder = cap_null_cap_new();
            fc_ret.cleanupInfo = cap_null_cap_new();
            return fc_ret;
        }
        cap_cnode_cap => {
            if _final {
                //TODO Zombie_new()
                fc_ret.remainder = Zombie_new(
                    1usize << cap_cnode_cap_get_capCNodeRadix(cap),
                    cap_cnode_cap_get_capCNodeRadix(cap),
                    cap_cnode_cap_get_capCNodePtr(cap),
                );
                fc_ret.cleanupInfo = cap_null_cap_new();
                return fc_ret;
            } else {
                fc_ret.remainder = cap_null_cap_new();
                fc_ret.cleanupInfo = cap_null_cap_new();
                return fc_ret;
            }
        }
        _ => {
            fc_ret.remainder = cap_null_cap_new();
            fc_ret.cleanupInfo = cap_null_cap_new();
            return fc_ret;
        }
    }
}

pub fn Arch_deriveCap(slot: *const cte_t, cap: *const cap_t) -> deriveCap_ret {
    let mut ret = deriveCap_ret {
        status: exception_t::EXCEPTION_NONE,
        cap: 0 as *const cap_t,
    };
    match cap_get_capType(cap) {
        cap_page_table_cap => {
            if cap_page_table_cap_get_capPTIsMapped(cap) != 0 {
                ret.cap = cap;
                ret.status = exception_t::EXCEPTION_NONE;
            } else {
                panic!(" error:this page table cap is not mapped");
            }
        }
        cap_frame_cap => {
            cap_frame_cap_set_capFMappedAddress(cap, 0);
            ret.cap = cap_frame_cap_set_capFMappedASID(cap, 0);
        }
        cap_asid_control_cap | cap_asid_pool_cap => {
            ret.cap = cap;
        }
        _ => {
            panic!(" Invalid arch cap type :{}", cap_get_capType(cap));
        }
    }
    ret
}

pub fn deriveCap(slot: *const cte_t, cap: *const cap_t) -> deriveCap_ret {
    if isArchCap(cap) {}
    let mut ret = deriveCap_ret {
        status: exception_t::EXCEPTION_NONE,
        cap: 0 as *const cap_t,
    };
    match cap_get_capType(cap) {
        cap_zombie_cap => {
            ret.cap = cap_null_cap_new();
        }
        cap_untyped_cap => {
            ret.status = ensureNoChildren(slot);
            if ret.status != exception_t::EXCEPTION_NONE {
                ret.cap = cap_null_cap_new();
            } else {
                ret.cap = cap;
            }
        }
        _ => {
            ret.cap = cap;
        }
    }
    ret
}
