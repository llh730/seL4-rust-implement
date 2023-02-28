extern crate alloc;
use alloc::sync::{Arc};

enum ThreadState{
    ThreadStateInactive=0,
    ThreadStateRunning,
    ThreadStateRestart,
    ThreadStateBlockedOnReceive,
    ThreadStateBlockedOnSend,
    ThreadStateBlockedOnReply,
    ThreadStateBlockedOnNotification,
    ThreadStateIdleThreadState,
}

pub struct Tcb {
    tcbState:ThreadState,
    tcbBoundNotification:Option<u64>,
    seL4_Fault_t:Option<u64>,
    tcbLookupFailure:Option<u64>,
    /* Domain, 1 byte (padded to 1 word) */
    domain:u64,
    /*  maximum controlled priority, 1 byte (padded to 1 word) */
    tcbMCP:u64,
    /* Priority, 1 byte (padded to 1 word) */
    tcbPriority:u64,
    /* Timeslice remaining, 1 word */
    tcbTimeSlice:u64,
    /* Capability pointer to thread fault handler, 1 word */
    tcbFaultHandler:Option<u64>,
    /* userland virtual address of thread IPC buffer, 1 word */
    tcbIPCBuffer:u64,
    /* Previous and next pointers for scheduler queues , 2 words */
    tcb_sched_next:Arc<Tcb>,
    tcbSchedPrev:Arc<Tcb>,
    /* Preivous and next pointers for endpoint and notification queues, 2 words */
    tcbEPNext:Arc<Tcb>,
    tcbEPPrev:Arc<Tcb>,
}

