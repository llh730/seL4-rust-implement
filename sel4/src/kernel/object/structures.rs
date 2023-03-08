extern crate alloc;
//CSpace relevant
use alloc::rc::Rc;
use core::cell::RefCell;
use core::default::Default;
use core::intrinsics::{likely, unlikely};

use super::objecttype::*;

//zombie config
pub const wordRadix: u64 = 6;
pub const ZombieType_ZombieTCB: u64 = 1u64 << wordRadix;
pub const TCB_CNODE_RADIX: u64 = 4;
pub fn ZombieType_ZombieCNode(n: u64) -> u64 {
    return n & MASK(wordRadix);
}
#[derive(Debug)]
#[derive(PartialEq)]
pub struct cap_t {
    pub words: [u64; 2],
}

impl Default for cap_t {
    fn default() -> Self {
        cap_t { words: [0; 2] }
    }
}
#[derive(Debug)]
#[derive(PartialEq)]
pub struct mdb_node_t {
    pub words: [u64; 2],
}

impl Default for mdb_node_t {
    fn default() -> Self {
        mdb_node_t { words: [0; 2] }
    }
}
#[derive(Debug)]
#[derive(PartialEq)]
pub struct cte_t {
    pub cap: Rc<RefCell<cap_t>>,
    pub cteMDBNode: Rc<RefCell<mdb_node_t>>,
}

impl Default for cte_t {
    fn default() -> Self {
        cte_t {
            cap: Rc::new(RefCell::new(Default::default())),
            cteMDBNode: Rc::new(RefCell::new(Default::default())),
        }
    }
}

pub struct finaliseSlot_ret {
    pub status: exception_t,
    pub success: bool,
    pub cleanupInfo: Rc<RefCell<cap_t>>,
}

impl Default for finaliseSlot_ret {
    fn default() -> Self {
        finaliseSlot_ret {
            status: exception_t::EXCEPTION_NONE,
            success: true,
            cleanupInfo: Rc::new(RefCell::new(cap_t::default())),
        }
    }
}

struct deriveCap_ret {
    pub status: exception_t,
    pub cap: Rc<RefCell<cap_t>>,
}

impl Default for deriveCap_ret {
    fn default() -> Self {
        deriveCap_ret {
            status: exception_t::EXCEPTION_NONE,
            cap: Rc::new(RefCell::new(cap_t::default())),
        }
    }
}

pub struct finaliseCap_ret {
    pub remainder: Rc<RefCell<cap_t>>,
    pub cleanupInfo: Rc<RefCell<cap_t>>,
}

impl Default for finaliseCap_ret {
    fn default() -> Self {
        finaliseCap_ret {
            remainder: Rc::new(RefCell::new(cap_t::default())),
            cleanupInfo: Rc::new(RefCell::new(cap_t::default())),
        }
    }
}

pub struct endpoint_t {
    words: [u64; 2],
}

type word_t = u64;
type bool_t = u64;
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
    mdbNext: u64,
    mdbRevocable: u64,
    mdbFirstBadged: u64,
    mdbPrev: u64,
) -> Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t::default();

    /* fail if user has passed bits that we will override */
    assert!(
        (mdbNext & !0x7ffffffffcu64)
            == if true && (mdbNext & (1u64 << 38)) != 0 {
                0xffffff8000000000
            } else {
                0
            }
    );
    assert!(
        (mdbRevocable & !0x1u64)
            == if true && (mdbRevocable & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            }
    );
    assert!(
        (mdbFirstBadged & !0x1u64)
            == if true && (mdbFirstBadged & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            }
    );

    //FIXMe::Why 0???
    mdb_node.words[0] = 0 | mdbPrev << 0;

    mdb_node.words[1] = 0
        | (mdbNext & 0x7ffffffffcu64) >> 0
        | (mdbRevocable & 0x1u64) << 1
        | (mdbFirstBadged & 0x1u64) << 0;

    Rc::new(RefCell::new(mdb_node))
}

#[inline]
pub fn mdb_node_get_mdbNext(_mdb_node: Rc<RefCell<mdb_node_t>>) -> u64 {
    let mdb_node = _mdb_node.borrow();
    let mut ret: u64;
    ret = (mdb_node.words[1] & 0x7ffffffffcu64) << 0;
    /* Possibly sign extend */
    if core::intrinsics::likely(!!(true && (ret & (1u64 << 38) != 0))) {
        ret |= 0xffffff8000000000;
    }
    ret
}

#[inline]
pub fn mdb_node_ptr_set_mdbNext(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: u64) {
    let mut mdb_node = _mdb_node.borrow_mut();

    assert!(
        (((!0x7ffffffffcu64 << 0) | 0xffffff8000000000) & v64)
            == if true && (v64 & (1u64 << (38))) != 0 {
                0xffffff8000000000
            } else {
                0
            }
    );
    mdb_node.words[1] = !0x7ffffffffcu64;
    mdb_node.words[1] |= (v64 >> 0) & 0x7ffffffffc;
}

#[inline]
pub fn mdb_node_get_mdbRevocable(_mdb_node: Rc<RefCell<mdb_node_t>>) -> u64 {
    let mdb_node = _mdb_node.borrow();
    let mut ret: u64;
    ret = (mdb_node.words[1] & 0x2u64) >> 1;
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbRevocable(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: u64)->Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t{words:_mdb_node.borrow().words.clone()};
    assert!(
        (((!0x2u64 >> 1) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );
    mdb_node.words[1] &= !0x2u64;
    mdb_node.words[1] |= (v64 << 1) & 0x2;
    return Rc::new(RefCell::new(mdb_node));
}

#[inline]
pub fn mdb_node_get_mdbFirstBadged(_mdb_node: Rc<RefCell<mdb_node_t>>) -> u64 {
    let mdb_node = _mdb_node.borrow();
    let mut ret: u64;
    ret = (mdb_node.words[1] & 0x1u64) >> 0;
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbFirstBadged(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: u64)->Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t{words:_mdb_node.borrow().words.clone()};
    assert!(
        (((!0x1u64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );
    mdb_node.words[1] &= !0x1u64;
    mdb_node.words[1] |= (v64 << 0) & 0x1u64;
    return Rc::new(RefCell::new(mdb_node));
}

#[inline]
pub fn mdb_node_get_mdbPrev(_mdb_node: Rc<RefCell<mdb_node_t>>) -> u64 {
    let mdb_node = _mdb_node.borrow();
    let mut ret: u64;
    ret = (mdb_node.words[0] & 0xffffffffffffffffu64) >> 0;
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbPrev(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: u64)->Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t{words:_mdb_node.borrow().words.clone()};
    assert!(
        (((!0xffffffffffffffffu64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );
    mdb_node.words[0] &= !0xffffffffffffffffu64;
    mdb_node.words[0] |= (v64 << 0) & 0xffffffffffffffffu64;
    return Rc::new(RefCell::new(mdb_node));
}


#[inline]
pub fn mdb_node_ptr_set_mdbPrev(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: u64) {
    let mut mdb_node = _mdb_node.borrow_mut();
    assert!(
        (((!0xffffffffffffffffu64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );
    mdb_node.words[0] &= !0xffffffffffffffffu64;
    mdb_node.words[0] |= (v64 << 0) & 0xffffffffffffffffu64;
}

//cap relevant

#[inline]
pub fn cap_get_max_free_index(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let ans = cap_untyped_cap_get_capBlockSize(_cap.clone());
    let sel4_MinUntypedbits: u64 = 4;
    (1u64 << ans) - sel4_MinUntypedbits
}

#[inline]
pub fn cap_get_capType(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    (cap.words[0] >> 59) & 0x1fu64
}

#[inline]
pub fn cap_capType_equals(_cap: Rc<RefCell<cap_t>>, cap_type_tag: u64) -> i32 {
    let cap = _cap.borrow();
    (((cap.words[0] >> 59) & 0x1fu64) == cap_type_tag) as i32
}

#[inline]
pub fn cap_null_cap_new() -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    assert!(
        (cap_tag_t::cap_null_cap as u64 & !0x1fu64)
            == (if true && (cap_tag_t::cap_null_cap as u64 & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] = 0 | (cap_tag_t::cap_null_cap as u64 & 0x1fu64) << 59;
    cap.words[1] = 0;

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_untyped_cap_new(
    capFreeIndex: u64,
    capIsDevice: u64,
    capBlockSize: u64,
    capPtr: u64,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    assert!(
        (capFreeIndex & !0x7fffffffffu64)
            == (if true && (capFreeIndex & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capIsDevice & !0x1u64)
            == (if true && (capIsDevice & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capBlockSize & !0x3fu64)
            == (if true && (capBlockSize & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (cap_tag_t::cap_untyped_cap as u64 & !0x1fu64)
            == (if true && (cap_tag_t::cap_untyped_cap as u64 & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capPtr & !0x7fffffffffu64)
            == (if true && (capPtr & (1u64 << 38)) != 0 {
                0xffffff8000000000
            } else {
                0
            })
    );

    cap.words[0] =
        0 | (cap_tag_t::cap_untyped_cap as u64 & 0x1fu64) << 59 | (capPtr & 0x7fffffffffu64) >> 0;
    cap.words[1] = 0
        | (capFreeIndex & 0x7fffffffffu64) << 25
        | (capIsDevice & 0x1u64) << 6
        | (capBlockSize & 0x3fu64) << 0;

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_untyped_cap_get_capIsDevice(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);
    ret = (cap.words[1] & 0x40u64) >> 6;
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_untyped_cap_get_capBlockSize(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);
    ret = (cap.words[1] & 0x3fu64) >> 0;
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}
#[inline]
pub fn cap_untyped_cap_get_capFreeIndex(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);

    ret = (cap.words[1] & 0xfffffffffe000000u64) >> 25;
    if unlikely(!!(false && (ret & (1u64 << (38)) != 0))) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_untyped_cap_set_capFreeIndex(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    // let mut cap=Rc::new(RefCell::)
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0xfffffffffe000000u64 >> 25) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[1] &= !0xfffffffffe000000u64;
    cap.words[1] |= (v64 << 25) & 0xfffffffffe000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_untyped_cap_ptr_set_capFreeIndex(_cap: Rc<RefCell<cap_t>>, v64: u64) {
    let mut cap = _cap.borrow_mut();
    // let mut cap=Rc::new(RefCell::)
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0xfffffffffe000000u64 >> 25) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[1] &= !0xfffffffffe000000u64;
    cap.words[1] |= (v64 << 25) & 0xfffffffffe000000u64;
}


#[inline]
pub fn cap_untyped_cap_get_capPtr(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as u64);

    ret = (cap.words[0] & 0x7fffffffffu64) << 0;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1u64 << (38))) != 0)) {
        ret |= 0xffffff8000000000;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_new(
    capEPBadge: u64,
    capCanGrantReply: u64,
    capCanGrant: u64,
    capCanSend: u64,
    capCanReceive: u64,
    capEPPtr: u64,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    /* fail if user has passed bits that we will override */
    assert!(
        (capCanGrantReply & !0x1u64)
            == (if true && (capCanGrantReply & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capCanGrant & !0x1u64)
            == (if true && (capCanGrant & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capCanSend & !0x1u64)
            == (if true && (capCanSend & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capCanReceive & !0x1u64)
            == (if true && (capCanReceive & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capEPPtr & !0x7fffffffffu64)
            == (if true && (capEPPtr & (1u64 << 38)) != 0 {
                0xffffff8000000000
            } else {
                0
            })
    );
    assert!(
        (cap_tag_t::cap_endpoint_cap as u64 & !0x1fu64)
            == (if true && (cap_tag_t::cap_endpoint_cap as u64 & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] = 0
        | (capCanGrantReply & 0x1u64) << 58
        | (capCanGrant & 0x1u64) << 57
        | (capCanSend & 0x1u64) << 55
        | (capCanReceive & 0x1u64) << 56
        | (capEPPtr & 0x7fffffffffu64) >> 0
        | (cap_tag_t::cap_endpoint_cap as u64 & 0x1fu64) << 59;
    cap.words[1] = 0 | capEPBadge << 0;

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_endpoint_cap_get_capEPBadge(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[1] & 0xffffffffffffffffu64) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capEPBadge(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0xffffffffffffffffu64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[1] &= !0xffffffffffffffffu64;
    cap.words[1] |= (v64 << 0) & 0xffffffffffffffffu64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrantReply(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[0] & 0x400000000000000u64) >> 58;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanGrantReply(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0x400000000000000u64 >> 58) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );
    cap.words[0] &= !0x400000000000000u64;
    cap.words[0] |= (v64 << 58) & 0x400000000000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrant(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[0] & 0x200000000000000u64) >> 57;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}
#[inline]
pub fn cap_endpoint_cap_set_capCanGrant(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0x200000000000000u64 >> 57) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] &= !0x200000000000000u64;
    cap.words[0] |= (v64 << 57) & 0x200000000000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanReceive(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret: u64;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[0] & 0x100000000000000u64) >> 56;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanReceive(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0x100000000000000u64 >> 56) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] &= !0x100000000000000u64;
    cap.words[0] |= (v64 << 56) & 0x100000000000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanSend(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret: u64;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[0] & 0x80000000000000u64) >> 55;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanSend(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0x80000000000000u64 >> 55) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] &= !0x80000000000000u64;
    cap.words[0] |= (v64 << 55) & 0x80000000000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capEPPtr(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as u64);

    ret = (cap.words[0] & 0x7fffffffffu64) << 0;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1u64 << (38))) != 0)) {
        ret |= 0xffffff8000000000;
    }
    return ret;
}

//FIXME::notification relevant cap not implemented

//FIXME::reply relevant cap not implemented

#[inline]
pub fn cap_cnode_cap_new(
    capCNodeRadix: u64,
    capCNodeGuardSize: u64,
    capCNodeGuard: u64,
    capCNodePtr: u64,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    /* fail if user has passed bits that we will override */
    assert!(
        (capCNodeRadix & !0x3fu64)
            == (if true && (capCNodeRadix & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capCNodeGuardSize & !0x3fu64)
            == (if true && (capCNodeGuardSize & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capCNodePtr & !0x7ffffffffeu64)
            == (if true && (capCNodePtr & (1u64 << 38)) != 0 {
                0xffffff8000000000
            } else {
                0
            })
    );
    assert!(
        (cap_tag_t::cap_cnode_cap as u64 & !0x1fu64)
            == (if true && (cap_tag_t::cap_cnode_cap as u64 & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] = 0
        | (capCNodeRadix & 0x3fu64) << 47
        | (capCNodeGuardSize & 0x3fu64) << 53
        | (capCNodePtr & 0x7ffffffffeu64) >> 1
        | (cap_tag_t::cap_cnode_cap as u64 & 0x1fu64) << 59;
    cap.words[1] = 0 | capCNodeGuard << 0;

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuard(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret: u64;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);

    ret = (cap.words[1] & 0xffffffffffffffffu64) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuard(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0xffffffffffffffffu64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[1] &= !0xffffffffffffffffu64;
    cap.words[1] |= (v64 << 0) & 0xffffffffffffffffu64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuardSize(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret: u64;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);

    ret = (cap.words[0] & 0x7e0000000000000u64) >> 53;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuardSize(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0x7e0000000000000u64 >> 53) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] &= !0x7e0000000000000u64;
    cap.words[0] |= (v64 << 53) & 0x7e0000000000000u64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeRadix(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let cap = _cap.borrow();
    let mut ret;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);

    ret = (cap.words[0] & 0x1f800000000000u64) >> 47;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_get_capCNodePtr(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret: u64;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as u64);

    ret = (cap.words[0] & 0x3fffffffffu64) << 1;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1u64 << (38))) != 0)) {
        ret |= 0xffffff8000000000;
    }
    return ret;
}

#[inline]
pub fn isArchCap(_cap: Rc<RefCell<cap_t>>) -> bool {
    cap_get_capType(_cap) % 2 != 0
}

//zombie cap relevant
#[inline]
pub fn cap_zombie_cap_new(capZombieID: u64, capZombieType: u64) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    /* fail if user has passed bits that we will override */
    assert!(
        (cap_tag_t::cap_zombie_cap as u64 & !0x1fu64)
            == (if true && (cap_tag_t::cap_zombie_cap as u64 & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );
    assert!(
        (capZombieType & !0x7fu64)
            == (if true && (capZombieType & (1u64 << 38)) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[0] =
        0 | (cap_tag_t::cap_zombie_cap as u64 & 0x1fu64) << 59 | (capZombieType & 0x7fu64) << 0;
    cap.words[1] = 0 | capZombieID << 0;

    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_zombie_cap_get_capZombieID(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as u64);

    ret = (cap.words[1] & 0xffffffffffffffffu64) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_zombie_cap_set_capZombieID(_cap: Rc<RefCell<cap_t>>, v64: u64)->Rc<RefCell<cap_t>> {
    let mut cap = cap_t{words:_cap.borrow().words.clone()};
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as u64);
    /* fail if user has passed bits that we will override */
    assert!(
        (((!0xffffffffffffffffu64 >> 0) | 0x0) & v64)
            == (if false && (v64 & (1u64 << (38))) != 0 {
                0x0
            } else {
                0
            })
    );

    cap.words[1] &= !0xffffffffffffffffu64;
    cap.words[1] |= (v64 << 0) & 0xffffffffffffffffu64;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_zombie_cap_get_capZombieType(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let mut ret;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as u64);

    ret = (cap.words[0] & 0x7fu64) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1u64 << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn Zombie_new(number: u64, _type: u64, ptr: u64) -> Rc<RefCell<cap_t>> {
    let mask: u64;
    if _type == ZombieType_ZombieTCB {
        mask = MASK(TCB_CNODE_RADIX + 1);
    } else {
        mask = MASK(_type + 1);
    }
    return cap_zombie_cap_new((ptr & !mask) | (number & mask), _type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieBits(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let _type = cap_zombie_cap_get_capZombieType(_cap.clone());
    if _type == ZombieType_ZombieTCB {
        return TCB_CNODE_RADIX;
    }
    return ZombieType_ZombieCNode(_type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieNumber(_cap: Rc<RefCell<cap_t>>) -> u64 {
    let radix = cap_zombie_cap_get_capZombieBits(_cap.clone());
    return cap_zombie_cap_get_capZombieID(_cap.clone()) & MASK(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_get_capZombiePtr(cap: Rc<RefCell<cap_t>>) -> u64 {
    let radix = cap_zombie_cap_get_capZombieBits(cap.clone());
    return cap_zombie_cap_get_capZombieID(cap.clone()) & !MASK(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_set_capZombieNumber(_cap: Rc<RefCell<cap_t>>, n: u64)->Rc<RefCell<cap_t>> {
    let cap = Rc::new(RefCell::new(cap_t{words:_cap.borrow().words.clone()}));
    let radix = cap_zombie_cap_get_capZombieBits(cap.clone());
    let ptr = cap_zombie_cap_get_capZombieID(cap.clone()) & !MASK(radix + 1);
    cap_zombie_cap_set_capZombieID(cap.clone(), ptr | (n & MASK(radix + 1)))
}
