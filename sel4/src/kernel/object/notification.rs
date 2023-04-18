use crate::{
    config::badgeRegister,
    kernel::thread::{
        doNBRecvFailedTransfer, possibleSwitchTo, scheduleTCB, setRegister, setThreadState,
        tcbEPAppend, tcbEPDequeue, tcbSchedEnqueue, tcb_queue_t, tcb_t,
        ThreadStateBlockedOnNotification, ThreadStateBlockedOnReceive, ThreadStateInactive,
        ThreadStateRestart, ThreadStateRunning, rescheduleRequired,
    },
};

use super::{
    endpoint::cancelIPC,
    structures::{
        cap_notification_cap_get_capNtfnBadge, cap_t, notification_ptr_get_ntfnBoundTCB,
        notification_ptr_get_ntfnMsgIdentifier, notification_ptr_get_ntfnQueue_head,
        notification_ptr_get_ntfnQueue_tail, notification_ptr_get_state,
        notification_ptr_set_ntfnBoundTCB, notification_ptr_set_ntfnMsgIdentifier,
        notification_ptr_set_ntfnQueue_head, notification_ptr_set_ntfnQueue_tail,
        notification_ptr_set_state, notification_t, thread_state_get_tsType,
        thread_state_set_blockingObject, thread_state_set_tsType, thread_state_t, exception_t,
    },
};

pub const NtfnState_Idle: usize = 0;
pub const NtfnState_Waiting: usize = 1;
pub const NtfnState_Active: usize = 2;

#[inline]
pub fn ntfn_ptr_get_queue(ptr: *const notification_t) -> tcb_queue_t {
    tcb_queue_t {
        head: notification_ptr_get_ntfnQueue_head(ptr),
        tail: notification_ptr_get_ntfnQueue_tail(ptr),
    }
}

#[inline]
pub fn ntfn_ptr_set_queue(ptr: *const notification_t, ntfn_queue: &tcb_queue_t) {
    notification_ptr_set_ntfnQueue_head(ptr as *mut notification_t, ntfn_queue.head);
    notification_ptr_set_ntfnQueue_tail(ptr as *mut notification_t, ntfn_queue.tail);
}

#[inline]
pub fn ntfn_ptr_set_active(ntfnPtr: *const notification_t, badge: usize) {
    notification_ptr_set_state(ntfnPtr as *mut notification_t, NtfnState_Active);
    notification_ptr_set_ntfnMsgIdentifier(ntfnPtr as *mut notification_t, badge);
}

pub fn sendSignal(ntfnPtr: *const notification_t, badge: usize) {
    match notification_ptr_get_state(ntfnPtr) {
        NtfnState_Idle => unsafe {
            let tcb = notification_ptr_get_ntfnBoundTCB(ntfnPtr) as *mut tcb_t;
            if tcb as usize != 0 {
                if thread_state_get_tsType((*tcb).tcbState) == ThreadStateBlockedOnReceive {
                    cancelIPC(tcb);
                    setThreadState(tcb, ThreadStateRunning);
                    setRegister(tcb, badgeRegister, badge);
                    possibleSwitchTo(tcb)
                } else {
                    ntfn_ptr_set_active(ntfnPtr, badge);
                }
            } else {
                ntfn_ptr_set_active(ntfnPtr, badge);
            }
        },
        NtfnState_Waiting => {
            let mut queue = ntfn_ptr_get_queue(ntfnPtr);
            let dest = queue.head as *mut tcb_t;
            assert!(dest as usize != 0);
            queue = tcbEPDequeue(dest, queue);
            ntfn_ptr_set_queue(ntfnPtr, &queue);
            if queue.head != 0 {
                notification_ptr_set_state(ntfnPtr as *mut notification_t, NtfnState_Idle);
            }
            setThreadState(dest, ThreadStateRunning);
            setRegister(dest, badgeRegister, badge);
            possibleSwitchTo(dest);
        }
        NtfnState_Active => {
            let mut badge2 = notification_ptr_get_ntfnMsgIdentifier(ntfnPtr);
            badge2 |= badge;
            notification_ptr_set_ntfnMsgIdentifier(ntfnPtr as *mut notification_t, badge2);
        }
        _ => panic!(
            "invalid notification state :{}",
            notification_ptr_get_state(ntfnPtr)
        ),
    }
}

pub fn receiveSignal(thread: *mut tcb_t, cap: *const cap_t, isBlocking: bool) {
    let ntfnPtr = cap_notification_cap_get_capNtfnBadge(cap) as *mut notification_t;
    match notification_ptr_get_state(ntfnPtr) {
        NtfnState_Idle | NtfnState_Waiting => unsafe {
            if isBlocking {
                thread_state_set_tsType(
                    (*thread).tcbState as *mut thread_state_t,
                    ThreadStateBlockedOnNotification,
                );
                thread_state_set_blockingObject(
                    (*thread).tcbState as *mut thread_state_t,
                    ntfnPtr as usize,
                );
                scheduleTCB(thread);
                let mut queue = ntfn_ptr_get_queue(ntfnPtr);
                queue = tcbEPAppend(thread, queue);
                notification_ptr_set_state(ntfnPtr, NtfnState_Waiting);
                ntfn_ptr_set_queue(ntfnPtr, &queue);
            } else {
                doNBRecvFailedTransfer(thread);
            }
        },
        NtfnState_Active => {
            setRegister(
                thread,
                badgeRegister,
                notification_ptr_get_ntfnMsgIdentifier(ntfnPtr),
            );
            notification_ptr_set_state(ntfnPtr, NtfnState_Idle);
        }
        _ => panic!(
            "Invalid Notification state:{}",
            notification_ptr_get_state(ntfnPtr)
        ),
    }
}

pub fn bindNotification(tcb: *mut tcb_t, ptr: *mut notification_t) {
    notification_ptr_set_ntfnBoundTCB(ptr, tcb as usize);
    unsafe {
        (*tcb).tcbBoundNotification = ptr as usize;
    }
}

pub fn doUnbindNotification(tcb: *mut tcb_t, ptr: *mut notification_t) {
    notification_ptr_set_ntfnBoundTCB(ptr, 0);
    unsafe {
        (*tcb).tcbBoundNotification = 0 as usize;
    }
}

pub fn unbindMaybeNotification(ptr: *const notification_t) {
    let tcb = notification_ptr_get_ntfnBoundTCB(ptr) as *mut tcb_t;
    if tcb as usize != 0 {
        doUnbindNotification(tcb, ptr as *mut notification_t);
    }
}

pub fn unbindNotification(tcb: *mut tcb_t) {
    unsafe {
        let ptr = (*tcb).tcbBoundNotification as *mut notification_t;
        if ptr as usize != 0 {
            doUnbindNotification(tcb, ptr);
        }
    }
}

pub fn completeSignal(ptr: *mut notification_t, tcb: *mut tcb_t) {
    if tcb as usize != 0 && notification_ptr_get_state(ptr) == NtfnState_Active {
        let badge = notification_ptr_get_ntfnMsgIdentifier(ptr);
        setRegister(tcb, badgeRegister, badge);
        notification_ptr_set_state(ptr, NtfnState_Idle);
    } else {
        panic!("tried to complete signal with inactive notification object");
    }
}

pub fn cancelSignal(threadPtr: *mut tcb_t, ntfnPtr: *mut notification_t) {
    assert!(notification_ptr_get_state(ntfnPtr) == NtfnState_Waiting);
    let mut queue = ntfn_ptr_get_queue(ntfnPtr);
    queue = tcbEPDequeue(threadPtr, queue);
    ntfn_ptr_set_queue(ntfnPtr, &queue);
    if queue.head != 0 {
        notification_ptr_set_state(ntfnPtr, NtfnState_Idle);
    }
    setThreadState(threadPtr, ThreadStateInactive);
}

pub fn cancelAllSignals(ntfnPtr: *mut notification_t) {
    if notification_ptr_get_state(ntfnPtr) == NtfnState_Waiting {
        let mut thread = notification_ptr_get_ntfnQueue_head(ntfnPtr) as *mut tcb_t;
        notification_ptr_set_state(ntfnPtr, NtfnState_Idle);
        notification_ptr_set_ntfnQueue_head(ntfnPtr, 0);
        notification_ptr_set_ntfnQueue_tail(ntfnPtr, 0);

        while thread as usize != 0 {
            setThreadState(thread, ThreadStateRestart);
            tcbSchedEnqueue(thread);
            unsafe {
                thread = (*thread).tcbEPNext as *mut tcb_t;
            }
        }
        rescheduleRequired();
    }
}

pub fn performInvocation_Notification(ntfn :*const notification_t,badge:usize)->exception_t{
    sendSignal(ntfn, badge);
    exception_t::EXCEPTION_NONE
}