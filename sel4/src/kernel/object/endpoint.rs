use crate::kernel::{
    object::structures::{
        cap_t, thread_state_get_blockingIPCBadge, thread_state_get_blockingIPCCanGrant,
        thread_state_get_blockingIPCCanGrantReply, thread_state_get_blockingIPCIsCall,
    },
    thread::{
        doIPCTransfer, doNBRecvFailedTransfer, ksCurThread, possibleSwitchTo, rescheduleRequired,
        scheduleTCB, setThreadState, setupCallerCap, tcbEPAppend, tcbEPDequeue, tcbSchedEnqueue,
        tcb_queue_t, tcb_t, ThreadStateBlockedOnReceive, ThreadStateBlockedOnSend,
        ThreadStateInactive, ThreadStateRestart, ThreadStateRunning,
    },
};

use super::structures::{
    cap_endpoint_cap_get_capCanGrant, cap_endpoint_cap_get_capEPPtr, endpoint_ptr_get_epQueue_head,
    endpoint_ptr_get_epQueue_tail, endpoint_ptr_get_state, endpoint_ptr_set_epQueue_head,
    endpoint_ptr_set_epQueue_tail, endpoint_ptr_set_state, endpoint_t, exception_t,
    thread_state_get_blockingObject, thread_state_get_tsType, thread_state_set_blockingIPCBadge,
    thread_state_set_blockingIPCCanGrant, thread_state_set_blockingIPCCanGrantReply,
    thread_state_set_blockingIPCIsCall, thread_state_set_blockingObject, thread_state_set_tsType,
    thread_state_t,
};

#[inline]
pub fn ep_ptr_set_queue(epptr: *const endpoint_t, queue: tcb_queue_t) {
    endpoint_ptr_set_epQueue_head(epptr as *mut endpoint_t, queue.head);
    endpoint_ptr_set_epQueue_tail(epptr as *mut endpoint_t, queue.tail);
}

const EPState_Idle: usize = 0;
const EPState_Send: usize = 0;
const EPState_Recv: usize = 0;

#[inline]
pub fn ep_ptr_get_queue(epptr: *const endpoint_t) -> tcb_queue_t {
    let queue = tcb_queue_t {
        head: endpoint_ptr_get_epQueue_head(epptr as *mut endpoint_t),
        tail: endpoint_ptr_get_epQueue_tail(epptr as *mut endpoint_t),
    };

    queue
}

pub fn sendIPC(
    blocking: bool,
    do_call: bool,
    badge: usize,
    canGrant: bool,
    canGrantReply: bool,
    thread: *mut tcb_t,
    epptr: *mut endpoint_t,
) {
    unsafe {
        match endpoint_ptr_get_state(epptr) {
            EPState_Idle | EPState_Send => {
                if blocking {
                    thread_state_set_tsType(
                        (*thread).tcbState as *mut thread_state_t,
                        ThreadStateBlockedOnSend,
                    );
                    thread_state_set_blockingObject(
                        (*thread).tcbState as *mut thread_state_t,
                        epptr as usize,
                    );
                    thread_state_set_blockingIPCCanGrant(
                        (*thread).tcbState as *mut thread_state_t,
                        canGrant as usize,
                    );
                    thread_state_set_blockingIPCBadge(
                        (*thread).tcbState as *mut thread_state_t,
                        badge,
                    );
                    thread_state_set_blockingIPCCanGrantReply(
                        (*thread).tcbState as *mut thread_state_t,
                        canGrantReply as usize,
                    );
                    thread_state_set_blockingIPCIsCall(
                        (*thread).tcbState as *mut thread_state_t,
                        do_call as usize,
                    );

                    scheduleTCB(thread as *const tcb_t);

                    let mut queue = ep_ptr_get_queue(epptr);
                    queue = tcbEPAppend(thread as *mut tcb_t, queue);
                    endpoint_ptr_set_state(epptr, EPState_Send);
                    ep_ptr_set_queue(epptr, queue);
                }
            }
            EPState_Recv => {
                let mut queue = ep_ptr_get_queue(epptr);
                assert!(queue.head != 0);
                let dest = queue.head as *mut tcb_t;
                queue = tcbEPDequeue(dest, queue);

                if queue.head != 0 {
                    endpoint_ptr_set_state(epptr, EPState_Idle);
                }

                doIPCTransfer(thread, epptr, badge, canGrant, dest);

                let replyCanGrant = if thread_state_get_blockingIPCCanGrant((*dest).tcbState) != 0 {
                    true
                } else {
                    false
                };
                setThreadState(dest, ThreadStateRunning);
                possibleSwitchTo(dest);
                if do_call {
                    if canGrant || canGrantReply {
                        setupCallerCap(thread, dest, replyCanGrant);
                    } else {
                        setThreadState(thread, ThreadStateInactive);
                    }
                }
            }
            _ => {
                panic!(
                    "unknown epptr state in sendIPC(): {}",
                    endpoint_ptr_get_state(epptr)
                );
            }
        }
    }
}

pub fn receiveIPC(thread: *mut tcb_t, cap: *const cap_t, isBlocking: bool) {
    unsafe {
        let epptr = cap_endpoint_cap_get_capEPPtr(cap) as *const endpoint_t;
        match endpoint_ptr_get_state(epptr) {
            EPState_Idle | EPState_Recv => {
                if isBlocking {
                    thread_state_set_tsType(
                        (*thread).tcbState as *mut thread_state_t,
                        ThreadStateBlockedOnReceive,
                    );
                    thread_state_set_blockingObject(
                        (*thread).tcbState as *mut thread_state_t,
                        epptr as usize,
                    );
                    thread_state_set_blockingIPCCanGrant(
                        (*thread).tcbState as *mut thread_state_t,
                        cap_endpoint_cap_get_capCanGrant(cap),
                    );
                    scheduleTCB(thread);

                    let mut queue = ep_ptr_get_queue(epptr);
                    queue = tcbEPAppend(thread, queue);
                    endpoint_ptr_set_state(epptr as *mut endpoint_t, EPState_Recv);
                    ep_ptr_set_queue(epptr, queue);
                } else {
                    doNBRecvFailedTransfer(thread);
                }
            }
            EPState_Send => {
                let mut queue = ep_ptr_get_queue(epptr);
                assert!(queue.head != 0);
                let sender = queue.head as *mut tcb_t;
                queue = tcbEPDequeue(sender, queue);

                if queue.head == 0 {
                    endpoint_ptr_set_state(epptr as *mut endpoint_t, EPState_Idle);
                }
                let badge = thread_state_get_blockingIPCBadge((*sender).tcbState);
                let canGrant = if thread_state_get_blockingIPCCanGrant((*sender).tcbState) != 0 {
                    true
                } else {
                    false
                };
                let canGrantReply =
                    if thread_state_get_blockingIPCCanGrantReply((*sender).tcbState) != 0 {
                        true
                    } else {
                        false
                    };
                doIPCTransfer(sender, epptr as *mut endpoint_t, badge, canGrant, thread);
                let do_call = if thread_state_get_blockingIPCIsCall((*sender).tcbState) != 0 {
                    true
                } else {
                    false
                };
                if do_call {
                    if canGrant || canGrantReply {
                        let grant = if cap_endpoint_cap_get_capCanGrant(cap) != 0 {
                            true
                        } else {
                            false
                        };
                        setupCallerCap(sender, thread, grant);
                    } else {
                        setThreadState(sender, ThreadStateInactive);
                    }
                } else {
                    setThreadState(sender, ThreadStateRunning);
                    possibleSwitchTo(sender);
                }
            }
            _ => {
                panic!(
                    "unknown epptr state in receiveIPC(): {}",
                    endpoint_ptr_get_state(epptr)
                );
            }
        }
    }
}

pub fn cancelIPC(tptr: *const tcb_t) {
    unsafe {
        let state = (*tptr).tcbState;
        match thread_state_get_tsType(state) {
            ThreadStateBlockedOnSend | ThreadStateBlockedOnReceive => {
                let epptr = thread_state_get_blockingObject(state) as *mut endpoint_t;
                assert!(endpoint_ptr_get_state(epptr) != EPState_Idle);
                let mut queue = ep_ptr_get_queue(epptr);
                queue = tcbEPDequeue(tptr as *mut tcb_t, queue);
                ep_ptr_set_queue(epptr, queue);
                if queue.head == 0 {
                    endpoint_ptr_set_state(epptr, EPState_Idle);
                }
                setThreadState(tptr, ThreadStateInactive);
            }
            //FIXME:: ThreadStateBlockedONReply not implemented
            _ => {
                panic!(
                    " unknown thread state in cancelIPC:{}",
                    thread_state_get_tsType(state)
                );
            }
        }
    }
}

pub fn cancelAllIPC(epptr: *const endpoint_t) {
    unsafe {
        match endpoint_ptr_get_state(epptr) {
            EPState_Idle => {}
            _ => {
                let mut thread = endpoint_ptr_get_epQueue_head(epptr);
                endpoint_ptr_set_state(epptr as *mut endpoint_t, EPState_Idle);
                endpoint_ptr_set_epQueue_head(epptr as *mut endpoint_t, 0);
                endpoint_ptr_set_epQueue_tail(epptr as *mut endpoint_t, 0);
                while thread != 0 {
                    let ptr = thread as *const tcb_t;
                    setThreadState(ptr, ThreadStateRestart);
                    tcbSchedEnqueue(ptr as *mut tcb_t);
                    thread = (*ptr).tcbEPNext;
                }
                rescheduleRequired();
            }
        }
    }
}

pub fn cancelBadgedSends(epptr: *mut endpoint_t, badge: usize) {
    unsafe {
        match endpoint_ptr_get_state(epptr) {
            EPState_Idle | EPState_Recv => {}
            EPState_Send => {
                let mut queue = ep_ptr_get_queue(epptr);
                endpoint_ptr_set_state(epptr, EPState_Idle);
                endpoint_ptr_set_epQueue_head(epptr, 0);
                endpoint_ptr_set_epQueue_tail(epptr, 0);
                let mut thread = queue.head;
                while thread != 0 {
                    let ptr = thread as *const tcb_t;
                    thread = (*ptr).tcbEPNext;
                    let b = thread_state_get_blockingIPCBadge((*ptr).tcbState);

                    if b == badge {
                        setThreadState(ptr, ThreadStateRestart);
                        tcbSchedEnqueue(ptr as *mut tcb_t);
                        queue = tcbEPDequeue(ptr as *mut tcb_t, queue);
                    }
                }
                ep_ptr_set_queue(epptr, queue);

                if queue.head != 0 {
                    endpoint_ptr_set_state(epptr, EPState_Send);
                }
                rescheduleRequired();
            }
            _ => {
                panic!(
                    " unknown endpoint state in cancelBadgedSends:{}",
                    endpoint_ptr_get_state(epptr)
                );
            }
        }
    }
}

pub fn performInvocation_Endpoint(
    ep: *const endpoint_t,
    badge: usize,
    canGrant: bool,
    canGrantReply: bool,
    block: bool,
    call: bool,
) -> exception_t {
    unsafe {
        sendIPC(
            block,
            call,
            badge,
            canGrant,
            canGrantReply,
            ksCurThread as *mut tcb_t,
            ep as *mut endpoint_t,
        );
    }
    exception_t::EXCEPTION_NONE
}
