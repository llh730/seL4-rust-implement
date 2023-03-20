extern crate alloc;
//CSpace relevant
use alloc::rc::Rc;
use core::cell::RefCell;
use core::default::Default;
use core::intrinsics::{likely, unlikely};

use crate::MASK;

use super::objecttype::*;

//zombie config
pub const wordRadix: usize = 6;
pub const ZombieType_ZombieTCB: usize = 1usize << wordRadix;
pub const TCB_CNODE_RADIX: usize = 4;
pub fn ZombieType_ZombieCNode(n: usize) -> usize {
    return n & MASK!(wordRadix);
}
#[derive(Debug, PartialEq)]
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
#[derive(Debug, PartialEq)]
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
) -> Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t::default();

    /* fail if user has passed bits that we will override */
    assert!(
        (mdbNext & !0x7ffffffffcusize)
            == if true && (mdbNext & (1usize << 38)) != 0 {
                0xffffff8000000000
            } else {
                0
            }
    );
    assert!(
        (mdbRevocable & !0x1usize)
            == if true && (mdbRevocable & (1usize << 38)) != 0 {
                0x0
            } else {
                0
            }
    );
    assert!(
        (mdbFirstBadged & !0x1usize)
            == if true && (mdbFirstBadged & (1usize << 38)) != 0 {
                0x0
            } else {
                0
            }
    );

    //FIXMe::Why 0???
    mdb_node.words[0] = 0 | mdbPrev << 0;

    mdb_node.words[1] = 0
        | (mdbNext & 0x7ffffffffcusize) >> 0
        | (mdbRevocable & 0x1usize) << 1
        | (mdbFirstBadged & 0x1usize) << 0;

    Rc::new(RefCell::new(mdb_node))
}

#[inline]
pub fn mdb_node_get_mdbNext(_mdb_node: Rc<RefCell<mdb_node_t>>) -> usize {
    let mdb_node = _mdb_node.borrow();
    let mut ret: usize;
    ret = (mdb_node.words[1] & 0x7ffffffffcusize) << 0;
    /* Possibly sign extend */
    if core::intrinsics::likely(!!(true && (ret & (1usize << 38) != 0))) {
        ret |= 0xffffff8000000000;
    }
    ret
}

#[inline]
pub fn mdb_node_ptr_set_mdbNext(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: usize) {
    let mut mdb_node = _mdb_node.borrow_mut();

    assert!(
        (((!0x7ffffffffcusize << 0) | 0xffffff8000000000) & v64)
            == if true && (v64 & (1usize << (38))) != 0 {
                0xffffff8000000000
            } else {
                0
            }
    );
    mdb_node.words[1] = !0x7ffffffffcusize;
    mdb_node.words[1] |= (v64 >> 0) & 0x7ffffffffc;
}

#[inline]
pub fn mdb_node_get_mdbRevocable(_mdb_node: Rc<RefCell<mdb_node_t>>) -> usize {
    let mdb_node = _mdb_node.borrow();
    let mut ret: usize;
    ret = (mdb_node.words[1] & 0x2usize) >> 1;
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbRevocable(
    _mdb_node: Rc<RefCell<mdb_node_t>>,
    v64: usize,
) -> Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t {
        words: _mdb_node.borrow().words.clone(),
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
    return Rc::new(RefCell::new(mdb_node));
}

#[inline]
pub fn mdb_node_get_mdbFirstBadged(_mdb_node: Rc<RefCell<mdb_node_t>>) -> usize {
    let mdb_node = _mdb_node.borrow();
    let mut ret: usize;
    ret = (mdb_node.words[1] & 0x1usize) >> 0;
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbFirstBadged(
    _mdb_node: Rc<RefCell<mdb_node_t>>,
    v64: usize,
) -> Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t {
        words: _mdb_node.borrow().words.clone(),
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
    return Rc::new(RefCell::new(mdb_node));
}

#[inline]
pub fn mdb_node_get_mdbPrev(_mdb_node: Rc<RefCell<mdb_node_t>>) -> usize {
    let mdb_node = _mdb_node.borrow();
    let mut ret: usize;
    ret = (mdb_node.words[0] & 0xffffffffffffffffusize) >> 0;
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn mdb_node_set_mdbPrev(
    _mdb_node: Rc<RefCell<mdb_node_t>>,
    v64: usize,
) -> Rc<RefCell<mdb_node_t>> {
    let mut mdb_node = mdb_node_t {
        words: _mdb_node.borrow().words.clone(),
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
    return Rc::new(RefCell::new(mdb_node));
}

#[inline]
pub fn mdb_node_ptr_set_mdbPrev(_mdb_node: Rc<RefCell<mdb_node_t>>, v64: usize) {
    let mut mdb_node = _mdb_node.borrow_mut();
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
}

//cap relevant

#[inline]
pub fn cap_get_max_free_index(_cap: Rc<RefCell<cap_t>>) -> usize {
    let ans = cap_untyped_cap_get_capBlockSize(_cap.clone());
    let sel4_MinUntypedbits: usize = 4;
    (1usize << ans) - sel4_MinUntypedbits
}

#[inline]
pub fn cap_get_capType(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    (cap.words[0] >> 59) & 0x1fusize
}

#[inline]
pub fn cap_capType_equals(_cap: Rc<RefCell<cap_t>>, cap_type_tag: usize) -> i32 {
    let cap = _cap.borrow();
    (((cap.words[0] >> 59) & 0x1fusize) == cap_type_tag) as i32
}

#[inline]
pub fn cap_null_cap_new() -> Rc<RefCell<cap_t>> {
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

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_untyped_cap_new(
    capFreeIndex: usize,
    capIsDevice: usize,
    capBlockSize: usize,
    capPtr: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

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

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_untyped_cap_get_capIsDevice(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
    ret = (cap.words[1] & 0x40usize) >> 6;
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_untyped_cap_get_capBlockSize(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);
    ret = (cap.words[1] & 0x3fusize) >> 0;
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}
#[inline]
pub fn cap_untyped_cap_get_capFreeIndex(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);

    ret = (cap.words[1] & 0xfffffffffe000000usize) >> 25;
    if unlikely(!!(false && (ret & (1usize << (38)) != 0))) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_untyped_cap_set_capFreeIndex(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    // let mut cap=Rc::new(RefCell::)
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_untyped_cap_ptr_set_capFreeIndex(_cap: Rc<RefCell<cap_t>>, v64: usize) {
    let mut cap = _cap.borrow_mut();
    // let mut cap=Rc::new(RefCell::)
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

#[inline]
pub fn cap_untyped_cap_get_capPtr(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_untyped_cap as usize);

    ret = (cap.words[0] & 0x7fffffffffusize) << 0;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1usize << (38))) != 0)) {
        ret |= 0xffffff8000000000;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_new(
    capEPBadge: usize,
    capCanGrantReply: usize,
    capCanGrant: usize,
    capCanSend: usize,
    capCanReceive: usize,
    capEPPtr: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

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

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_endpoint_cap_get_capEPBadge(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capEPBadge(_cap: Rc<RefCell<cap_t>>, v64: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrantReply(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[0] & 0x400000000000000usize) >> 58;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanGrantReply(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanGrant(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[0] & 0x200000000000000usize) >> 57;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}
#[inline]
pub fn cap_endpoint_cap_set_capCanGrant(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanReceive(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret: usize;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[0] & 0x100000000000000usize) >> 56;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanReceive(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capCanSend(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret: usize;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[0] & 0x80000000000000usize) >> 55;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_endpoint_cap_set_capCanSend(_cap: Rc<RefCell<cap_t>>, v64: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_endpoint_cap_get_capEPPtr(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_endpoint_cap as usize);

    ret = (cap.words[0] & 0x7fffffffffusize) << 0;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1usize << (38))) != 0)) {
        ret |= 0xffffff8000000000;
    }
    return ret;
}

//FIXME::notification relevant cap not implemented

//FIXME::reply relevant cap not implemented

#[inline]
pub fn cap_cnode_cap_new(
    capCNodeRadix: usize,
    capCNodeGuardSize: usize,
    capCNodeGuard: usize,
    capCNodePtr: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    /* fail if user has passed bits that we will override */
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

    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuard(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret: usize;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

    ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuard(_cap: Rc<RefCell<cap_t>>, v64: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeGuardSize(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret: usize;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

    ret = (cap.words[0] & 0x7e0000000000000usize) >> 53;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_set_capCNodeGuardSize(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_cnode_cap_get_capCNodeRadix(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let mut ret;
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

    ret = (cap.words[0] & 0x1f800000000000usize) >> 47;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn cap_cnode_cap_get_capCNodePtr(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret: usize;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_cnode_cap as usize);

    ret = (cap.words[0] & 0x3fffffffffusize) << 1;
    /* Possibly sign extend */
    if likely(!!(true && (ret & (1usize << (38))) != 0)) {
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
pub fn cap_zombie_cap_new(capZombieID: usize, capZombieType: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

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

    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_zombie_cap_get_capZombieID(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as usize);

    ret = (cap.words[1] & 0xffffffffffffffffusize) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    ret
}

#[inline]
pub fn cap_zombie_cap_set_capZombieID(_cap: Rc<RefCell<cap_t>>, v64: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
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
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_zombie_cap_get_capZombieType(_cap: Rc<RefCell<cap_t>>) -> usize {
    let mut ret;
    let cap = _cap.borrow();
    assert!(((cap.words[0] >> 59) & 0x1f) == cap_tag_t::cap_zombie_cap as usize);

    ret = (cap.words[0] & 0x7fusize) >> 0;
    /* Possibly sign extend */
    if unlikely(!!(false && (ret & (1usize << (38))) != 0)) {
        ret |= 0x0;
    }
    return ret;
}

#[inline]
pub fn Zombie_new(number: usize, _type: usize, ptr: usize) -> Rc<RefCell<cap_t>> {
    let mask: usize;
    if _type == ZombieType_ZombieTCB {
        mask = MASK!(TCB_CNODE_RADIX + 1);
    } else {
        mask = MASK!(_type + 1);
    }
    return cap_zombie_cap_new((ptr & !mask) | (number & mask), _type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieBits(_cap: Rc<RefCell<cap_t>>) -> usize {
    let _type = cap_zombie_cap_get_capZombieType(_cap.clone());
    if _type == ZombieType_ZombieTCB {
        return TCB_CNODE_RADIX;
    }
    return ZombieType_ZombieCNode(_type);
}

#[inline]
pub fn cap_zombie_cap_get_capZombieNumber(_cap: Rc<RefCell<cap_t>>) -> usize {
    let radix = cap_zombie_cap_get_capZombieBits(_cap.clone());
    return cap_zombie_cap_get_capZombieID(_cap.clone()) & MASK!(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_get_capZombiePtr(cap: Rc<RefCell<cap_t>>) -> usize {
    let radix = cap_zombie_cap_get_capZombieBits(cap.clone());
    return cap_zombie_cap_get_capZombieID(cap.clone()) & !MASK!(radix + 1);
}
#[inline]
pub fn cap_zombie_cap_set_capZombieNumber(
    _cap: Rc<RefCell<cap_t>>,
    n: usize,
) -> Rc<RefCell<cap_t>> {
    let cap = Rc::new(RefCell::new(cap_t {
        words: _cap.borrow().words.clone(),
    }));
    let radix = cap_zombie_cap_get_capZombieBits(cap.clone());
    let ptr = cap_zombie_cap_get_capZombieID(cap.clone()) & !MASK!(radix + 1);
    cap_zombie_cap_set_capZombieID(cap.clone(), ptr | (n & MASK!(radix + 1)))
}

#[inline]
pub fn cap_page_table_cap_new(
    capPTMappedASID: usize,
    capPTBasePtr: usize,
    capPTIsMapped: usize,
    capPTMappedAddress: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();

    cap.words[0] = 0
        | (cap_page_table_cap as usize & 0x1fusize) << 59
        | (capPTIsMapped & 0x1usize) << 39
        | (capPTMappedAddress & 0x7fffffffffusize) >> 0;
    cap.words[1] =
        0 | (capPTMappedASID & 0xffffusize) << 48 | (capPTBasePtr & 0x7fffffffffusize) << 9;

    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_page_table_cap_get_capPTMappedASID(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[1] & 0xffff000000000000usize) >> 48;
    ret
}

#[inline]
pub fn cap_page_table_cap_set_capPTMappedASID(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    cap.words[1] &= !0xffff000000000000usize;
    cap.words[1] |= (v64 << 48) & 0xffff000000000000usize;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_page_table_cap_get_capPTBasePtr(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[1] & 0xfffffffffe00usize) >> 9;
    ret
}

#[inline]
pub fn cap_page_table_cap_get_capPTIsMapped(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x8000000000usize) >> 39;
    ret
}

#[inline]
pub fn cap_page_table_cap_set_capPTIsMapped(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    cap.words[0] &= !0x8000000000usize;
    cap.words[0] |= (v64 << 39) & 0x8000000000usize;
    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_page_table_cap_ptr_set_capPTIsMapped(_cap: Rc<RefCell<cap_t>>, v64: usize) {
    let mut cap = _cap.borrow_mut();
    cap.words[0] &= !0x8000000000usize;
    cap.words[0] |= (v64 << 39) & 0x8000000000usize;
}
#[inline]
pub fn cap_page_table_cap_get_capPTMappedAddress(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x7fffffffffusize) << 0;
    ret
}

#[inline]
pub fn cap_page_table_cap_set_capPTMappedAddress(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    cap.words[0] &= !0x7fffffffffusize;
    cap.words[0] |= (v64 >> 0) & 0x7fffffffffusize;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_frame_cap_new(
    capFMappedASID: usize,
    capFBasePtr: usize,
    capFSize: usize,
    capFVMRights: usize,
    capFIsDevice: usize,
    capFMappedAddress: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t::default();
    cap.words[0] = 0
        | (cap_frame_cap & 0x1fusize) << 59
        | (capFSize & 0x3usize) << 57
        | (capFVMRights & 0x3usize) << 55
        | (capFIsDevice & 0x1usize) << 54
        | (capFMappedAddress & 0x7fffffffffusize) >> 0;
    cap.words[1] =
        0 | (capFMappedASID & 0xffffusize) << 48 | (capFBasePtr & 0x7fffffffffusize) << 9;

    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_frame_cap_get_capFMappedASID(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[1] & 0xffff000000000000usize) >> 48;
    ret
}

#[inline]
pub fn cap_frame_cap_set_capFMappedASID(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    cap.words[1] &= !0xffff000000000000usize;
    cap.words[1] |= (v64 << 48) & 0xffff000000000000usize;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_frame_cap_get_capFBasePtr(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[1] & 0xfffffffffe00usize) >> 9;
    ret
}

#[inline]
pub fn cap_frame_cap_get_capFSize(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x600000000000000usize) >> 57;
    ret
}

#[inline]
pub fn cap_frame_cap_get_capFVMRights(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x180000000000000usize) >> 55;
    ret
}

#[inline]
pub fn cap_frame_cap_set_capFVMRights(_cap: Rc<RefCell<cap_t>>, v64: usize) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    cap.words[0] &= !0x180000000000000usize;
    cap.words[0] |= (v64 << 55) & 0x180000000000000usize;
    return Rc::new(RefCell::new(cap));
}

#[inline]
pub fn cap_frame_cap_get_capFISDevice(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x40000000000000usize) >> 54;
    ret
}

#[inline]
pub fn cap_frame_cap_get_capFMappedAddress(_cap: Rc<RefCell<cap_t>>) -> usize {
    let cap = _cap.borrow();
    let ret = (cap.words[0] & 0x7fffffffffusize) >> 54;
    ret
}
pub fn cap_frame_cap_set_capFMappedAddress(
    _cap: Rc<RefCell<cap_t>>,
    v64: usize,
) -> Rc<RefCell<cap_t>> {
    let mut cap = cap_t {
        words: _cap.borrow().words.clone(),
    };
    let ret = (cap.words[0] & 0x7fffffffffusize) >> 54;
    cap.words[0] &= !0x7fffffffffusize;
    cap.words[0] |= (v64 >> 0) & 0x7fffffffffusize;
    return Rc::new(RefCell::new(cap));
}


#[inline]
pub fn pte_ptr_get_ppn(pte_ptr:*const usize)->usize{
    unsafe{
        let ret=((*pte_ptr) & 0x3ffffffffffc00usize) >> 10;
        ret
    }
}
#[inline]
pub fn pte_ptr_get_execute(pte_ptr:*const usize)->usize{
    unsafe{
        let ret=((*pte_ptr) & 0x8usize) >> 3;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_write(pte_ptr:*const usize)->usize{
    unsafe{
        let ret=((*pte_ptr) & 0x4usize) >> 2;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_read(pte_ptr:*const usize)->usize{
    unsafe{
        let ret=((*pte_ptr) & 0x2usize) >> 1;
        ret
    }
}

#[inline]
pub fn pte_ptr_get_valid(pte_ptr:*const usize)->usize{
    unsafe{
        let  ret=((*pte_ptr) & 0x1usize) >> 0;
        ret
    }
}


#[inline]
pub fn cap_asid_cap_new(capASIDBase:usize,capASIDPool:usize)->Rc<RefCell<cap_t>>{
    let mut cap=cap_t::default();
    cap.words[0] = 0
        | (cap_asid_pool_cap & 0x1fusize) << 59
        | (capASIDBase & 0xffffusize) << 43
        | (capASIDPool & 0x7ffffffffcusize) >> 2;
    cap.words[1] = 0;
    Rc::new(RefCell::new(cap))
}

#[inline]
pub fn cap_asid_pool_cap_get_capASIDBase(cap:Rc<RefCell<cap_t>>)->usize{
    let ret = (cap.borrow().words[0].clone() & 0x7fff80000000000usize) >> 43;
    ret
}

#[inline]
pub fn cap_asid_pool_cap_get_capASIDPool(cap:Rc<RefCell<cap_t>>)->usize{
    let ret = (cap.borrow().words[0].clone() & 0x1fffffffffusize)<<2;
    ret
}