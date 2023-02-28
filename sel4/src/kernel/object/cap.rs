use core::cell::RefCell;
extern crate alloc;
use alloc::rc::Rc;
use core::mem::size_of;

use crate::kernel::object::{cspace::*, objecttype::*, structures::*};

fn setUntypedCapAsFull(
    _srcCap: Rc<RefCell<cap_t>>,
    _newCap: Rc<RefCell<cap_t>>,
    _srcSlot: Rc<RefCell<cte_t>>,
) {
    if cap_get_capType(_srcCap.clone()) == cap_tag_t::cap_untyped_cap as u64
        && cap_get_capType(_newCap.clone()) == cap_tag_t::cap_untyped_cap as u64
    {
        if cap_untyped_cap_get_capPtr(_srcCap.clone())
            == cap_untyped_cap_get_capPtr(_newCap.clone())
            && cap_untyped_cap_get_capBlockSize(_srcCap.clone())
                == cap_untyped_cap_get_capBlockSize(_newCap.clone())
        {
            cap_untyped_cap_set_capFreeIndex(
                _srcSlot.borrow().cap.clone(),
                cap_get_max_free_index(_srcCap.clone()),
            )
        }
    }
}

pub fn cteInsert(
    newCap: Rc<RefCell<cap_t>>,
    _srcSlot: Rc<RefCell<cte_t>>,
    _destSlot: Rc<RefCell<cte_t>>,
) {
    let newMDB = Rc::new(RefCell::new(mdb_node_t::default()));

    let srcSlot = _srcSlot.borrow();

    let srcMDB = srcSlot.cteMDBNode.clone();
    let srcCap = srcSlot.cap.clone();
    let newCapIsRevocable: bool = isCapRevocable(newCap.clone(), srcCap.clone());

    mdb_node_set_mdbPrev(srcMDB, Rc::into_raw(_srcSlot.clone()) as u64);
    mdb_node_set_mdbRevocable(newMDB.clone(), newCapIsRevocable as u64);
    mdb_node_set_mdbFirstBadged(newMDB.clone(), newCapIsRevocable as u64);
    /* Haskell error: "cteInsert to non-empty destination" */
    assert!(cap_get_capType(_destSlot.borrow().cap.clone()) == cap_tag_t::cap_null_cap as u64);
    /* Haskell error: "cteInsert: mdb entry must be empty" */
    assert!(
        mdb_node_get_mdbNext(_destSlot.borrow().cteMDBNode.clone()) == 0
            && mdb_node_get_mdbPrev(_destSlot.borrow().cteMDBNode.clone()) == 0
    );
    setUntypedCapAsFull(srcCap.clone(), newCap.clone(), _srcSlot.clone());
    _destSlot.borrow_mut().cap = newCap.clone();
    _destSlot.borrow_mut().cteMDBNode = newMDB.clone();
    mdb_node_ptr_set_mdbNext(
        srcSlot.cteMDBNode.clone(),
        Rc::into_raw(_destSlot.clone()) as u64,
    );
    if mdb_node_get_mdbNext(newMDB.clone()) != 0 {
        unsafe {
            let cte_ptr =
                Rc::from_raw(mdb_node_get_mdbNext(newMDB.clone()) as *const RefCell<cte_t>);
            mdb_node_ptr_set_mdbNext(
                cte_ptr.borrow().cteMDBNode.clone(),
                Rc::into_raw(_destSlot) as u64,
            );
        }
    }
}

pub fn cteMove(
    _newCap: Rc<RefCell<cap_t>>,
    _srcSlot: Rc<RefCell<cte_t>>,
    _destSlot: Rc<RefCell<cte_t>>,
) {
    let mdb = _srcSlot.borrow().cteMDBNode.clone();
    /* Haskell error: "cteInsert to non-empty destination" */
    assert!(cap_get_capType(_destSlot.borrow().cap.clone()) == cap_tag_t::cap_null_cap as u64);
    /* Haskell error: "cteInsert: mdb entry must be empty" */
    assert!(
        mdb_node_get_mdbNext(_destSlot.borrow().cteMDBNode.clone()) == 0
            && mdb_node_get_mdbPrev(_destSlot.borrow().cteMDBNode.clone()) == 0
    );
    _destSlot.borrow_mut().cap = _newCap.clone();
    _srcSlot.borrow_mut().cap = cap_null_cap_new();
    _destSlot.borrow_mut().cteMDBNode = mdb.clone();
    _srcSlot.borrow_mut().cteMDBNode = mdb_node_new(0, 0, 0, 0);
    unsafe {
        let prev_ptr = mdb_node_get_mdbPrev(mdb.clone());
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext(
                Rc::from_raw(prev_ptr as *const RefCell<cte_t>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_destSlot.clone()) as u64,
            );
        }
        let next_ptr = mdb_node_get_mdbNext(mdb.clone());
        if next_ptr != 0 {
            mdb_node_set_mdbPrev(
                Rc::from_raw(next_ptr as *const Rc<RefCell<cte_t>>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_destSlot.clone()) as u64,
            );
        }
    }
}

pub fn capSwapForDelete(slot1: Rc<RefCell<cte_t>>, slot2: Rc<RefCell<cte_t>>) {
    if Rc::ptr_eq(&slot1, &slot2) {
        return;
    }
    cteSwap(
        slot1.borrow().cap.clone(),
        slot1.clone(),
        slot2.borrow().cap.clone(),
        slot2.clone(),
    );
}

pub fn cteSwap(
    cap1: Rc<RefCell<cap_t>>,
    _slot1: Rc<RefCell<cte_t>>,
    cap2: Rc<RefCell<cap_t>>,
    _slot2: Rc<RefCell<cte_t>>,
) {
    let mut slot1 = _slot1.borrow_mut();
    let mut slot2 = _slot2.borrow_mut();
    let mdb1 = slot1.cteMDBNode.clone();
    let mdb2 = slot2.cteMDBNode.clone();
    slot1.cap = cap2.clone();
    slot2.cap = cap1.clone();
    unsafe {
        let prev_ptr = mdb_node_get_mdbPrev(mdb1.clone());
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext(
                Rc::from_raw(prev_ptr as *const RefCell<cte_t>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_slot2.clone()) as u64,
            );
        }
        let next_ptr = mdb_node_get_mdbNext(mdb1.clone());
        if next_ptr != 0 {
            mdb_node_set_mdbPrev(
                Rc::from_raw(next_ptr as *const RefCell<cte_t>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_slot2.clone()) as u64,
            );
        }
    }
    slot1.cteMDBNode = mdb2.clone();
    slot2.cteMDBNode = mdb1.clone();
    unsafe {
        let prev_ptr = mdb_node_get_mdbPrev(mdb2.clone());
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext(
                Rc::from_raw(prev_ptr as *const RefCell<cte_t>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_slot1.clone()) as u64,
            );
        }
        let next_ptr = mdb_node_get_mdbNext(mdb2.clone());
        if next_ptr != 0 {
            mdb_node_set_mdbPrev(
                Rc::from_raw(next_ptr as *const RefCell<cte_t>)
                    .borrow()
                    .cteMDBNode
                    .clone(),
                Rc::into_raw(_slot1.clone()) as u64,
            );
        }
    }
}

pub fn cteDelete(slot: Rc<RefCell<cte_t>>, exposed: bool) -> exception_t {
    let fs_ret = finaliseSlot(slot.clone(), exposed);
    if fs_ret.status != exception_t::EXCEPTION_NONE {
        return fs_ret.status;
    }

    if exposed || fs_ret.success {
        emptySlot(slot.clone(), fs_ret.cleanupInfo);
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn cteRevoke(slot: Rc<RefCell<cte_t>>) -> exception_t {
    unsafe {
        let mut next = mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone());
        if next != 0 {
            let mut nextPtr = Rc::from_raw(
                mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone()) as *const RefCell<cte_t>
            );
            while next != 0 && isMDBParentOf(slot.clone(), nextPtr.clone()) {
                let status = cteDelete(nextPtr.clone(), true);
                if status != exception_t::EXCEPTION_NONE {
                    return status;
                }
                next = mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone());
                if next == 0 {
                    break;
                }
                nextPtr =
                    Rc::from_raw(mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone())
                        as *const RefCell<cte_t>);
            }
        }
    }
    return exception_t::EXCEPTION_NONE;
}

fn isMDBParentOf(cte1: Rc<RefCell<cte_t>>, cte2: Rc<RefCell<cte_t>>) -> bool {
    if !(mdb_node_get_mdbRevocable(cte1.borrow().cteMDBNode.clone()) != 0) {
        return false;
    }
    if !sameRegionAs(cte1.borrow().cap.clone(), cte2.borrow().cap.clone()) {
        return false;
    }
    match cap_get_capType(cte1.borrow().cap.clone()) {
        cap_endpoint_cap => {
            let badge: u64;
            badge = cap_endpoint_cap_get_capEPBadge(cte1.borrow().cap.clone());
            if badge == 0 {
                return true;
            }
            return badge == cap_endpoint_cap_get_capEPBadge(cte2.borrow().cap.clone())
                && !(mdb_node_get_mdbFirstBadged(cte2.borrow().cteMDBNode.clone()) != 0);
        }
        _ => return true,
    }
}

pub fn ensureNoChilren(slot: Rc<RefCell<cte_t>>) -> exception_t {
    if mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone()) != 0 {
        unsafe {
            let next = Rc::from_raw(
                mdb_node_get_mdbNext(slot.borrow().cteMDBNode.clone()) as *const RefCell<cte_t>
            );
            if isMDBParentOf(slot.clone(), next.clone()) {
                return exception_t::EXCEPTION_SYSCALL_ERROR;
            }
        }
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn emptySlot(slot: Rc<RefCell<cte_t>>, _cleanupInfo: Rc<RefCell<cap_t>>) {
    if cap_get_capType(slot.borrow().cap.clone()) != cap_null_cap {
        unsafe {
            let mdbNode = slot.borrow().cteMDBNode.clone();
            let prev = mdb_node_get_mdbPrev(mdbNode.clone());
            let next = mdb_node_get_mdbNext(mdbNode.clone());
            let prev_ptr =
                Rc::from_raw(mdb_node_get_mdbPrev(mdbNode.clone()) as *const Rc<RefCell<cte_t>>);
            let next_ptr =
                Rc::from_raw(mdb_node_get_mdbNext(mdbNode.clone()) as *const Rc<RefCell<cte_t>>);
            if prev != 0 {
                mdb_node_ptr_set_mdbNext(prev_ptr.borrow().cteMDBNode.clone(), next);
            }
            if next != 0 {
                mdb_node_set_mdbPrev(next_ptr.borrow().cteMDBNode.clone(), prev);
            }
            slot.borrow_mut().cap = cap_null_cap_new();
            slot.borrow_mut().cteMDBNode = Rc::new(RefCell::new(mdb_node_t::default()));
        }
    }
}

pub fn ensureEmptySlot(slot: Rc<RefCell<cte_t>>) -> exception_t {
    if cap_get_capType(slot.borrow().cap.clone()) != cap_null_cap {
        return exception_t::EXCEPTION_SYSCALL_ERROR;
    }
    exception_t::EXCEPTION_NONE
}

pub fn isFinalcapability(cte: Rc<RefCell<cte_t>>) -> bool {
    let mdb = cte.borrow().cteMDBNode.clone();
    let prevIsSameObject: bool;
    if mdb_node_get_mdbPrev(mdb.clone()) == 0 {
        prevIsSameObject = false;
    } else {
        unsafe {
            let prev = Rc::from_raw(mdb_node_get_mdbPrev(mdb.clone()) as *const RefCell<cte_t>);
            prevIsSameObject = sameObjectAs(prev.borrow().cap.clone(), cte.borrow().cap.clone());
        }
    }
    if prevIsSameObject {
        false
    } else {
        if mdb_node_get_mdbNext(mdb.clone()) != 0 {
            true
        } else {
            unsafe {
                let next = Rc::from_raw(mdb_node_get_mdbPrev(mdb.clone()) as *const RefCell<cte_t>);
                return !sameObjectAs(cte.borrow().cap.clone(), next.borrow().cap.clone());
            }
        }
    }
}

#[inline]
fn capRemovable(cap: Rc<RefCell<cap_t>>, slot: Rc<RefCell<cte_t>>) -> bool {
    match cap_get_capType(cap.clone()) {
        cap_null_cap => {
            return true;
        }
        cap_zombie_cap => {
            let n = cap_zombie_cap_get_capZombieNumber(cap.clone());
            let ptr = cap_zombie_cap_get_capZombiePtr(cap.clone());
            unsafe {
                let z_slot = Rc::from_raw(ptr as *const RefCell<cte_t>);
                return n == 0 || (n == 1 && slot == z_slot);
            }
        }
        _ => {
            panic!("Invalid cap type , finaliseCap should only return Zombie or NullCap");
        }
    }
}

#[inline]
pub fn capCyclicZombie(cap: Rc<RefCell<cap_t>>, slot: Rc<RefCell<cte_t>>) -> bool {
    unsafe {
        let ptr =
            Rc::from_raw(cap_zombie_cap_get_capZombiePtr(cap.clone()) as *const RefCell<cte_t>);
        return cap_get_capType(cap.clone()) == cap_zombie_cap && ptr == slot;
    }
}

pub fn reduceZombie(slot: Rc<RefCell<cte_t>>, immediate: bool) -> exception_t {
    unsafe {
        assert!(cap_get_capType(slot.borrow().cap.clone()) == cap_zombie_cap);
        let  status: exception_t;
        let ptr = Rc::from_raw(
            cap_zombie_cap_get_capZombiePtr(slot.borrow().cap.clone()) as *const RefCell<cte_t>
        );
        let n = cap_zombie_cap_get_capZombieNumber(slot.borrow().cap.clone());
        let _type = cap_zombie_cap_get_capZombieType(slot.borrow().cap.clone());
        assert!(n > 0);
        if immediate {
            //TODO::immediate is not implemented
            //cte_t *endSlot = &ptr[n - 1];
            let endSlot = Rc::from_raw(
                (cap_zombie_cap_get_capZombiePtr(slot.borrow().cap.clone())
                    + (n - 1) * size_of::<Rc<RefCell<cte_t>>>() as u64)
                    as *const RefCell<cte_t>,
            );
            status = cteDelete(endSlot.clone(), false);
            if status != exception_t::EXCEPTION_NONE {
                return status;
            }
            match cap_get_capType(slot.borrow().cap.clone()) {
                cap_null_cap => {
                    return exception_t::EXCEPTION_NONE;
                }
                cap_zombie_cap => {
                    let ptr2 =
                        Rc::from_raw(cap_zombie_cap_get_capZombiePtr(slot.borrow().cap.clone())
                            as *const RefCell<cte_t>);
                    if ptr == ptr2
                        && cap_zombie_cap_get_capZombieNumber(slot.borrow().cap.clone()) == n
                        && cap_zombie_cap_get_capZombieType(slot.borrow().cap.clone()) == _type
                    {
                        cap_zombie_cap_set_capZombieNumber(slot.borrow().cap.clone(), n - 1);
                    }
                }
                _ => {}
            }
        } else {
            assert!(ptr != slot);
            if cap_get_capType(ptr.borrow().cap.clone()) != cap_zombie_cap {
                let ptr1 = Rc::from_raw(cap_zombie_cap_get_capZombiePtr(ptr.borrow().cap.clone())
                    as *const RefCell<cte_t>);
                assert!(ptr != ptr1);
            }
            capSwapForDelete(ptr.clone(), slot.clone());
        }
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn finaliseSlot(slot: Rc<RefCell<cte_t>>, immediate: bool) -> finaliseSlot_ret {
    let mut _final: bool;
    let mut fc_ret: finaliseCap_ret;
    let mut ret = finaliseSlot_ret::default();
    let mut status: exception_t;

    while cap_get_capType(slot.borrow().cap.clone()) != cap_null_cap {
        _final = isFinalcapability(slot.clone());
        fc_ret = finaliseCap(slot.borrow().cap.clone(), _final, false);
        if capRemovable(fc_ret.remainder.clone(), slot.clone()) {
            ret.status = exception_t::EXCEPTION_NONE;
            ret.success = true;
            ret.cleanupInfo = fc_ret.cleanupInfo;
            return ret;
        }
        slot.borrow_mut().cap = fc_ret.remainder;
        if !immediate && capCyclicZombie(slot.borrow().cap.clone(), slot.clone()) {
            ret.status = exception_t::EXCEPTION_NONE;
            ret.success = false;
            ret.cleanupInfo = fc_ret.cleanupInfo;
            return ret;
        }
        status = reduceZombie(slot.clone(), immediate);
        if status != exception_t::EXCEPTION_NONE {
            ret.status = status;
            ret.success = false;
            ret.cleanupInfo = cap_null_cap_new();
            return ret;
        }
        //TODO::preemptionPoint();
    }
    ret.status = exception_t::EXCEPTION_NONE;
    ret.success = true;
    ret.cleanupInfo = cap_null_cap_new();
    return ret;
}

pub fn cteDeleteOne(slot: Rc<RefCell<cte_t>>) {
    let cap_type = cap_get_capType(slot.borrow().cap.clone());
    if cap_type != cap_null_cap {
        let _final = isFinalcapability(slot.clone());
        let fc_ret = finaliseCap(slot.borrow().cap.clone(), _final, true);
        assert!(
            capRemovable(fc_ret.remainder.clone(), slot.clone())
                && cap_get_capType(fc_ret.cleanupInfo.clone()) == cap_null_cap
        );
        emptySlot(slot.clone(), cap_null_cap_new());
    }
}
pub fn insertNewCap(
    parent: Rc<RefCell<cte_t>>,
    _slot: Rc<RefCell<cte_t>>,
    cap: Rc<RefCell<cap_t>>,
) {
    unsafe {
        let next = mdb_node_get_mdbNext(parent.borrow().cteMDBNode.clone());
        let mut slot = _slot.borrow_mut();
        slot.cap = cap;
        slot.cteMDBNode =
            mdb_node_new(next as u64, 1u64, 1u64, Rc::into_raw(parent.clone()) as u64);
        if next != 0 {
            let next_ptr = Rc::from_raw(next as *const RefCell<cte_t>);
            mdb_node_set_mdbPrev(
                next_ptr.borrow().cteMDBNode.clone(),
                Rc::into_raw(_slot.clone()) as u64,
            );
        }
        mdb_node_ptr_set_mdbNext(
            parent.borrow().cteMDBNode.clone(),
            Rc::into_raw(_slot.clone()) as u64,
        );
    }
}

pub fn invokeCNodeRotate(
    cap1: Rc<RefCell<cap_t>>,
    cap2: Rc<RefCell<cap_t>>,
    slot1: Rc<RefCell<cte_t>>,
    slot2: Rc<RefCell<cte_t>>,
    slot3: Rc<RefCell<cte_t>>,
) -> exception_t {
    if slot1 == slot3 {
        cteSwap(cap1.clone(), slot1.clone(), cap2.clone(), slot2.clone());
    } else {
        cteMove(cap2.clone(), slot2.clone(), slot3.clone());
        cteMove(cap1.clone(), slot1.clone(), slot2.clone());
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeMove(
    cap: Rc<RefCell<cap_t>>,
    srcSlot: Rc<RefCell<cte_t>>,
    destSlot: Rc<RefCell<cte_t>>,
) -> exception_t {
    cteMove(cap.clone(), srcSlot.clone(), destSlot.clone());
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeInsert(
    cap: Rc<RefCell<cap_t>>,
    srcSlot: Rc<RefCell<cte_t>>,
    destSlot: Rc<RefCell<cte_t>>,
) -> exception_t {
    cteInsert(cap.clone(), srcSlot.clone(), destSlot.clone());
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeCancelBadgedSends(cap: Rc<RefCell<cap_t>>) -> exception_t {
    let badge = cap_endpoint_cap_get_capEPBadge(cap.clone());
    if badge != 0 {
        unsafe {
            let ep = Rc::from_raw(
                cap_endpoint_cap_get_capEPPtr(cap.clone()) as *const RefCell<endpoint_t>
            );
            //TODO::cancelBadgeSend();
        }
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeDelete(destSlot: Rc<RefCell<cte_t>>) -> exception_t {
    cteDelete(destSlot.clone(), true)
}

pub fn invokeCNodeRevoke(destSlot: Rc<RefCell<cte_t>>) -> exception_t {
    cteRevoke(destSlot.clone())
}

// pub fn decodeCNodeInvocation(invLabel: u64, length: u64, cap: Rc<RefCell<cap_t>>, buffer: u64) {
//     let mut lu_ret = lookupSlot_ret_t::default();
// }
