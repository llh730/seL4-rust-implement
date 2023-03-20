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
    tcbBoundNotification:Option<usize>,
    seL4_Fault_t:Option<usize>,
    tcbLookupFailure:Option<usize>,
    /* Domain, 1 byte (padded to 1 word) */
    domain:usize,
    /*  maximum controlled priority, 1 byte (padded to 1 word) */
    tcbMCP:usize,
    /* Priority, 1 byte (padded to 1 word) */
    tcbPriority:usize,
    /* Timeslice remaining, 1 word */
    tcbTimeSlice:usize,
    /* Capability pointer to thread fault handler, 1 word */
    tcbFaultHandler:Option<usize>,
    /* userland virtual address of thread IPC buffer, 1 word */
    tcbIPCBuffer:usize,
    /* Previous and next pointers for scheduler queues , 2 words */
    tcb_sched_next:Arc<Tcb>,
    tcbSchedPrev:Arc<Tcb>,
    /* Preivous and next pointers for endpoint and notification queues, 2 words */
    tcbEPNext:Arc<Tcb>,
    tcbEPPrev:Arc<Tcb>,
}

