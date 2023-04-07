use core::{alloc::Layout, mem::size_of};

use alloc::string::String;

use crate::{
    config::{seL4_SlotBits, seL4_TCBBits, tcbCNodeEntries, RISCVMegaPageBits, RISCVPageBits},
    kernel::{
        object::structures::*,
        thread::{
            arch_tcb_t, ksCurThread, setThreadState, tcb_t, Arch_initContext, ThreadStateRestart,
        },
        vspace::{
            deleteASID, findVSpaceForASID, pageBitsForSize, unmapPage, unmapPageTable,
            RISCV_4K_Page, RISCV_Mega_Page, VMReadWrite,
        },
    },
    MASK, println,
};
extern crate alloc;

use super::{
    cap::{ensureNoChildren, insertNewCap},
    endpoint::{cancelAllIPC, performInvocation_Endpoint},
};

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

pub const seL4_UntypedObject: usize = 1;
pub const seL4_TCBObject: usize = 2;
pub const seL4_EndpointObject: usize = 3;
pub const seL4_CapTableObject: usize = 5;
pub const seL4_RISCV_4K_Page: usize = 6;
pub const seL4_RISCV_Mega_Page: usize = 7;
pub const seL4_RISCV_PageTableObject: usize = 8;
const asidInvalid: usize = 0;

pub struct deriveCap_ret {
    pub status: exception_t,
    pub cap: *const cap_t,
}

//FIXME:this size may not be corrected
pub fn getObjectSize(t: usize, userObjSize: usize) -> usize {
    match t {
        seL4_TCBObject => seL4_TCBBits,
        seL4_EndpointObject => seL4_EndpointBits,
        seL4_CapTableObject => seL4_SlotBits + userObjSize,
        seL4_UntypedObject => userObjSize,
        seL4_RISCV_4K_Page | seL4_RISCV_PageTableObject => RISCVPageBits,
        seL4_RISCV_Mega_Page => RISCVMegaPageBits,
        _ => panic!("invalid object type:{}", t),
    }
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
        cap_frame_cap => {
            let botA = cap_frame_cap_get_capFBasePtr(cap1);
            let botB = cap_frame_cap_get_capFBasePtr(cap2);
            let topA =
                botA + ((1usize << (pageBitsForSize(cap_frame_cap_get_capFSize(cap1)))) - 1usize);
            let topB =
                botB + ((1usize << (pageBitsForSize(cap_frame_cap_get_capFSize(cap2)))) - 1usize);
            (botA <= botB) && (topA >= topB) && (botB <= topB)
        }
        cap_endpoint_cap => {
            cap_endpoint_cap_get_capEPPtr(cap1) == cap_endpoint_cap_get_capEPPtr(cap2)
        }
        cap_page_table_cap => {
            cap_page_table_cap_get_capPTBasePtr(cap1) == cap_page_table_cap_get_capPTBasePtr(cap2)
        }
        cap_cnode_cap => {
            (cap_cnode_cap_get_capCNodePtr(cap1) == cap_cnode_cap_get_capCNodePtr(cap2))
                && (cap_cnode_cap_get_capCNodeRadix(cap1) == cap_cnode_cap_get_capCNodeRadix(cap2))
        }
        cap_thread_cap => {
            cap_thread_cap_get_capTCBPtr(cap1 as *mut cap_t)
                == cap_thread_cap_get_capTCBPtr(cap2 as *mut cap_t)
        }
        _ => {
            return false;
        }
    }
}

pub fn createObject(
    objectType: usize,
    regionptr: usize,
    userSize: usize,
    deviceMemory: bool,
) -> *const cap_t {
    let regionBase = regionptr as *mut u8;
    match objectType {
        seL4_TCBObject => {
            let tcb = regionBase as *mut tcb_t;
            let cte_total_size = size_of::<cte_t>() * tcbCNodeEntries;
            let cte_size = size_of::<cte_t>();
            let cte_layout = Layout::from_size_align(cte_total_size, 4).ok().unwrap();
            let cte_ptr: *mut u8;
            unsafe {
                cte_ptr = alloc::alloc::alloc(cte_layout);
            }

            let mut rootCaps: [*const cte_t; tcbCNodeEntries] =
                [0 as *const cte_t; tcbCNodeEntries];
            for i in 0..tcbCNodeEntries {
                let ptr = (cte_ptr as usize + i * cte_size) as *mut cte_t;
                unsafe {
                    (*ptr).cap = cap_null_cap_new() as *mut cap_t;
                    (*ptr).cteMDBNode = mdb_node_new(0, 0, 0, 0) as *mut mdb_node_t;
                }
                rootCaps[i] = (cte_ptr as usize + i * cte_size) as *mut cte_t;
            }
            unsafe {
                (*tcb).rootCap = rootCaps;
                (*tcb).tcbState = thread_state_new();
                Arch_initContext((&(*tcb).tcbArch) as *const arch_tcb_t as *mut arch_tcb_t);
                return cap_thread_cap_new(tcb as usize);
            }
        }
        seL4_EndpointObject => cap_endpoint_cap_new(0, 1, 1, 1, 1, regionBase as usize),
        seL4_CapTableObject => cap_cnode_cap_new(userSize, 0, 0, regionBase as usize),
        seL4_UntypedObject => {
            cap_untyped_cap_new(0, deviceMemory as usize, userSize, regionBase as usize)
        }
        seL4_RISCV_4K_Page => cap_frame_cap_new(
            asidInvalid,
            regionBase as usize,
            RISCV_4K_Page,
            VMReadWrite,
            deviceMemory as usize,
            0,
        ),
        seL4_RISCV_Mega_Page => cap_frame_cap_new(
            asidInvalid,
            regionBase as usize,
            RISCV_Mega_Page,
            VMReadWrite,
            deviceMemory as usize,
            0,
        ),
        seL4_RISCV_PageTableObject => {
            cap_page_table_cap_new(asidInvalid, regionBase as usize, 0, 0)
        }
        _ => panic! {"Invalid object type:{}",objectType},
    }
}

pub fn createNewObject(
    objectType: usize,
    parent: *const cte_t,
    destCnode: *const cte_t,
    destOffset: usize,
    destLength: usize,
    regionBase: *mut u8,
    userSize: usize,
    deviceMemory: bool,
) {
    let objectSize = getObjectSize(objectType, userSize);
    // let totalObjectSize = destLength << objectSize;
    let nextFreeArea = regionBase;
    for i in 0..destLength {
        let cap = createObject(
            objectType,
            nextFreeArea as usize + (i << objectSize),
            userSize,
            deviceMemory,
        );
        let targetSlot =
            (destCnode as usize + (destOffset + i) * size_of::<cte_t>()) as *const cte_t;
        insertNewCap(parent, targetSlot, cap);
    }
}

pub fn Arch_sameObjectAs(cap_a: *const cap_t, cap_b: *const cap_t) -> bool {
    if (cap_get_capType(cap_a) == cap_frame_cap) && (cap_get_capType(cap_b) == cap_frame_cap) {
        return (cap_frame_cap_get_capFBasePtr(cap_a) == cap_frame_cap_get_capFBasePtr(cap_b))
            && (cap_frame_cap_get_capFSize(cap_a) == cap_frame_cap_get_capFSize(cap_b))
            && ((cap_frame_cap_get_capFIsDevice(cap_a) == 0)
                == (cap_frame_cap_get_capFIsDevice(cap_b) == 0));
    }
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
    match cap_get_capType(cap) {
        cap_frame_cap => {
            if cap_frame_cap_get_capFMappedASID(cap) != 0 {
                unmapPage(
                    cap_frame_cap_get_capFSize(cap),
                    cap_frame_cap_get_capFMappedASID(cap),
                    cap_frame_cap_get_capFMappedAddress(cap),
                    cap_frame_cap_get_capFBasePtr(cap),
                );
            }
        }
        cap_page_table_cap => {
            if _final && cap_page_table_cap_get_capPTIsMapped(cap) != 0 {
                let asid = cap_page_table_cap_get_capPTMappedASID(cap);
                let find_ret = findVSpaceForASID(asid);
                let pte = cap_page_table_cap_get_capPTBasePtr(cap);
                if find_ret.status == exception_t::EXCEPTION_NONE && find_ret.vspace_root == pte {
                    deleteASID(asid, pte);
                } else {
                    unmapPageTable(asid, cap_page_table_cap_get_capPTMappedAddress(cap), pte);
                }
            }
        }
        cap_asid_control_cap => {}
        _ => panic!("Invalid cap type :{}", cap_get_capType(cap)),
    }
    fc_ret.remainder = cap_null_cap_new();
    fc_ret.cleanupInfo = cap_null_cap_new();
    fc_ret
}

pub fn finaliseCap(cap: *const cap_t, _final: bool, _exposed: bool) -> finaliseCap_ret {
    let mut fc_ret = finaliseCap_ret::default();

    if isArchCap(cap) {
        return Arch_finaliseCap(cap, _final);
    }

    match cap_get_capType(cap) {
        cap_endpoint_cap => {
            if _final {
                // TODO: cancelALLIPC()
                cancelAllIPC(cap_endpoint_cap_get_capEPPtr(cap) as *const endpoint_t);
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
        //FIXME::cap_thread_cap condition not included
        // cap_thread_cap => {
        //     if _final {
        //         let tcb = cap_thread_cap_get_capTCBPtr(cap) as *const tcb_t;
        //         // let cte_ptr =
        //     }
        // }
        _ => {
            fc_ret.remainder = cap_null_cap_new();
            fc_ret.cleanupInfo = cap_null_cap_new();
            return fc_ret;
        }
    }
}

pub fn hasCancelSendRight(cap: *const cap_t) -> bool {
    match cap_get_capType(cap) {
        cap_endpoint_cap => {
            cap_endpoint_cap_get_capCanSend(cap) != 0
                && cap_endpoint_cap_get_capCanReceive(cap) != 0
                && cap_endpoint_cap_get_capCanGrantReply(cap) != 0
                && cap_endpoint_cap_get_capCanGrant(cap) != 0
        }
        _ => false,
    }
}

pub fn Arch_deriveCap(_slot: *const cte_t, cap: *const cap_t) -> deriveCap_ret {
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

pub fn decodeInvocation(
    _invLabel: usize,
    _length: usize,
    _capIndex: usize,
    _slot: *const cte_t,
    cap: *const cap_t,
    block: bool,
    call: bool,
    _buffer: usize,
) -> exception_t {
    match cap_get_capType(cap) {
        cap_endpoint_cap => unsafe {
            //FIXME::why restart???
            // setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
            let canGrant = if cap_endpoint_cap_get_capCanGrant(cap) != 0 {
                true
            } else {
                false
            };
            let canGrantReply = if cap_endpoint_cap_get_capCanGrantReply(cap) != 0 {
                true
            } else {
                false
            };
            // println!("ep cap :{:#x}",cap )
            performInvocation_Endpoint(
                cap_endpoint_cap_get_capEPPtr(cap) as *const endpoint_t,
                cap_endpoint_cap_get_capEPBadge(cap),
                canGrant,
                canGrantReply,
                block,
                call,
            )
        },
        cap_zombie_cap => {
            panic!("attempt to invoke a zombie cap");
        }
        cap_null_cap => {
            panic!("attempt to invoke a null cap");
        }
        _ => panic!("Invalid cap :{}", cap_get_capType(cap)),
    }
}

pub fn updateCapData(preserve: bool, newData: usize, cap: *const cap_t) -> *const cap_t {
    match cap_get_capType(cap) {
        cap_endpoint_cap => {
            if !preserve && cap_endpoint_cap_get_capEPBadge(cap) == 0 {
                cap_endpoint_cap_set_capEPBadge(cap, newData);
                cap
            } else {
                cap_null_cap_new()
            }
        }
        cap_cnode_cap => {
            //FIXEME updateCapDate not implemented.
            panic!("updateCapData not supports cnode cap for now");
            // let guardSize=
        }
        _ => panic!("invalid cap:{}", cap_get_capType(cap)),
    }
}
