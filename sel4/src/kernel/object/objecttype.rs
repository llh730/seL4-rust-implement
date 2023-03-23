use crate::{kernel::object::structures::*, MASK, config::seL4_SlotBits};
extern crate alloc;
use alloc::rc::Rc;
use core::cell::{RefCell};

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






pub fn isCapRevocable(_derivedCap: Rc<RefCell<cap_t>>, _srcCap: Rc<RefCell<cap_t>>) -> bool {
    if isArchCap(_derivedCap.clone()) {
        return false;
    }
    match cap_get_capType(_derivedCap.clone()) {
        cap_endpoint_cap => {
            return cap_endpoint_cap_get_capEPBadge(_derivedCap)
                != cap_endpoint_cap_get_capEPBadge(_srcCap)
        }
        cap_untyped_cap => return true,
        _ => return false,
    }
}

pub fn cap_get_capPtr(cap: Rc<RefCell<cap_t>>) -> usize {
    match cap_get_capType(cap.clone()) {
        cap_untyped_cap => return cap_untyped_cap_get_capPtr(cap.clone()),
        cap_endpoint_cap => return cap_endpoint_cap_get_capEPPtr(cap.clone()),
        cap_notification_cap => return 0,
        cap_cnode_cap => return cap_cnode_cap_get_capCNodePtr(cap.clone()),
        cap_page_table_cap => return cap_page_table_cap_get_capPTBasePtr(cap),
        cap_frame_cap=>return cap_frame_cap_get_capFBasePtr(cap),
        cap_asid_pool_cap=>return cap_asid_pool_cap_get_capASIDPool(cap.clone()),
        _ => return 0,
    }
}

pub fn cap_get_capSizeBits(cap: Rc<RefCell<cap_t>>) -> usize {
    match cap_get_capType(cap.clone()) {
        cap_untyped_cap => return cap_untyped_cap_get_capBlockSize(cap.clone()),
        cap_endpoint_cap => return seL4_EndpointBits,
        cap_notification_cap => return seL4_NotificationBits,
        cap_cnode_cap => return cap_cnode_cap_get_capCNodeRadix(cap.clone()) + seL4_SlotBits,
        cap_page_table_cap => return PT_SIZE_BITS,
        cap_null_cap => return 0,
        cap_reply_cap => seL4_ReplyBits,
        _ => return 0,
    }
}

pub fn sameRegionAs(cap1: Rc<RefCell<cap_t>>, cap2: Rc<RefCell<cap_t>>)->bool {
    match cap_get_capType(cap1.clone()) {
        cap_untyped_cap => {
            if cap_get_capIsPhyaical(cap2.clone()) {
                let aBase = cap_untyped_cap_get_capPtr(cap1.clone());
                let bBase = cap_get_capPtr(cap2.clone());

                let aTop = aBase + MASK!(cap_untyped_cap_get_capBlockSize(cap1.clone()));
                let bTop = bBase + MASK!(cap_get_capSizeBits(cap2.clone()));
                return (aBase <= bBase) && (bTop <= aTop) && (bBase <= bTop);
            }
            
            return false;
        }
        cap_endpoint_cap => {
            if cap_get_capType(cap2.clone()) == cap_endpoint_cap {
                return cap_endpoint_cap_get_capEPPtr(cap1.clone())
                    == cap_endpoint_cap_get_capEPPtr(cap2.clone());
            }
            return false;
        }
        cap_cnode_cap => {
            if cap_get_capType(cap2.clone()) == cap_cnode_cap {
                return (cap_cnode_cap_get_capCNodePtr(cap1.clone())
                    == cap_cnode_cap_get_capCNodePtr(cap2.clone()))
                    && (cap_cnode_cap_get_capCNodeRadix(cap1.clone())
                        == cap_cnode_cap_get_capCNodeRadix(cap2.clone()));
            }
            return false;
        }
        _ => {
            return false;
        }
    }
}

pub fn Arch_sameObjectAs(cap_a:Rc<RefCell<cap_t>>,cap_b:Rc<RefCell<cap_t>>)->bool{
    return false ;
}
pub fn sameObjectAs(cap_a:Rc<RefCell<cap_t>>,cap_b:Rc<RefCell<cap_t>>) -> bool {
    if cap_get_capType(cap_a.clone())==cap_untyped_cap{
        return false;
    }
    if cap_get_capType(cap_a.clone()) == cap_irq_control_cap &&
        cap_get_capType(cap_b.clone()) == cap_irq_handler_cap {
        return false;
    }
    if isArchCap(cap_a.clone()) && isArchCap(cap_b.clone()) {
        return Arch_sameObjectAs(cap_a.clone(), cap_b.clone());
    }
    return sameRegionAs(cap_a.clone(), cap_b.clone());
}

fn cap_get_capIsPhyaical(cap: Rc<RefCell<cap_t>>) -> bool {
    match cap_get_capType(cap.clone()) {
        cap_untyped_cap => return true,
        cap_endpoint_cap => return true,
        cap_notification_cap => return true,
        cap_cnode_cap => return true,
        cap_page_table_cap => return true,
        _ => return false,
    }
}

pub fn Arch_finaliseCap(cap:Rc<RefCell<cap_t>>,_final:bool)->finaliseCap_ret{
    let mut fc_ret=finaliseCap_ret::default();
    fc_ret.remainder=cap_null_cap_new();
    fc_ret.cleanupInfo=cap_null_cap_new();
    fc_ret
}

pub fn finaliseCap(cap:Rc<RefCell<cap_t>>,_final:bool,exposed:bool)->finaliseCap_ret{
    let mut fc_ret=finaliseCap_ret::default();

    if isArchCap(cap.clone()){
        return Arch_finaliseCap(cap.clone(), _final);
    }

    match cap_get_capType(cap.clone()){
        cap_endpoint_cap=>{
                if _final{
                    //TODO: cancelALLIPC()
                }
                fc_ret.remainder=cap_null_cap_new();
                fc_ret.cleanupInfo=cap_null_cap_new();
                return fc_ret;
        },
        cap_cnode_cap=>{
            if _final {
                //TODO Zombie_new()
                fc_ret.remainder =Zombie_new(1usize<< cap_cnode_cap_get_capCNodeRadix(cap.clone()),
                cap_cnode_cap_get_capCNodeRadix(cap.clone()),
                cap_cnode_cap_get_capCNodePtr(cap.clone()));
                fc_ret.cleanupInfo = cap_null_cap_new();
                return fc_ret;
            } else {
                fc_ret.remainder = cap_null_cap_new();
                fc_ret.cleanupInfo = cap_null_cap_new();
                return fc_ret;
            }
        },
        _=>{
            fc_ret.remainder = cap_null_cap_new();
            fc_ret.cleanupInfo = cap_null_cap_new();
            return fc_ret;
        }
    }
}