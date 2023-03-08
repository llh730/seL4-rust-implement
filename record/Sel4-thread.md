# Sel4-thread

结合sel4手册与代码分析sel4中的线程与调度，方便rust实现。

线程控制块定义：

```c
struct tcb {
    /* arch specific tcb state (including context)*/
    //在riscv中该结构为一个连通寄存器的数组
    arch_tcb_t tcbArch;

    /* Thread state, 3 words */
    //用24个字节表示？ uint64_t words[3]
    thread_state_t tcbState;

    /* Notification that this TCB is bound to. If this is set, when this TCB waits on
     * any sync endpoint, it may receive a signal from a Notification object.
     * 1 word*/
    notification_t *tcbBoundNotification;

    /* Current fault, 2 words */
    seL4_Fault_t tcbFault;

    /* Current lookup failure, 2 words */
    lookup_fault_t tcbLookupFailure;

    /* Domain, 1 byte (padded to 1 word) */
    dom_t tcbDomain;

    /*  maximum controlled priority, 1 byte (padded to 1 word) */
    prio_t tcbMCP;

    /* Priority, 1 byte (padded to 1 word) */
    prio_t tcbPriority;

#ifdef CONFIG_KERNEL_MCS
    /* scheduling context that this tcb is running on, if it is NULL the tcb cannot
     * be in the scheduler queues, 1 word */
    sched_context_t *tcbSchedContext;

    /* scheduling context that this tcb yielded to */
    sched_context_t *tcbYieldTo;
#else
    /* Timeslice remaining, 1 word */
    word_t tcbTimeSlice;

    /* Capability pointer to thread fault handler, 1 word */
    cptr_t tcbFaultHandler;
#endif

    /* userland virtual address of thread IPC buffer, 1 word */
    word_t tcbIPCBuffer;

#ifdef ENABLE_SMP_SUPPORT
    /* cpu ID this thread is running on, 1 word */
    word_t tcbAffinity;
#endif /* ENABLE_SMP_SUPPORT */

    /* Previous and next pointers for scheduler queues , 2 words */
    struct tcb *tcbSchedNext;
    struct tcb *tcbSchedPrev;
    /* Preivous and next pointers for endpoint and notification queues, 2 words */
    struct tcb *tcbEPNext;
    struct tcb *tcbEPPrev;

#ifdef CONFIG_BENCHMARK_TRACK_UTILISATION
    /* 16 bytes (12 bytes aarch32) */
    benchmark_util_t benchmark;
#endif
};
```

