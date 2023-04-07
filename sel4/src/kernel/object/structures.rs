extern crate alloc;
use core::alloc::Layout;
//CSpace relevant
use core::default::Default;
use core::intrinsics::{likely, unlikely};
use core::mem::size_of;

use crate::MASK;

use super::objecttype::*;

//zombie config
pub const wordRadix: usize = 6;
pub const ZombieType_ZombieTCB: usize = 1usize << wordRadix;
pub const TCB_CNODE_RADIX: usize = 4;
pub fn ZombieType_ZombieCNode(n: usize) -> usize {
    return n & MASK!(wordRadix);
}

#[derive(Debug, PartialEq, Copy, Clone)]
pub struct thread_state_t {
    pub words: [usize; 3],
}
#[derive(Debug, PartialEq, Copy, Clone)]
pub struct cap_t {
    pub words: [usize; 2],
}

impl Default for cap_t {
    fn default() -> Self {
        cap_t { words: [0; 2] }
    }
}
#[derive(Debug, PartialEq)]
pub struct mdb_node_t {
    pub words: [usize; 2],
}

impl Default for mdb_node_t {
    fn default() -> Self {
        mdb_node_t { words: [0; 2] }
    }
}
#[derive(Debug, PartialEq,Clone, Copy)]
pub struct cte_t {
    pub cap: *mut cap_t,
    pub cteMDBNode: *mut mdb_node_t,
}

impl Default for cte_t {
    fn default() -> Self {
        cte_t {
            cap: &(cap_t::default()) as *const cap_t as *mut cap_t,
            cteMDBNode: &(mdb_node_t::default()) as *const mdb_node_t as *mut mdb_node_t,
        }
    }
}

pub struct finaliseSlot_ret {
    pub status: exception_t,
    pub success: bool,
    pub cleanupInfo: *const cap_t,
}

impl Default for finaliseSlot_ret {
    fn default() -> Self {
        finaliseSlot_ret {
            status: exception_t::EXCEPTION_NONE,
            success: true,
            cleanupInfo: &(cap_t::default()) as *const cap_t,
        }
    }
}

struct deriveCap_ret {
    pub status: exception_t,
    pub cap: *mut cap_t,
}

impl Default for deriveCap_ret {
    fn default() -> Self {
        deriveCap_ret {
            status: exception_t::EXCEPTION_NONE,
            cap: (&(cap_t::default())) as *const cap_t as *mut cap_t,
        }
    }
}

pub struct finaliseCap_ret {
    pub remainder: *const cap_t,
    pub cleanupInfo: *const cap_t,
}

impl Default for finaliseCap_ret {
    fn default() -> Self {
        finaliseCap_ret {
            remainder: (&(cap_t::default())) as *const cap_t,
            cleanupInfo: (&(cap_t::default())) as *const cap_t,
        }
    }
}

pub struct endpoint_t {
    words: [usize; 2],
}

type word_t = usize;
type bool_t = usize;
#[derive(PartialEq)]
pub enum exception_t {
    EXCEPTION_NONE,
    EXCEPTION_FAULT,
    EXCEPTION_LOOKUP_FAULT,
    EXCEPTION_SYSCALL_ERROR,
    EXCEPTION_PREEMTED,
}
#[derive(PartialEq)]
pub enum cap_tag_t {
    cap_null_cap = 0,
    cap_untyped_cap = 2,
    cap_endpoint_cap = 4,
    cap_notification_cap = 6,
    cap_reply_cap = 8,
    cap_cnode_cap = 10,
    cap_thread_cap = 12,
    cap_irq_control_cap = 14,
    cap_irq_handler_cap = 16,
    cap_zombie_cap = 18,
    cap_domain_cap = 20,
    cap_frame_cap = 1,
    cap_page_table_cap = 3,
    cap_asid_control_cap = 11,
    cap_asid_pool_cap = 13,
}

//mdb relevant
#[inline]
pub fn mdb_node_new(
    mdbNext: usize,
    mdbRevocable: usize,
    mdbFirstBadged: usize,
    mdbPrev: usize,
) -> *const mdb_node_t {
    unsafe {
        let mut mdb_node = mdb_node_t::default();
        let size = size_of::<mdb_node_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut mdb_node_t;

        mdb_node.words[0] = 0 | mdbPrev << 0;

        mdb_node.words[1] = 0
            | (mdbNext & 0x7ffffffffcusize) >> 0
            | (mdbRevocable & 0x1usize) << 1
            | (mdbFirstBadged & 0x1usize) << 0;
        (*ptr) = mdb_node;
        ptr
    }
}

#[inline]
pub fn mdb_node_get_mdbNext(_mdb_node: *const mdb_node_t) -> usize {
    unsafe {
        let mdb_node = &(*_mdb_node);
        let mut ret: usize;
        ret = (mdb_node.words[1] & 0x7ffffffffcusize) << 0;
        /* Possibly sign extend */
        if core::intrinsics::likely(!!(true && (ret & (1usize << 38) != 0))) {
            ret |= 0xffffff8000000000;
        }
        ret
    }
}

#[inline]
pub fn mdb_node_ptr_set_mdbNext(_mdb_node: *const mdb_node_t, v64: usize) {
    unsafe {
        let mut mdb_node = _mdb_node as *mut mdb_node_t;

        assert!(
            (((!0x7ffffffffcusize << 0) | 0xffffff8000000000) & v64)
                == if true && (v64 & (1usize << (38))) != 0 {
                    0xffffff8000000000
                } else {
                    0
                }
        );
        (*mdb_node).words[1] = !0x7ffffffffcusize;
        (*mdb_node).words[1] |= (v64 >> 0) & 0x7ffffffffc;
    }
}

#[inline]
pub fn mdb_node_get_mdbRevocable(_mdb_node: *const mdb_node_t) -> usize {
    unsafe {
        let mdb_node = &(*_mdb_node);
        let mut ret: usize;
        ret = (mdb_node.words[1] & 0x2usize) >> 1;
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn mdb_node_set_mdbRevocable(_mdb_node: *const mdb_node_t, v64: usize) -> *const mdb_node_t {
    unsafe {
        let mut mdb_node = mdb_node_t {
            words: (*_mdb_node).words,
        };
        assert!(
            (((!0x2usize >> 1) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );
        mdb_node.words[1] &= !0x2usize;
        mdb_node.words[1] |= (v64 << 1) & 0x2;
        (&(mdb_node)) as *const mdb_node_t
    }
}

#[inline]
pub fn mdb_node_get_mdbFirstBadged(_mdb_node: *const mdb_node_t) -> usize {
    unsafe {
        let mdb_node = &(*_mdb_node);
        let mut ret: usize;
        ret = (mdb_node.words[1] & 0x1usize) >> 0;
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn mdb_node_set_mdbFirstBadged(_mdb_node: *const mdb_node_t, v64: usize) -> *const mdb_node_t {
    unsafe {
        let mut mdb_node = mdb_node_t {
            words: (*_mdb_node).words,
        };
        assert!(
            (((!0x1usize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );
        mdb_node.words[1] &= !0x1usize;
        mdb_node.words[1] |= (v64 << 0) & 0x1usize;
        (&(mdb_node)) as *const mdb_node_t
    }
}

#[inline]
pub fn mdb_node_get_mdbPrev(_mdb_node: *const mdb_node_t) -> usize {
    unsafe {
        let mdb_node = &(*_mdb_node);
        let mut ret: usize;
        ret = (mdb_node.words[0] & 0xffffffffffffffffusize) >> 0;
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn mdb_node_set_mdbPrev(_mdb_node: *const mdb_node_t, v64: usize) -> *const mdb_node_t {
    unsafe {
        let mut mdb_node = mdb_node_t {
            words: (*_mdb_node).words,
        };
        assert!(
            (((!0xffffffffffffffffusize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );
        mdb_node.words[0] &= !0xffffffffffffffffusize;
        mdb_node.words[0] |= (v64 << 0) & 0xffffffffffffffffusize;
        (&(mdb_node)) as *const mdb_node_t
    }
}

#[inline]
pub fn mdb_node_ptr_set_mdbPrev(_mdb_node: *const mdb_node_t, v64: usize) {
    unsafe {
        let mut mdb_node = _mdb_node as *mut mdb_node_t;
        assert!(
            (((!0xffffffffffffffffusize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );
        (*mdb_node).words[0] &= !0xffffffffffffffffusize;
        (*mdb_node).words[0] |= (v64 << 0) & 0xffffffffffffffffusize;
    }
}

//cap relevant

#[inline]
pub fn cap_get_max_free_index(_cap: *const cap_t) -> usize {
    let ans = cap_untyped_cap_get_capBlockSize(_cap);
    let sel4_MinUntypedbits: usize = 4;
    (1usize << ans) - sel4_MinUntypedbits
}

#[inline]
pub fn cap_get_capType(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        (cap.words[0] >> 59) & 0x1fusize
    }
}

#[inline]
pub fn cap_capType_equals(_cap: *const cap_t, cap_type_tag: usize) -> i32 {
    unsafe {
        let cap = *_cap;
        (((cap.words[0] >> 59) & 0x1fusize) == cap_type_tag) as i32
    }
}

#[inline]
pub fn cap_null_cap_new() -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        assert!(
            (cap_tag_t::cap_null_cap as usize & !0x1fusize)
                == (if true && (cap_tag_t::cap_null_cap as usize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] = 0 | (cap_tag_t::cap_null_cap as usize & 0x1fusize) << 59;
        cap.words[1] = 0;

        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_untyped_cap_new(
    capFreeIndex: usize,
    capIsDevice: usize,
    capBlockSize: usize,
    capPtr: usize,
) -> *const cap_t {
    unsafe {
        let mut cap = cap_t::default();
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        assert!(
            (capFreeIndex & !0x7fffffffffusize)
                == (if true && (capFreeIndex & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capIsDevice & !0x1usize)
                == (if true && (capIsDevice & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capBlockSize & !0x3fusize)
                == (if true && (capBlockSize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (cap_tag_t::cap_untyped_cap as usize & !0x1fusize)
                == (if true && (cap_tag_t::cap_untyped_cap as usize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capPtr & !0x7fffffffffusize)
                == (if true && (capPtr & (1usize << 38)) != 0 {
                    0xffffff8000000000
                } else {
                    0
                })
        );

        cap.words[0] = 0
            | (cap_tag_t::cap_untyped_cap as usize & 0x1fusize) << 59
            | (capPtr & 0x7fffffffffusize) >> 0;
        cap.words[1] = 0
            | (capFreeIndex & 0x7fffffffffusize) << 25
            | (capIsDevice & 0x1usize) << 6
            | (capBlockSize & 0x3fusize) << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_untyped_cap_get_capIsDevice(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
        ret = (cap.words[1] & 0x40usize) >> 6;
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn cap_untyped_cap_get_capBlockSize(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
        ret = (cap.words[1] & 0x3fusize) >> 0;
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}
#[inline]
pub fn cap_untyped_cap_get_capFreeIndex(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);

        ret = (cap.words[1] & 0xfffffffffe000000usize) >> 25;
        if unlikely(!!(false && (ret & (1usize << (38)) != 0))) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn cap_untyped_cap_set_capFreeIndex(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0xfffffffffe000000usize >> 25) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[1] &= !0xfffffffffe000000usize;
        cap.words[1] |= (v64 << 25) & 0xfffffffffe000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_untyped_cap_ptr_set_capFreeIndex(_cap: *const cap_t, v64: usize) {
    unsafe {
        let mut cap = *(_cap as *mut cap_t);
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0xfffffffffe000000usize >> 25) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[1] &= !0xfffffffffe000000usize;
        cap.words[1] |= (v64 << 25) & 0xfffffffffe000000usize;
    }
}

#[inline]
pub fn cap_untyped_cap_get_capPtr(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);

        ret = (cap.words[0] & 0x7fffffffffusize) << 0;
        /* Possibly sign extend */
        if likely(!!(true && (ret & (1usize << (38))) != 0)) {
            ret |= 0xffffff8000000000;
        }
        return ret;
    }
}

#[inline]
pub fn cap_endpoint_cap_new(
    capEPBadge: usize,
    capCanGrantReply: usize,
    capCanGrant: usize,
    capCanSend: usize,
    capCanReceive: usize,
    capEPPtr: usize,
) -> *const cap_t {
    unsafe {
        let mut cap = cap_t::default();

        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        /* fail if user has passed bits that we will override */
        assert!(
            (capCanGrantReply & !0x1usize)
                == (if true && (capCanGrantReply & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capCanGrant & !0x1usize)
                == (if true && (capCanGrant & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capCanSend & !0x1usize)
                == (if true && (capCanSend & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capCanReceive & !0x1usize)
                == (if true && (capCanReceive & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capEPPtr & !0x7fffffffffusize)
                == (if true && (capEPPtr & (1usize << 38)) != 0 {
                    0xffffff8000000000
                } else {
                    0
                })
        );
        assert!(
            (cap_tag_t::cap_endpoint_cap as usize & !0x1fusize)
                == (if true && (cap_tag_t::cap_endpoint_cap as usize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] = 0
            | (capCanGrantReply & 0x1usize) << 58
            | (capCanGrant & 0x1usize) << 57
            | (capCanSend & 0x1usize) << 55
            | (capCanReceive & 0x1usize) << 56
            | (capEPPtr & 0x7fffffffffusize) >> 0
            | (cap_tag_t::cap_endpoint_cap as usize & 0x1fusize) << 59;
        cap.words[1] = 0 | capEPBadge << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capEPBadge(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_endpoint_cap_set_capEPBadge(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0xffffffffffffffffusize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[1] &= !0xffffffffffffffffusize;
        cap.words[1] |= (v64 << 0) & 0xffffffffffffffffusize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrantReply(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[0] & 0x400000000000000usize) >> 58;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_endpoint_cap_set_capCanGrantReply(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0x400000000000000usize >> 58) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );
        cap.words[0] &= !0x400000000000000usize;
        cap.words[0] |= (v64 << 58) & 0x400000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrant(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[0] & 0x200000000000000usize) >> 57;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}
#[inline]
pub fn cap_endpoint_cap_set_capCanGrant(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0x200000000000000usize >> 57) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] &= !0x200000000000000usize;
        cap.words[0] |= (v64 << 57) & 0x200000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capCanReceive(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret: usize;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[0] & 0x100000000000000usize) >> 56;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_endpoint_cap_set_capCanReceive(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0x100000000000000usize >> 56) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] &= !0x100000000000000usize;
        cap.words[0] |= (v64 << 56) & 0x100000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capCanSend(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret: usize;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[0] & 0x80000000000000usize) >> 55;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_endpoint_cap_set_capCanSend(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0x80000000000000usize >> 55) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] &= !0x80000000000000usize;
        cap.words[0] |= (v64 << 55) & 0x80000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_endpoint_cap_get_capEPPtr(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

        ret = (cap.words[0] & 0x7fffffffffusize) << 0;
        /* Possibly sign extend */
        if likely(!!(true && (ret & (1usize << (38))) != 0)) {
            ret |= 0xffffff8000000000;
        }
        return ret;
    }
}

//FIXME::notification relevant cap not implemented

//FIXME::reply relevant cap not implemented

#[inline]
pub fn cap_cnode_cap_new(
    capCNodeRadix: usize,
    capCNodeGuardSize: usize,
    capCNodeGuard: usize,
    capCNodePtr: usize,
) -> *const cap_t {
    unsafe {
        let mut cap = cap_t::default();
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        /* fail if user has passed bits that we will override */
        // println!(
        //     "create cnode cap start :{:#x} , end :{:#x}",
        //     ptr as usize,
        //     ptr as usize + size
        // );
        assert!(
            (capCNodeRadix & !0x3fusize)
                == (if true && (capCNodeRadix & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capCNodeGuardSize & !0x3fusize)
                == (if true && (capCNodeGuardSize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capCNodePtr & !0x7ffffffffeusize)
                == (if true && (capCNodePtr & (1usize << 38)) != 0 {
                    0xffffff8000000000
                } else {
                    0
                })
        );
        assert!(
            (cap_tag_t::cap_cnode_cap as usize & !0x1fusize)
                == (if true && (cap_tag_t::cap_cnode_cap as usize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] = 0
            | (capCNodeRadix & 0x3fusize) << 47
            | (capCNodeGuardSize & 0x3fusize) << 53
            | (capCNodePtr & 0x7ffffffffeusize) >> 1
            | (cap_tag_t::cap_cnode_cap as usize & 0x1fusize) << 59;
        cap.words[1] = 0 | capCNodeGuard << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuard(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret: usize;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

        ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuard(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0xffffffffffffffffusize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[1] &= !0xffffffffffffffffusize;
        cap.words[1] |= (v64 << 0) & 0xffffffffffffffffusize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuardSize(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret: usize;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

        ret = (cap.words[0] & 0x7e0000000000000usize) >> 53;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuardSize(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0x7e0000000000000usize >> 53) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] &= !0x7e0000000000000usize;
        cap.words[0] |= (v64 << 53) & 0x7e0000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeRadix(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let mut ret;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

        ret = (cap.words[0] & 0x1f800000000000usize) >> 47;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn cap_cnode_cap_get_capCNodePtr(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret: usize;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

        ret = (cap.words[0] & 0x3fffffffffusize) << 1;
        /* Possibly sign extend */
        if likely(!!(true && (ret & (1usize << (38))) != 0)) {
            ret |= 0xffffff8000000000;
        }
        return ret;
    }
}

#[inline]
pub fn isArchCap(_cap: *const cap_t) -> bool {
    cap_get_capType(_cap) % 2 != 0
}

//zombie cap relevant
#[inline]
pub fn cap_zombie_cap_new(capZombieID: usize, capZombieType: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t::default();
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        /* fail if user has passed bits that we will override */
        assert!(
            (cap_tag_t::cap_zombie_cap as usize & !0x1fusize)
                == (if true && (cap_tag_t::cap_zombie_cap as usize & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );
        assert!(
            (capZombieType & !0x7fusize)
                == (if true && (capZombieType & (1usize << 38)) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[0] = 0
            | (cap_tag_t::cap_zombie_cap as usize & 0x1fusize) << 59
            | (capZombieType & 0x7fusize) << 0;
        cap.words[1] = 0 | capZombieID << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_zombie_cap_get_capZombieID(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as usize);

        ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        ret
    }
}

#[inline]
pub fn cap_zombie_cap_set_capZombieID(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as usize);
        /* fail if user has passed bits that we will override */
        assert!(
            (((!0xffffffffffffffffusize >> 0) | 0x0) & v64)
                == (if false && (v64 & (1usize << (38))) != 0 {
                    0x0
                } else {
                    0
                })
        );

        cap.words[1] &= !0xffffffffffffffffusize;
        cap.words[1] |= (v64 << 0) & 0xffffffffffffffffusize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_zombie_cap_get_capZombieType(_cap: *const cap_t) -> usize {
    unsafe {
        let mut ret;
        let cap = *_cap;
        assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as usize);

        ret = (cap.words[0] & 0x7fusize) >> 0;
        /* Possibly sign extend */
        if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
            ret |= 0x0;
        }
        return ret;
    }
}

#[inline]
pub fn Zombie_new(number: usize, _type: usize, ptr: usize) -> *const cap_t {
    let mask: usize;
    if _type == ZombieType_ZombieTCB {
        mask = MASK!(TCB_CNODE_RADIX + 1);
    } else {
        mask = MASK!(_type + 1);
    }
    return cap_zombie_cap_new((ptr & !mask) | (number & mask), _type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieBits(_cap: *const cap_t) -> usize {
    let _type = cap_zombie_cap_get_capZombieType(_cap);
    if _type == ZombieType_ZombieTCB {
        return TCB_CNODE_RADIX;
    }
    return ZombieType_ZombieCNode(_type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieNumber(_cap: *const cap_t) -> usize {
    let radix = cap_zombie_cap_get_capZombieBits(_cap);
    return cap_zombie_cap_get_capZombieID(_cap) & MASK!(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_get_capZombiePtr(cap: *const cap_t) -> usize {
    let radix = cap_zombie_cap_get_capZombieBits(cap);
    return cap_zombie_cap_get_capZombieID(cap) & !MASK!(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_set_capZombieNumber(_cap: *const cap_t, n: usize) -> *const cap_t {
    unsafe {
        let cap = cap_t {
            words: (*_cap).words,
        };
        let radix = cap_zombie_cap_get_capZombieBits((&cap) as *const cap_t);
        let ptr = cap_zombie_cap_get_capZombieID((&cap) as *const cap_t) & !MASK!(radix + 1);
        cap_zombie_cap_set_capZombieID((&cap) as *const cap_t, ptr | (n & MASK!(radix + 1)))
    }
}

#[inline]
pub fn cap_page_table_cap_new(
    capPTMappedASID: usize,
    capPTBasePtr: usize,
    capPTIsMapped: usize,
    capPTMappedAddress: usize,
) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();

        cap.words[0] = 0
            | (cap_page_table_cap as usize & 0x1fusize) << 59
            | (capPTIsMapped & 0x1usize) << 39
            | (capPTMappedAddress & 0x7fffffffffusize) >> 0;
        cap.words[1] =
            0 | (capPTMappedASID & 0xffffusize) << 48 | (capPTBasePtr & 0x7fffffffffusize) << 9;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_page_table_cap_get_capPTMappedASID(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[1] & 0xffff000000000000usize) >> 48;
        ret
    }
}

#[inline]
pub fn cap_page_table_cap_set_capPTMappedASID(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[1] &= !0xffff000000000000usize;
        cap.words[1] |= (v64 << 48) & 0xffff000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_page_table_cap_get_capPTBasePtr(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[1] & 0xfffffffffe00usize) >> 9;
        ret
    }
}

#[inline]
pub fn cap_page_table_cap_get_capPTIsMapped(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x8000000000usize) >> 39;
        ret
    }
}

#[inline]
pub fn cap_page_table_cap_set_capPTIsMapped(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[0] &= !0x8000000000usize;
        cap.words[0] |= (v64 << 39) & 0x8000000000usize;
        (&cap) as *const cap_t
    }
}

#[inline]
pub fn cap_page_table_cap_ptr_set_capPTIsMapped(_cap: *const cap_t, v64: usize) {
    unsafe {
        let mut cap = *(_cap as *mut cap_t);
        cap.words[0] &= !0x8000000000usize;
        cap.words[0] |= (v64 << 39) & 0x8000000000usize;
    }
}
#[inline]
pub fn cap_page_table_cap_get_capPTMappedAddress(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x7fffffffffusize) << 0;
        ret
    }
}

#[inline]
pub fn cap_page_table_cap_set_capPTMappedAddress(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[0] &= !0x7fffffffffusize;
        cap.words[0] |= (v64 >> 0) & 0x7fffffffffusize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_frame_cap_new(
    capFMappedASID: usize,
    capFBasePtr: usize,
    capFSize: usize,
    capFVMRights: usize,
    capFIsDevice: usize,
    capFMappedAddress: usize,
) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        cap.words[0] = 0
            | (cap_frame_cap & 0x1fusize) << 59
            | (capFSize & 0x3usize) << 57
            | (capFVMRights & 0x3usize) << 55
            | (capFIsDevice & 0x1usize) << 54
            | (capFMappedAddress & 0x7fffffffffusize) >> 0;
        cap.words[1] =
            0 | (capFMappedASID & 0xffffusize) << 48 | (capFBasePtr & 0x7fffffffffusize) << 9;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_frame_cap_get_capFMappedASID(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[1] & 0xffff000000000000usize) >> 48;
        ret
    }
}

#[inline]
pub fn cap_frame_cap_set_capFMappedASID(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[1] &= !0xffff000000000000usize;
        cap.words[1] |= (v64 << 48) & 0xffff000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_frame_cap_get_capFBasePtr(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[1] & 0xfffffffffe00usize) >> 9;
        ret
    }
}

#[inline]
pub fn cap_frame_cap_get_capFSize(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x600000000000000usize) >> 57;
        ret
    }
}

#[inline]
pub fn cap_frame_cap_get_capFVMRights(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x180000000000000usize) >> 55;
        ret
    }
}

#[inline]
pub fn cap_frame_cap_set_capFVMRights(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[0] &= !0x180000000000000usize;
        cap.words[0] |= (v64 << 55) & 0x180000000000000usize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn cap_frame_cap_get_capFIsDevice(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x40000000000000usize) >> 54;
        ret
    }
}

#[inline]
pub fn cap_frame_cap_get_capFMappedAddress(_cap: *const cap_t) -> usize {
    unsafe {
        let cap = *_cap;
        let ret = (cap.words[0] & 0x7fffffffffusize) << 0;
        ret
    }
}
#[inline]
pub fn cap_frame_cap_set_capFMappedAddress(_cap: *const cap_t, v64: usize) -> *const cap_t {
    unsafe {
        let mut cap = cap_t {
            words: (*_cap).words,
        };
        cap.words[0] &= !0x7fffffffffusize;
        cap.words[0] |= (v64 >> 0) & 0x7fffffffffusize;
        return (&cap) as *const cap_t;
    }
}

#[inline]
pub fn pte_ptr_get_ppn(pte_ptr: *const usize) -> usize {
    unsafe {
        let ret = ((*pte_ptr) & 0x3ffffffffffc00usize) >> 10;
        ret
    }
}
#[inline]
pub fn pte_ptr_get_execute(pte_ptr: *const usize) -> usize {
    unsafe {
        let ret = ((*pte_ptr) & 0x8usize) >> 3;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_write(pte_ptr: *const usize) -> usize {
    unsafe {
        let ret = ((*pte_ptr) & 0x4usize) >> 2;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_read(pte_ptr: *const usize) -> usize {
    unsafe {
        let ret = ((*pte_ptr) & 0x2usize) >> 1;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_valid(pte_ptr: *const usize) -> usize {
    unsafe {
        let ret = ((*pte_ptr) & 0x1usize) >> 0;
        ret
    }
}

#[inline]
pub fn cap_asid_cap_new(capASIDBase: usize, capASIDPool: usize) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        cap.words[0] = 0
            | (cap_asid_pool_cap & 0x1fusize) << 59
            | (capASIDBase & 0xffffusize) << 43
            | (capASIDPool & 0x7ffffffffcusize) >> 2;
        cap.words[1] = 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_asid_pool_cap_get_capASIDBase(cap: *const cap_t) -> usize {
    unsafe {
        let ret = ((*cap).words[0] & 0x7fff80000000000usize) >> 43;
        ret
    }
}

#[inline]
pub fn cap_asid_pool_cap_get_capASIDPool(cap: *const cap_t) -> usize {
    unsafe {
        let ret = ((*cap).words[0] & 0x1fffffffffusize) << 2;
        ret
    }
}

#[inline]
pub fn thread_state_new() -> *const thread_state_t {
    unsafe {
        let size = size_of::<thread_state_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut thread_state_t;
        let state = thread_state_t { words: [0; 3] };
        *ptr = state;
        ptr
    }
}

#[inline]
pub fn thread_state_get_blockingIPCBadge(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = (*thread_state_ptr).words[2] & 0xffffffffffffffffusize;
        ret
    }
}

#[inline]
pub fn thread_state_set_blockingIPCBadge(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[2] &= !0xffffffffffffffffusize;
        (*thread_state_ptr).words[2] |= v64 & 0xffffffffffffffffusize;
    }
}

#[inline]
pub fn thread_state_get_blockingIPCCanGrant(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = ((*thread_state_ptr).words[1] & 0x8usize) >> 3;
        ret
    }
}

#[inline]
pub fn thread_state_set_blockingIPCCanGrant(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[1] &= !0x8usize;
        (*thread_state_ptr).words[1] |= (v64 << 3) & 0x8usize;
    }
}

#[inline]
pub fn thread_state_get_blockingIPCCanGrantReply(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = ((*thread_state_ptr).words[1] & 0x4usize) >> 2;
        ret
    }
}

#[inline]
pub fn thread_state_set_blockingIPCCanGrantReply(
    thread_state_ptr: *mut thread_state_t,
    v64: usize,
) {
    unsafe {
        (*thread_state_ptr).words[1] &= !0x4usize;
        (*thread_state_ptr).words[1] |= (v64 << 2) & 0x4usize;
    }
}

#[inline]
pub fn thread_state_get_blockingIPCIsCall(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = ((*thread_state_ptr).words[1] & 0x2usize) >> 1;
        ret
    }
}

#[inline]
pub fn thread_state_set_blockingIPCIsCall(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[1] &= !0x2usize;
        (*thread_state_ptr).words[1] |= (v64 << 1) & 0x2usize;
    }
}

#[inline]
pub fn thread_state_get_tcbQueued(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = ((*thread_state_ptr).words[1] & 0x1usize) >> 0;
        ret
    }
}

#[inline]
pub fn thread_state_set_tcbQueued(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[1] &= !0x1usize;
        (*thread_state_ptr).words[1] |= (v64 << 0) & 0x1usize;
    }
}

#[inline]
pub fn thread_state_get_blockingObject(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = ((*thread_state_ptr).words[0] & 0x7ffffffff0usize) << 0;
        ret
    }
}

#[inline]
pub fn thread_state_set_blockingObject(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[0] &= !0x7ffffffff0usize;
        (*thread_state_ptr).words[0] |= (v64 >> 0) & 0x7ffffffff0usize;
    }
}

#[inline]
pub fn thread_state_get_tsType(thread_state_ptr: *const thread_state_t) -> usize {
    unsafe {
        let ret = (*thread_state_ptr).words[0] & 0xfusize;
        ret
    }
}

#[inline]
pub fn thread_state_set_tsType(thread_state_ptr: *mut thread_state_t, v64: usize) {
    unsafe {
        (*thread_state_ptr).words[0] &= !0xfusize;
        (*thread_state_ptr).words[0] |= v64 & 0xfusize;
    }
}

#[inline]
pub fn cap_domain_cap_new() -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        cap.words[0] = 0 | (cap_domain_cap & 0x1fusize) << 59;
        cap.words[1] = 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn endpoint_ptr_set_epQueue_head(ptr: *mut endpoint_t, v64: usize) {
    unsafe {
        (*ptr).words[1] &= !0xffffffffffffffffusize;
        (*ptr).words[1] |= (v64 << 0) & 0xffffffffffffffff;
    }
}

#[inline]
pub fn endpoint_ptr_get_epQueue_head(ptr: *const endpoint_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[1] & 0xffffffffffffffffusize) >> 0;
        ret
    }
}

#[inline]
pub fn endpoint_ptr_set_epQueue_tail(ptr: *mut endpoint_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x7ffffffffcusize;
        (*ptr).words[0] |= (v64 << 0) & 0x7ffffffffc;
    }
}

#[inline]
pub fn endpoint_ptr_get_epQueue_tail(ptr: *const endpoint_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0x7ffffffffcusize) >> 0;
        ret
    }
}

#[inline]
pub fn endpoint_ptr_set_state(ptr: *mut endpoint_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x3usize;
        (*ptr).words[0] |= (v64 << 0) & 0x3;
    }
}

#[inline]
pub fn endpoint_ptr_get_state(ptr: *const endpoint_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0x3usize) >> 0;
        ret
    }
}

#[inline]
pub fn cap_reply_cap_new(
    capReplyCanGrant: usize,
    capReplyMaster: usize,
    capTCBPtr: usize,
) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        cap.words[0] = 0
            | (capReplyCanGrant & 0x1usize) << 1
            | (capReplyMaster & 0x1usize) << 0
            | (cap_reply_cap & 0x1fusize) << 59;
        cap.words[1] = 0 | capTCBPtr << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_reply_cap_get_capTCBPtr(cap: *const cap_t) -> usize {
    unsafe {
        let ret = (*cap).words[1] & 0xffffffffffffffffusize;
        ret
    }
}

#[inline]
pub fn cap_reply_cap_get_capReplyCanGrant(cap: *const cap_t) -> usize {
    unsafe {
        let ret = ((*cap).words[0] & 0x2usize) >> 1;
        ret
    }
}

#[inline]
pub fn cap_reply_cap_set_capReplyCanGrant(cap: *mut cap_t, v64: usize) {
    unsafe {
        (*cap).words[0] &= !0x2usize;
        (*cap).words[0] |= (v64 << 1) & 0x2usize;
    }
}

#[inline]
pub fn cap_reply_cap_get_capReplyMaster(cap: *const cap_t) -> usize {
    unsafe {
        let ret = ((*cap).words[0] & 0x1usize) >> 0;
        ret
    }
}

#[inline]
pub fn cap_thread_cap_new(capTCBPtr: usize) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let cap = cap_t {
            words: [
                0 | (cap_thread_cap & 0x1fusize) << 59 | (capTCBPtr & 0x7fffffffffusize) >> 0,
                0,
            ],
        };
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_thread_cap_get_capTCBPtr(cap: *const cap_t) -> usize {
    let ret: usize;
    unsafe {
        ret = ((*cap).words[0] & 0x7fffffffffusize) << 0;
    }
    ret
}

#[derive(Copy, Clone, Debug)]
pub struct notification_t {
    words: [usize; 4],
}

#[inline]
pub fn notification_ptr_get_ntfnBoundTCB(notification_ptr: *const notification_t) -> usize {
    let ret: usize;
    unsafe {
        ret = (*notification_ptr).words[3] & 0x7fffffffffusize;
    }
    ret
}

#[inline]
pub fn notification_ptr_set_ntfnBoundTCB(ptr: *mut notification_t, v64: usize) {
    unsafe {
        (*ptr).words[3] &= !0x7fffffffffusize;
        (*ptr).words[3] |= (v64 >> 0) & 0x7fffffffffusize;
    }
}

#[inline]
pub fn notification_ptr_get_ntfnMsgIdentifier(notification_ptr: *const notification_t) -> usize {
    let ret: usize;
    unsafe {
        ret = (*notification_ptr).words[2] & 0xffffffffffffffffusize;
    }
    ret
}

#[inline]
pub fn notification_ptr_set_ntfnMsgIdentifier(ptr: *mut notification_t, v64: usize) {
    unsafe {
        (*ptr).words[2] &= !0xffffffffffffffffusize;
        (*ptr).words[2] |= (v64 >> 0) & 0xffffffffffffffffusize;
    }
}

#[inline]
pub fn notification_ptr_get_ntfnQueue_head(notification_ptr: *const notification_t) -> usize {
    let ret: usize;
    unsafe {
        ret = (*notification_ptr).words[1] & 0x7fffffffffusize;
    }
    ret
}

#[inline]
pub fn notification_ptr_set_ntfnQueue_head(ptr: *mut notification_t, v64: usize) {
    unsafe {
        (*ptr).words[1] &= !0x7fffffffffusize;
        (*ptr).words[1] |= (v64 >> 0) & 0x7fffffffffusize;
    }
}

#[inline]
pub fn notification_ptr_get_ntfnQueue_tail(notification_ptr: *const notification_t) -> usize {
    let ret: usize;
    unsafe {
        ret = (*notification_ptr).words[0] & 0xfffffffffe000000usize;
    }
    ret
}

#[inline]
pub fn notification_ptr_set_ntfnQueue_tail(ptr: *mut notification_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0xfffffffffe000000usize;
        (*ptr).words[0] |= (v64 >> 0) & 0xfffffffffe000000usize;
    }
}

#[inline]
pub fn notification_ptr_get_state(notification_ptr: *const notification_t) -> usize {
    let ret: usize;
    unsafe {
        ret = (*notification_ptr).words[0] & 0x3usize;
    }
    ret
}

#[inline]
pub fn notification_ptr_set_state(ptr: *mut notification_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x3usize;
        (*ptr).words[0] |= (v64 >> 0) & 0x3usize;
    }
}

pub fn cap_notification_cap_new(
    capNtfnBadge: usize,
    capNtfnCanReceive: usize,
    capNtfnCanSend: usize,
    capNtfnPtr: usize,
) -> *const cap_t {
    unsafe {
        let size = size_of::<cap_t>();
        let layout = Layout::from_size_align(size, 4).ok().unwrap();
        let ptr = alloc::alloc::alloc(layout) as *mut cap_t;
        let mut cap = cap_t::default();
        cap.words[0] = 0
            | (cap_notification_cap & 0x1fusize) << 59
            | (capNtfnCanReceive & 0x1usize) << 58
            | (capNtfnCanSend & 0x1usize) << 57
            | (capNtfnPtr & 0x7fffffffffusize) >> 0;
        cap.words[1] = 0 | capNtfnBadge << 0;
        *ptr = cap;
        ptr
    }
}

#[inline]
pub fn cap_notification_cap_get_capNtfnBadge(cap: *const cap_t) -> usize {
    unsafe {
        let ret = (*cap).words[1] & 0xffffffffffffffffusize;
        ret
    }
}


#[inline] 
pub fn cap_notification_cap_set_capNtfnBadge(cap:*mut cap_t,v64:usize){
    unsafe{
        (*cap).words[1]&=!0xffffffffffffffffusize;
        (*cap).words[1]|=v64 &0xffffffffffffffffusize;
    }
}


#[inline]
pub fn cap_notification_cap_get_capNtfnCanReceive(cap: *const cap_t) -> usize {
    unsafe {
        let ret = (*cap).words[0] & 0x400000000000000usize;
        ret
    }
}


#[inline] 
pub fn cap_notification_cap_set_capNtfnCanReceive(cap:*mut cap_t,v64:usize){
    unsafe{
        (*cap).words[0]&=!0x400000000000000usize;
        (*cap).words[0]|=v64 &0x400000000000000usize;
    }
}

#[inline]
pub fn cap_notification_cap_get_capNtfnCanSend(cap: *const cap_t) -> usize {
    unsafe {
        let ret = (*cap).words[0] & 0x200000000000000usize;
        ret
    }
}


#[inline] 
pub fn cap_notification_cap_set_capNtfnCanSend(cap:*mut cap_t,v64:usize){
    unsafe{
        (*cap).words[0]&=!0x200000000000000usize;
        (*cap).words[0]|=v64 &0x200000000000000usize;
    }
}

#[inline]
pub fn cap_notification_cap_get_capNtfnPtr(cap: *const cap_t) -> usize {
    unsafe {
        let ret = (*cap).words[0] & 0x7fffffffffusize;
        ret
    }
}


#[inline] 
pub fn cap_notification_cap_set_capNtfnPtr(cap:*mut cap_t,v64:usize){
    unsafe{
        (*cap).words[0]&=!0x7fffffffffusize;
        (*cap).words[0]|=v64 &0x7fffffffffusize;
    }
}