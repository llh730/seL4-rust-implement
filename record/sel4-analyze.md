# sel4-analyze



## 启动流程

### elfloader

以下文件均在`tools/seL4/elfloader-tool/src/arch-riscv/`

链接脚本中`linker.lds`将`crt0.S`文件中的_start作为程序入口，在`_start`中设置好hart id 、 dtb后进入`boot.c`的main函数中，main函数内会将kernel、sel4test-driver elf文件写入内存，完成后，调用`sbi_hart_start`启动其他核，再开启mmu与页表后进入内核的启动点。

```c
//进入内核启动点的方法就是将其强转成一个函数，然后调用
//boot.c
((init_riscv_kernel_t)kernel_info.virt_entry)(user_info.phys_region_start,
                                                  user_info.phys_region_end,
                                                  user_info.phys_virt_offset,
                                                  user_info.virt_entry,
                                                  (word_t)dtb,
                                                  dtb_size
#if CONFIG_MAX_NUM_NODES > 1
                                                  ,
                                                  hart_id,
                                                  0
#endif
                                                 );
```



### kernel

代码位于`kernel/src/arch/riscv`中

分析其中的`common_riscv.lds`可知，程序的入口在`head.S`中的_start函数。

```ass
  /* Call bootstrapping implemented in C with parameters:
   *    a0/x10: user image physical start address
   *    a1/x11: user image physical end address
   *    a2/x12: physical/virtual offset
   *    a3/x13: user image virtual entry address
   *    a4/x14: DTB physical address (0 if there is none)
   *    a5/x15: DTB size (0 if there is none)
   *    a6/x16: hart ID (SMP only, unused on non-SMP)
   *    a7/x17: core ID (SMP only, unused on non-SMP)
   */
  jal init_kernel //寄存器已在调用函数时配好，直接调用init_kernel即可，init_kernel会先调用try_init_kernel来初始化内核。
```



```c
//boot.c try_init_kernel()中涉及多个初始化函数，先不做展开分析，仅列出
static BOOT_CODE bool_t try_init_kernel(
){
    init_cpu();
    init_plat();
    /* create the cap for managing thread domains */
    create_domain_cap(root_cnode_cap);

    /* initialise the IRQ states and provide the IRQ control cap */
    init_irqs(root_cnode_cap);
    create_bi_frame_cap(
        root_cnode_cap,
        it_pd_cap,
        bi_frame_vptr
    );
    /* create the idle thread */
    create_idle_thread();
    /* create the initial thread */
    tcb_t *initial = create_initial_thread(
                         root_cnode_cap,
                         it_pd_cap,
                         v_entry,
                         bi_frame_vptr,
                         ipcbuf_vptr,
                         ipcbuf_cap
                     );
    init_core_state(initial);
    
    /* finalise the bootinfo frame */
    bi_finalise();
}
```

完成上述工作，kernel正式启动，进入user态。

## Cnode与Cspace

`cnode`本质时一个`cte`的结构数组

```c
struct cte {
    cap_t cap;
    mdb_node_t cteMDBNode;
};

struct cap {
    uint64_t words[2];
};
typedef struct cap cap_t;
```

其中，`cap`为两个八字节的变量，`words[0]`指向具体的能力，`words[1]`存储具体能力的具体内容;`mdb_node_t`记录能力的前后关系,具体包含内容在下面给出

```c
//words[0]具体能力
enum cap_tag {
    cap_null_cap = 0,
    cap_untyped_cap = 2,
    cap_endpoint_cap = 4,
    ...
};
typedef enum cap_tag cap_tag_t;
//words[1]具体内容，部分列举
cap_irq_handler_cap：capIRQ
cap_cnode_cap：Radix \ Guard size \ Guard \ Cnode ptr
cap_endpoint_cap:badge
//mdb包含的部分:
block mdb_node {
    padding
    field_high mdbNext
    field mdbRevocable
    field mdbFirstBadged
    field mdbPrev
}
```

在`cnode.c`中定义了多种`cte`的操作方法：insert、move、revoke、delete等。

在cspace.c中定义了查找slot的方法，主要都要调用resolveAddressBits（）方法。

resolveAddressBits方法在`seL4-manual`手册的3.3章，可以参考解释对照代码。

```c
resolveAddressBits_ret_t resolveAddressBits(cap_t nodeCap, cptr_t capptr, word_t n_bits)
{
    ...
    while (1) {
            radixBits = cap_cnode_cap_get_capCNodeRadix(nodeCap);//槽号位数
            guardBits = cap_cnode_cap_get_capCNodeGuardSize(nodeCap);//保护位位数
            levelBits = radixBits + guardBits;//当前cnode占用的位数

            /* Haskell error: "All CNodes must resolve bits" */
            assert(levelBits != 0);//不存在占用0位的位数

            capGuard = cap_cnode_cap_get_capCNodeGuard(nodeCap);//当前cnode的保护位

            /* The MASK(wordRadix) here is to avoid the case where
             * n_bits = wordBits (=2^wordRadix) and guardBits = 0, as it violates
             * the C spec to shift right by more than wordBits-1.
             */
            guard = (capptr >> ((n_bits - guardBits) & MASK(wordRadix))) & MASK(guardBits);//读取要查询的cap的保护位
            if (unlikely(guardBits > n_bits || guard != capGuard)) {//如果两个保护位不相等就报错
                current_lookup_fault =
                    lookup_fault_guard_mismatch_new(capGuard, n_bits, guardBits);
                ret.status = EXCEPTION_LOOKUP_FAULT;
                return ret;
            }

            if (unlikely(levelBits > n_bits)) {//如果当前cnode占用位数已超过要查询slot的要求位数则报错
                current_lookup_fault =
                    lookup_fault_depth_mismatch_new(levelBits, n_bits);
                ret.status = EXCEPTION_LOOKUP_FAULT;
                return ret;
            }

            offset = (capptr >> (n_bits - levelBits)) & MASK(radixBits);
            slot = CTE_PTR(cap_cnode_cap_get_capCNodePtr(nodeCap)) + offset;

            if (likely(n_bits == levelBits)) {//如果当前cnode占用位数刚好与slot要求查询的位数想等，则匹配
                ret.status = EXCEPTION_NONE;
                ret.slot = slot;
                ret.bitsRemaining = 0;
                return ret;
            }
            //否则，就是cnode占用位数小于slot查询位数的情况，这说明，当前找到的slot是一个cnode，仍需向下一层查询

            n_bits -= levelBits;
            nodeCap = slot->cap;

            if (unlikely(cap_get_capType(nodeCap) != cap_cnode_cap)) {//如果当前cap不是一个cnode的cap，返回。？？？
                ret.status = EXCEPTION_NONE;
                ret.slot = slot;
                ret.bitsRemaining = n_bits;
                return ret;
            }
        }
}
```

### Thread与tcb

`tcb`的结构如下，其中domain域的作用是隔离独立的子系统，限制他们的信息流动。内核根据一个固定的、按时间触发的调度算法在域之间切换。

```c
//structures.h
struct tcb {
    /* arch specific tcb state (including context)*/
    arch_tcb_t tcbArch;

    /* Thread state, 3 words */
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

    /* Previous and next pointers for scheduler queues , 2 words */
    struct tcb *tcbSchedNext;
    struct tcb *tcbSchedPrev;
    /* Preivous and next pointers for endpoint and notification queues, 2 words */
    struct tcb *tcbEPNext;
    struct tcb *tcbEPPrev;
};
```

值得注意的是，每一个进程本应都应该有一个独立的`ipcbuffer`与`Cspace`。`ipcbuffer`位于中`tcb`结构中，而`Cspace`位于tcb外部，具体关系如下：

```c
/* We would like the actual 'tcb' region (the portion that contains the tcb_t) of the tcb to be as large as possible, but it still needs to be aligned. As the TCB object containstwo sub objects the largest we can make either sub object whilst preserving size alignment is half the total size. To halve an object size defined in bits we just subtract 1 */
// A diagram of a TCB kernel object that is created from untyped:
//  _______________________________________
// |     |             |                   |
// |     |             |                   |
// |cte_t|   unused    |       tcb_t       |
// |     |(debug_tcb_t)|                   |
// |_____|_____________|___________________|
// 0     a             b                   c
// a = tcbCNodeEntries * sizeof(cte_t)
// b = BIT(TCB_SIZE_BITS)
// c = BIT(seL4_TCBBits)
// 注释所说，内存给一个tcb 分配的空间大小为 2^c，我们想要让tcb_t的空间尽可能的大，但又要保证对齐，因此tcb_t占的空间大小为2^(c-1)大小。
```

//FIXME:获取最高优先级中仍有部分函数不太理解

schedule流程：状态机节选自博客

1. 判断当前ksSchedulerAction是否为SchedulerAction_ResumeCurrentThread，如果是则表示调度已经完成，进入步骤五；如果不是表示调度未完成，则判断当前进程是否可调度，如果可调度则将其加入调度队列，进入步骤二；
2. 如果ksSchedulerAction表示为SchedulerAction_ChooseNewThread，进入步骤四；否则进入步骤三；
3. 此时ksSchedulerAction表示候选进程，查看该候选进程是否满足直接调度条件，即该进程的优先级最高。如果该候选进程优先级最高则直接调用switchToThread函数，否则进入步骤四；
4. 调用scheduleChooseNewThread函数，该函数从就绪队列里找出优先级最高的进程；
5. 调度完成；
6. 最后由restore_user_context函数完成上下文的切换

原文链接：https://blog.csdn.net/Mr0cheng/article/details/104338064

```c

```





## Others

使用gdb调试方法：https://zhuanlan.zhihu.com/p/552698050