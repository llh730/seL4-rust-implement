extern crate alloc;
use core::mem::size_of;

use crate::kernel::object::{objecttype::*, structures::*};

use super::endpoint::cancelBadgedSends;

fn setUntypedCapAsFull(_srcCap: *const cap_t, _newCap: *const cap_t, _srcSlot: *const cte_t) {
    unsafe {
        if cap_get_capType(_srcCap) == cap_tag_t::cap_untyped_cap as usize
            && cap_get_capType(_newCap) == cap_tag_t::cap_untyped_cap as usize
        {
            if cap_untyped_cap_get_capPtr(_srcCap) == cap_untyped_cap_get_capPtr(_newCap)
                && cap_untyped_cap_get_capBlockSize(_srcCap)
                    == cap_untyped_cap_get_capBlockSize(_newCap)
            {
                cap_untyped_cap_ptr_set_capFreeIndex(
                    (*_srcSlot).cap,
                    cap_get_max_free_index(_srcCap),
                )
            }
        }
    }
}

pub fn cteInsert(newCap: *const cap_t, _srcSlot: *const cte_t, _destSlot: *const cte_t) {
    unsafe {
        let srcSlot = _srcSlot as *mut cte_t;
        let srcMDB = (*srcSlot).cteMDBNode;
        let srcCap = (*srcSlot).cap;
        let newCapIsRevocable: bool = isCapRevocable(newCap, srcCap);
        let mut newMDB = mdb_node_set_mdbPrev(srcMDB, _srcSlot as usize);
        newMDB = mdb_node_set_mdbRevocable(newMDB, newCapIsRevocable as usize);
        newMDB = mdb_node_set_mdbFirstBadged(newMDB, newCapIsRevocable as usize);
        setUntypedCapAsFull(srcCap, newCap, _srcSlot);
        (*(_destSlot as *mut cte_t)).cap = newCap as *mut cap_t;
        (*(_destSlot as *mut cte_t)).cteMDBNode = newMDB as *mut mdb_node_t;
        mdb_node_ptr_set_mdbNext((*srcSlot).cteMDBNode, _destSlot as usize);
        if mdb_node_get_mdbNext(newMDB) != 0 {
            let cte_ptr = mdb_node_get_mdbNext(newMDB) as *const cte_t;
            mdb_node_ptr_set_mdbPrev(
                (*cte_ptr).cteMDBNode as *const mdb_node_t,
                _destSlot as usize,
            );
        }
    }
}

pub fn cteMove(_newCap: *const cap_t, __srcSlot: *const cte_t, __destSlot: *const cte_t) {
    unsafe {
        let _destSlot = __destSlot as *mut cte_t;
        let _srcSlot = __srcSlot as *mut cte_t;
        let mdb = (*_srcSlot).cteMDBNode;
        /* Haskell error: "cteInsert to non-empty destination" */
        assert!(cap_get_capType((*_destSlot).cap) == cap_tag_t::cap_null_cap as usize);
        /* Haskell error: "cteInsert: mdb entry must be empty" */
        assert!(
            mdb_node_get_mdbNext((*_destSlot).cteMDBNode as *const mdb_node_t) as usize == 0
                && mdb_node_get_mdbPrev((*_destSlot).cteMDBNode as *const mdb_node_t) as usize == 0
        );
        (*_destSlot).cap = _newCap as *mut cap_t;
        (*_srcSlot).cap = cap_null_cap_new() as *mut cap_t;
        (*_destSlot).cteMDBNode = mdb;
        (*_srcSlot).cteMDBNode = mdb_node_new(0, 0, 0, 0) as *mut mdb_node_t;
        let prev_ptr = mdb_node_get_mdbPrev(mdb);
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext((*(prev_ptr as *const cte_t)).cteMDBNode, _destSlot as usize);
        }
        let next_ptr = mdb_node_get_mdbNext(mdb);
        if next_ptr != 0 {
            mdb_node_ptr_set_mdbPrev((*(next_ptr as *const cte_t)).cteMDBNode, _destSlot as usize);
        }
    }
}

pub fn capSwapForDelete(slot1: *const cte_t, slot2: *const cte_t) {
    unsafe {
        if *slot1 == *slot2 {
            return;
        }
        let cap1 = cap_t {
            words: (*(*slot1).cap).words,
        };
        let cap2 = cap_t {
            words: (*(*slot2).cap).words,
        };
        cteSwap(
            (&cap1) as *const cap_t,
            slot1,
            (&cap2) as *const cap_t,
            slot2,
        );
    }
}

pub fn cteSwap(cap1: *const cap_t, _slot1: *const cte_t, cap2: *const cap_t, _slot2: *const cte_t) {
    unsafe {
        let mut slot1 = _slot1 as *mut cte_t;
        let mut slot2 = _slot2 as *mut cte_t;
        let mdb1 = (*slot1).cteMDBNode;
        let mdb2 = (*slot2).cteMDBNode;
        *((*slot1).cap) = *cap2;
        *((*slot2).cap) = *cap1;
        let prev_ptr = mdb_node_get_mdbPrev(mdb1);
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext((*(prev_ptr as *const cte_t)).cteMDBNode, _slot2 as usize);
        }
        let next_ptr = mdb_node_get_mdbNext(mdb1);
        if next_ptr != 0 {
            mdb_node_ptr_set_mdbPrev((*(next_ptr as *const cte_t)).cteMDBNode, _slot2 as usize);
        }
        (*slot1).cteMDBNode = mdb2;
        (*slot2).cteMDBNode = mdb1;
        let prev_ptr = mdb_node_get_mdbPrev(mdb2);
        if prev_ptr != 0 {
            mdb_node_ptr_set_mdbNext((*(prev_ptr as *const cte_t)).cteMDBNode, _slot1 as usize);
        }
        let next_ptr = mdb_node_get_mdbNext(mdb2);
        if next_ptr != 0 {
            mdb_node_ptr_set_mdbPrev((*(next_ptr as *const cte_t)).cteMDBNode, _slot1 as usize);
        }
    }
}

pub fn cteDelete(slot: *const cte_t, exposed: bool) -> exception_t {
    let fs_ret = finaliseSlot(slot, exposed);
    if fs_ret.status != exception_t::EXCEPTION_NONE {
        return fs_ret.status;
    }

    if exposed || fs_ret.success {
        emptySlot(slot, fs_ret.cleanupInfo);
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn cteRevoke(slot: *const cte_t) -> exception_t {
    unsafe {
        let mut next = mdb_node_get_mdbNext((*slot).cteMDBNode);
        if next != 0 {
            let mut nextPtr = mdb_node_get_mdbNext((*slot).cteMDBNode) as *const cte_t;
            while next != 0 && isMDBParentOf(slot, nextPtr) {
                let status = cteDelete(nextPtr, true);
                if status != exception_t::EXCEPTION_NONE {
                    return status;
                }
                next = mdb_node_get_mdbNext((*slot).cteMDBNode);
                if next == 0 {
                    break;
                }
                nextPtr = mdb_node_get_mdbNext((*slot).cteMDBNode) as *const cte_t;
            }
        }
    }
    return exception_t::EXCEPTION_NONE;
}

fn isMDBParentOf(cte1: *const cte_t, cte2: *const cte_t) -> bool {
    unsafe {
        if !(mdb_node_get_mdbRevocable((*cte1).cteMDBNode) != 0) {
            return false;
        }
        if !sameRegionAs((*cte1).cap, (*cte2).cap) {
            return false;
        }
        match cap_get_capType((*cte1).cap) {
            cap_endpoint_cap => {
                let badge: usize;
                badge = cap_endpoint_cap_get_capEPBadge((*cte1).cap);
                if badge == 0 {
                    return true;
                }
                return badge == cap_endpoint_cap_get_capEPBadge((*cte2).cap)
                    && !(mdb_node_get_mdbFirstBadged((*cte2).cteMDBNode) != 0);
            }
            _ => return true,
        }
    }
}

pub fn ensureNoChildren(slot: *const cte_t) -> exception_t {
    unsafe {
        if mdb_node_get_mdbNext((*slot).cteMDBNode) != 0 {
            let next = mdb_node_get_mdbNext((*slot).cteMDBNode) as *const cte_t;
            if isMDBParentOf(slot, next) {
                return exception_t::EXCEPTION_SYSCALL_ERROR;
            }
        }
        return exception_t::EXCEPTION_NONE;
    }
}

pub fn emptySlot(_slot: *const cte_t, _cleanupInfo: *const cap_t) {
    unsafe {
        let slot = _slot as *mut cte_t;
        if cap_get_capType((*slot).cap) != cap_null_cap {
            let mdbNode = (*slot).cteMDBNode;
            let prev = mdb_node_get_mdbPrev(mdbNode);
            let next = mdb_node_get_mdbNext(mdbNode);
            if prev != 0 {
                let prev_ptr = mdb_node_get_mdbPrev(mdbNode) as *const cte_t;
                mdb_node_ptr_set_mdbNext((*(prev_ptr as *const cte_t)).cteMDBNode, next);
            }
            if next != 0 {
                let next_ptr = mdb_node_get_mdbNext(mdbNode) as *const cte_t;
                mdb_node_ptr_set_mdbPrev((*(next_ptr as *const cte_t)).cteMDBNode, prev);
            }
            (*slot).cap = cap_null_cap_new() as *mut cap_t;
            (*slot).cteMDBNode = &(mdb_node_t::default()) as *const mdb_node_t as *mut mdb_node_t;
        }
    }
}

pub fn ensureEmptySlot(slot: *const cte_t) -> exception_t {
    unsafe {
        if cap_get_capType((*slot).cap) != cap_null_cap {
            return exception_t::EXCEPTION_SYSCALL_ERROR;
        }
    }
    exception_t::EXCEPTION_NONE
}

pub fn isFinalcapability(cte: *const cte_t) -> bool {
    unsafe {
        let mdb = (*cte).cteMDBNode;
        let prevIsSameObject: bool;
        if mdb_node_get_mdbPrev(mdb) == 0 {
            prevIsSameObject = false;
        } else {
            let prev = mdb_node_get_mdbPrev(mdb) as *const cte_t;
            prevIsSameObject = sameObjectAs((*prev).cap, (*cte).cap);
        }
        if prevIsSameObject {
            false
        } else {
            if mdb_node_get_mdbNext(mdb) != 0 {
                true
            } else {
                let next = mdb_node_get_mdbPrev(mdb) as *const cte_t;
                return !sameObjectAs((*cte).cap, (*next).cap);
            }
        }
    }
}

#[inline]
fn capRemovable(cap: *const cap_t, slot: *const cte_t) -> bool {
    match cap_get_capType(cap) {
        cap_null_cap => {
            return true;
        }
        cap_zombie_cap => {
            let n = cap_zombie_cap_get_capZombieNumber(cap);
            let ptr = cap_zombie_cap_get_capZombiePtr(cap);
            let z_slot = ptr as *const cte_t;
            return n == 0 || (n == 1 && slot == z_slot);
        }
        _ => {
            panic!("Invalid cap type , finaliseCap should only return Zombie or NullCap");
        }
    }
}

#[inline]
pub fn capCyclicZombie(cap: *const cap_t, slot: *const cte_t) -> bool {
    let ptr = cap_zombie_cap_get_capZombiePtr(cap) as *const cte_t;
    return cap_get_capType(cap) == cap_zombie_cap && ptr == slot;
}

pub fn reduceZombie(slot: *const cte_t, immediate: bool) -> exception_t {
    unsafe {
        assert!(cap_get_capType((*slot).cap) == cap_zombie_cap);
        let status: exception_t;
        let ptr = cap_zombie_cap_get_capZombiePtr((*slot).cap) as *const cte_t;
        let n = cap_zombie_cap_get_capZombieNumber((*slot).cap);
        let _type = cap_zombie_cap_get_capZombieType((*slot).cap);
        assert!(n > 0);
        if immediate {
            //TODO::immediate is not implemented
            //cte_t *endSlot = &ptr[n - 1];
            let endSlot = (cap_zombie_cap_get_capZombiePtr((*slot).cap)
                + (n - 1) * size_of::<*const cte_t>() as usize)
                as *const cte_t;
            status = cteDelete(endSlot, false);
            if status != exception_t::EXCEPTION_NONE {
                return status;
            }
            match cap_get_capType((*slot).cap) {
                cap_null_cap => {
                    return exception_t::EXCEPTION_NONE;
                }
                cap_zombie_cap => {
                    let ptr2 = cap_zombie_cap_get_capZombiePtr((*slot).cap) as *const cte_t;
                    if ptr == ptr2
                        && cap_zombie_cap_get_capZombieNumber((*slot).cap) == n
                        && cap_zombie_cap_get_capZombieType((*slot).cap) == _type
                    {
                        cap_zombie_cap_set_capZombieNumber((*slot).cap, n - 1);
                    }
                }
                _ => {}
            }
        } else {
            assert!(ptr != slot);
            if cap_get_capType((*ptr).cap) != cap_zombie_cap {
                let ptr1 = cap_zombie_cap_get_capZombiePtr((*ptr).cap) as *const cte_t;
                assert!(ptr != ptr1);
            }
            capSwapForDelete(ptr, slot);
        }
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn finaliseSlot(_slot: *const cte_t, immediate: bool) -> finaliseSlot_ret {
    unsafe {
        let slot = _slot as *mut cte_t;
        let mut _final: bool;
        let mut fc_ret: finaliseCap_ret;
        let mut ret = finaliseSlot_ret::default();
        let mut status: exception_t;

        while cap_get_capType((*slot).cap) != cap_null_cap {
            _final = isFinalcapability(slot);
            fc_ret = finaliseCap((*slot).cap, _final, false);
            let flag = capRemovable(fc_ret.remainder, slot);
            if flag {
                ret.status = exception_t::EXCEPTION_NONE;
                ret.success = true;
                ret.cleanupInfo = fc_ret.cleanupInfo;
                return ret;
            }
            (*slot).cap = fc_ret.remainder as *mut cap_t;
            if !immediate && capCyclicZombie((*slot).cap, slot) {
                ret.status = exception_t::EXCEPTION_NONE;
                ret.success = false;
                ret.cleanupInfo = fc_ret.cleanupInfo;
                return ret;
            }
            status = reduceZombie(slot, immediate);
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
}

pub fn cteDeleteOne(slot: *const cte_t) {
    unsafe {
        let cap_type = cap_get_capType((*slot).cap);
        if cap_type != cap_null_cap {
            let _final = isFinalcapability(slot);
            let fc_ret = finaliseCap((*slot).cap, _final, true);
            assert!(
                capRemovable(fc_ret.remainder, slot)
                    && cap_get_capType(fc_ret.cleanupInfo) == cap_null_cap
            );
            emptySlot(slot, cap_null_cap_new());
        }
    }
}
pub fn insertNewCap(parent: *const cte_t, _slot: *const cte_t, cap: *const cap_t) {
    unsafe {
        let next = mdb_node_get_mdbNext((*parent).cteMDBNode);
        let mut slot = _slot as *mut cte_t;
        (*slot).cap = cap as *mut cap_t;
        (*slot).cteMDBNode =
            mdb_node_new(next as usize, 1usize, 1usize, parent as usize) as *mut mdb_node_t;
        if next != 0 {
            let next_ptr = next as *const cte_t;
            mdb_node_ptr_set_mdbPrev((*next_ptr).cteMDBNode, _slot as usize);
        }
        mdb_node_ptr_set_mdbNext((*parent).cteMDBNode, _slot as usize);
    }
}

pub fn invokeCNodeRotate(
    cap1: *const cap_t,
    cap2: *const cap_t,
    slot1: *const cte_t,
    slot2: *const cte_t,
    slot3: *const cte_t,
) -> exception_t {
    if slot1 == slot3 {
        cteSwap(cap1, slot1, cap2, slot2);
    } else {
        cteMove(cap2, slot2, slot3);
        cteMove(cap1, slot1, slot2);
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeMove(
    cap: *const cap_t,
    srcSlot: *const cte_t,
    destSlot: *const cte_t,
) -> exception_t {
    cteMove(cap, srcSlot, destSlot);
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeInsert(
    cap: *const cap_t,
    srcSlot: *const cte_t,
    destSlot: *const cte_t,
) -> exception_t {
    cteInsert(cap, srcSlot, destSlot);
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeCancelBadgedSends(cap: *const cap_t) -> exception_t {
    let badge = cap_endpoint_cap_get_capEPBadge(cap);
    if badge != 0 {
        let ep = cap_endpoint_cap_get_capEPPtr(cap) as *const endpoint_t;
        cancelBadgedSends(ep as *mut endpoint_t, badge);
    }
    return exception_t::EXCEPTION_NONE;
}

pub fn invokeCNodeDelete(destSlot: *const cte_t) -> exception_t {
    cteDelete(destSlot, true)
}

pub fn invokeCNodeRevoke(destSlot: *const cte_t) -> exception_t {
    cteRevoke(destSlot)
}

// pub fn decodeCNodeInvocation(invLabel: usize, length: usize, cap: *const cap_t, buffer: usize) {
//     let mut lu_ret = lookupSlot_ret_t::default();
// }
