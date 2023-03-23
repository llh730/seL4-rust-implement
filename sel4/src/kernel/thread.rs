extern crate alloc;
use crate::{
    config::{
        ksDomScheduleLength, tcbCNodeEntries, wordBits, SchedulerAction_ChooseNewThread,
        SchedulerAction_ResumeCurrentThread, CONFIG_KERNEL_STACK_BITS, CONFIG_NUM_DOMAINS,
        CONFIG_NUM_PRIORITIES, L2_BITMAP_SIZE, NUM_READY_QUEUES, SSTATUS_SPIE, SSTATUS_SPP,
    },
    BIT, MASK,
};
use alloc::string::String;
use core::{arch::asm, cell::RefCell};

use super::{object::structures::*, vspace::setVMRoot};

type prio_t = usize;

const ThreadStateInactive: usize = 0;
const ThreadStateRunning: usize = 1;
const ThreadStateRestart: usize = 2;
const ThreadStateBlockedOnReceive: usize = 3;
const ThreadStateBlockedOnSend: usize = 4;
const ThreadStateBlockedOnReply: usize = 5;
const ThreadStateBlockedOnNotification: usize = 6;
const ThreadStateIdleThreadState: usize = 7;

pub struct tcb_t {
    pub tcbArch: arch_tcb_t,
    pub tcbState: *const thread_state_t,
    pub seL4_Fault_t: Option<usize>,
    pub tcbLookupFailure: Option<usize>,
    pub domain: usize,
    pub tcbMCP: usize,
    pub tcbPriority: usize,
    pub tcbTimeSlice: usize,
    pub tcbFaultHandler: Option<usize>,
    pub tcbIPCBuffer: usize,
    pub tcbSchedNext: usize,
    pub tcbSchedPrev: usize,
    pub tcbEPNext: usize,
    pub tcbEPPrev: usize,
    pub rootCap: [*const cap_t; tcbCNodeEntries],
    pub tcbName: String,
}

pub struct arch_tcb_t {
    registers: [usize; n_contextRegisters],
}

const ra: usize = 0;
const sp: usize = 1;
const gp: usize = 2;
const tp: usize = 3;
const t0: usize = 4;
const t1: usize = 5;
const t2: usize = 6;
const s0: usize = 7;
const s1: usize = 8;
const a0: usize = 9;
const capRegister: usize = 9;
const badgeRegister: usize = 9;
const a1: usize = 10;
const a2: usize = 11;
const a3: usize = 12;
const a4: usize = 13;
const a5: usize = 14;
const a6: usize = 15;
const a7: usize = 16;
const s2: usize = 17;
const s3: usize = 18;
const s4: usize = 19;
const s5: usize = 20;
const s6: usize = 21;
const s7: usize = 22;
const s8: usize = 23;
const s9: usize = 24;
const s10: usize = 25;
const s11: usize = 26;
const t3: usize = 27;
const t4: usize = 28;
const t5: usize = 29;
const t6: usize = 30;
const SCAUSE: usize = 31;
const SSTATUS: usize = 32;
const FaultIP: usize = 33;
const NextIP: usize = 34;
const n_contextRegisters: usize = 35;

static kernel_stack_alloc: [u8; BIT!(CONFIG_KERNEL_STACK_BITS)] =
    [0; BIT!(CONFIG_KERNEL_STACK_BITS)];

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct tcb_queue_t {
    pub head: usize,
    pub tail: usize,
}

static mut ksDomainTime: usize = 0;

static mut ksCurDomain: usize = 0;

static mut ksDomScheduleIdx: usize = 0;

static mut ksCurThread: usize = 0;

static mut ksIdleThread: usize = 0;

static mut ksSchedulerAction: usize = 0;

static mut ksReadyQueues: [tcb_queue_t; NUM_READY_QUEUES] =
    [tcb_queue_t { head: 0, tail: 0 }; NUM_READY_QUEUES];

static mut ksReadyQueuesL2Bitmap: [[usize; L2_BITMAP_SIZE]; CONFIG_NUM_DOMAINS] =
    [[0; L2_BITMAP_SIZE]; CONFIG_NUM_DOMAINS];
static mut ksReadyQueuesL1Bitmap: [usize; CONFIG_NUM_DOMAINS] = [0; CONFIG_NUM_DOMAINS];

#[inline]
pub fn isStopped(thread: *const tcb_t) -> bool {
    unsafe {
        match thread_state_get_tsType((*thread).tcbState) {
            ThreadStateInactive => true,
            ThreadStateBlockedOnNotification => true,
            ThreadStateBlockedOnReceive => true,
            ThreadStateBlockedOnReply => true,
            ThreadStateBlockedOnSend => true,
            _ => false,
        }
    }
}

#[inline]
pub fn isRunnable(thread: *const tcb_t) -> bool {
    unsafe {
        match thread_state_get_tsType((*thread).tcbState) {
            ThreadStateRunning => true,
            ThreadStateRestart => true,
            _ => false,
        }
    }
}

#[inline]
pub fn ready_queues_index(dom: usize, prio: usize) -> usize {
    dom * CONFIG_NUM_PRIORITIES + prio
}

#[inline]
pub fn prio_to_l1index(prio: usize) -> usize {
    prio >> wordRadix
}

#[inline]
pub fn l1index_to_prio(l1index: usize) -> usize {
    l1index << wordRadix
}

#[inline]
pub fn invert_l1index(l1index: usize) -> usize {
    let inverted = L2_BITMAP_SIZE - 1 - l1index;
    inverted
}

#[inline]
pub fn getHighestPrio(dom: usize) -> prio_t {
    unsafe {
        let l1index = wordBits - 1 - ksReadyQueuesL1Bitmap[dom].leading_zeros() as usize;
        let l1index_inverted = invert_l1index(l1index);
        let l2index = wordBits - 1 - ksReadyQueuesL2Bitmap[dom][l1index_inverted];
        l1index_to_prio(l1index) | l2index
    }
}

#[inline]
pub fn isHighestPrio(dom: usize, prio: prio_t) -> bool {
    unsafe { ksReadyQueuesL1Bitmap[dom] == 0 || prio >= getHighestPrio(dom) }
}

#[inline]
pub fn addToBitmap(dom: usize, prio: usize) {
    unsafe {
        let l1index = prio_to_l1index(prio);
        let l1index_inverted = invert_l1index(l1index);
        ksReadyQueuesL1Bitmap[dom] |= BIT!(l1index);
        ksReadyQueuesL2Bitmap[dom][l1index_inverted] |= BIT!(prio & MASK!(wordRadix));
    }
}

#[inline]
pub fn removeFromBitmap(dom: usize, prio: usize) {
    unsafe {
        let l1index = prio_to_l1index(prio);
        let l1index_inverted = invert_l1index(l1index);
        if ksReadyQueuesL2Bitmap[dom][l1index_inverted] != 0 {
            ksReadyQueuesL1Bitmap[dom] &= !BIT!((l1index));
        }
    }
}

pub fn tcbSchedEnqueue(_tcb: *mut tcb_t) {
    unsafe {
        let tcb = &(*_tcb);
        if thread_state_get_tcbQueued((tcb).tcbState) != 0 {
            let dom = tcb.domain;
            let prio = tcb.tcbPriority;
            let idx = ready_queues_index(dom, prio);
            let mut queue = ksReadyQueues[idx];
            if queue.tail == 0 {
                queue.head = _tcb as *const tcb_t as usize;
                addToBitmap(dom, prio);
            } else {
                (*(queue.tail as *mut tcb_t)).tcbSchedNext = tcb as *const tcb_t as usize;
            }
            (*_tcb).tcbSchedPrev = queue.tail;
            (*_tcb).tcbSchedNext = 0;
            ksReadyQueues[idx] = queue;
            queue.tail = tcb as *const tcb_t as usize;

            thread_state_set_tcbQueued(tcb.tcbState as *mut thread_state_t, 1);
        }
    }
}

#[inline]
pub fn tcbSchedDequeue(_tcb: *const tcb_t) {
    unsafe {
        let tcb = &(*_tcb);
        if thread_state_get_tcbQueued(tcb.tcbState) != 0 {
            let dom = tcb.domain;
            let prio = tcb.tcbPriority;
            let idx = ready_queues_index(dom, prio);
            let mut queue = ksReadyQueues[idx];
            if tcb.tcbSchedPrev != 0 {
                (*(tcb.tcbSchedPrev as *mut tcb_t)).tcbSchedNext = tcb.tcbSchedNext;
            } else {
                queue.tail = tcb.tcbSchedNext;
                if tcb.tcbSchedNext == 0 {
                    removeFromBitmap(dom, prio);
                }
            }

            if tcb.tcbSchedNext != 0 {
                (*(tcb.tcbSchedNext as *mut tcb_t)).tcbSchedPrev = tcb.tcbSchedPrev;
            } else {
                queue.tail = tcb.tcbSchedPrev;
            }

            ksReadyQueues[idx] = queue;
            thread_state_set_tcbQueued(tcb.tcbState as *mut thread_state_t, 0);
        }
    }
}

pub fn tcbSchedAppend(tcb: *mut tcb_t) {
    unsafe {
        if thread_state_get_tcbQueued((*tcb).tcbState) != 0 {
            let dom = (*tcb).domain;
            let prio = (*tcb).tcbPriority;
            let idx = ready_queues_index(dom, prio);
            let mut queue = ksReadyQueues[idx];
            if queue.head == 0 {
                queue.head = tcb as usize;
                addToBitmap(dom, prio);
            } else {
                let next = queue.tail as *mut tcb_t;
                (*next).tcbSchedNext = tcb as usize;
            }
            (*tcb).tcbSchedPrev = queue.tail;
            (*tcb).tcbSchedNext = 0;
            ksReadyQueues[idx] = queue;

            thread_state_set_tcbQueued((*tcb).tcbState as *mut thread_state_t, 1);
        }
    }
}

#[inline]
pub fn setRegister(thread: *mut tcb_t, reg: usize, w: usize) {
    unsafe {
        (*thread).tcbArch.registers[reg] = w;
    }
}

#[inline]
pub fn getRegister(thread: *const tcb_t, reg: usize) -> usize {
    unsafe { (*thread).tcbArch.registers[reg] }
}

pub fn idle_thread() {
    unsafe {
        while true {
            asm!("wfi");
        }
    }
}

pub fn Arch_switchToThread(tcb: *const tcb_t) {
    setVMRoot(tcb as *mut tcb_t);
}

pub fn Arch_configureIdleThread(tcb: *const tcb_t) {
    setRegister(tcb as *mut tcb_t, NextIP, idle_thread as usize);
    setRegister(tcb as *mut tcb_t, SSTATUS, SSTATUS_SPP | SSTATUS_SPIE);
    setRegister(
        tcb as *mut tcb_t,
        sp,
        kernel_stack_alloc.as_ptr() as usize + BIT!(CONFIG_KERNEL_STACK_BITS),
    );
}

pub fn Arch_switchToIdleThread() {
    unsafe {
        let tcb = ksIdleThread as *mut tcb_t;
        setVMRoot(tcb);
    }
}

pub fn setThreadState(tptr: *const tcb_t, ts: usize) {
    unsafe {
        thread_state_set_tsType((*tptr).tcbState as *mut thread_state_t, ts);
        scheduleTCB(tptr);
    }
}

pub fn getReStartPc(thread: *const tcb_t) -> usize {
    getRegister(thread, FaultIP)
}

pub fn setNextPC(thread: *mut tcb_t, v: usize) {
    setRegister(thread, NextIP, v);
}

pub fn configureIdleThread(tcb: *const tcb_t) {
    Arch_configureIdleThread(tcb);
    setThreadState(tcb, ThreadStateIdleThreadState);
}

pub fn activateThread() {
    unsafe {
        let thread = ksCurThread as *mut tcb_t;
        match thread_state_get_tsType((*thread).tcbState as *const thread_state_t) {
            ThreadStateRunning => return,
            ThreadStateRestart => {
                let pc = getReStartPc(thread as *const tcb_t);
                setNextPC(thread, pc);
                setThreadState(thread as *const tcb_t, ThreadStateRunning);
            }
            ThreadStateIdleThreadState => return,
            _ => panic!("current thread is blocked"),
        }
    }
}

#[inline]
pub fn updateReStartPC(tcb: *mut tcb_t) {
    setRegister(tcb, FaultIP, getRegister(tcb, NextIP));
}

pub fn suspend(target: *mut tcb_t) {
    //FIXME::implement cancelIPC;
    // canceIPC(target);
    unsafe {
        if thread_state_get_tsType((*target).tcbState) == ThreadStateRunning {
            updateReStartPC(target);
        }
        setThreadState(target, ThreadStateInactive);
        tcbSchedDequeue(target);
    }
}

pub fn restart(target: *mut tcb_t) {
    if isStopped(target) {
        // FIXME::implemented cancelIPC
        // cancelIPC(target);
        // FIXME::implemented setupReplyMaster
        // setupReplyMaster(target);
        setThreadState(target, ThreadStateRestart);
        tcbSchedEnqueue(target);
        possibleSwitchTo(target);
    }
}

// pub fn doIPCTransfer(sender:*const sender,)

pub fn doNBRecvFailedTransfer(thread: *mut tcb_t) {
    setRegister(thread, badgeRegister, 0);
}

// pub fn nextDomain() {
//     unsafe {
//         ksDomScheduleIdx += 1;
//         if ksDomScheduleIdx>=ksDomScheduleLength{
//             ksDomScheduleIdx=0;
//         }
//         //FIXME ksWorkUnits not used;
//         // ksWorkUnits
//     }
// }

pub fn scheduleChooseNewThread() {
    chooseThread();
}

pub fn switchToThread(thread: *const tcb_t) {
    Arch_switchToThread(thread);
    tcbSchedDequeue(thread);
    unsafe {
        ksCurThread = thread as usize;
    }
}

pub fn chooseThread() {
    unsafe {
        let dom = 0;
        if ksReadyQueuesL1Bitmap[dom] != 0 {
            let prio = getHighestPrio(dom);
            let _thread = ksReadyQueues[ready_queues_index(dom, prio)].head;
            assert!(_thread != 0);
            let thread = _thread as *const tcb_t;
            switchToThread(thread);
        } else {
            switchToIdleThread();
        }
    }
}

pub fn switchToIdleThread() {
    unsafe {
        Arch_switchToIdleThread();
        ksCurThread = ksIdleThread;
    }
}

pub fn setMCPriority(tptr: *mut tcb_t, mcp: usize) {
    unsafe {
        (*tptr).tcbMCP = mcp;
    }
}

pub fn setPriority(tptr: *const tcb_t, prio: usize) {
    unsafe {
        tcbSchedDequeue(tptr);
        let mut_tptr = tptr as *mut tcb_t;
        (*mut_tptr).tcbPriority = prio;
        if isRunnable(tptr) {
            if tptr as usize == ksCurThread {
                rescheduleRequired();
            } else {
                possibleSwitchTo(tptr);
            }
        }
    }
}

pub fn possibleSwitchTo(target: *const tcb_t) {
    unsafe {
        if ksCurDomain != (*target).domain {
            tcbSchedEnqueue(target as *mut tcb_t);
        } else if ksSchedulerAction != SchedulerAction_ResumeCurrentThread {
            rescheduleRequired();
            tcbSchedEnqueue(target as *mut tcb_t);
        } else {
            ksSchedulerAction = target as usize;
        }
    }
}

pub fn scheduleTCB(tptr: *const tcb_t) {
    unsafe {
        if tptr as usize == ksCurThread
            && ksSchedulerAction == SchedulerAction_ResumeCurrentThread
            && !isRunnable(tptr)
        {
            rescheduleRequired();
        }
    }
}

pub fn rescheduleRequired() {
    unsafe {
        if ksSchedulerAction != SchedulerAction_ResumeCurrentThread
            && ksSchedulerAction != SchedulerAction_ChooseNewThread
        {
            tcbSchedEnqueue(ksSchedulerAction as *mut tcb_t);
        }
        ksSchedulerAction = SchedulerAction_ChooseNewThread;
    }
}

pub fn schedule() {
    unsafe {
        if ksSchedulerAction != SchedulerAction_ResumeCurrentThread {
            let was_runnable: bool;
            if isRunnable(ksCurThread as *const tcb_t) {
                was_runnable = true;
                tcbSchedEnqueue(ksCurThread as *mut tcb_t);
            } else {
                was_runnable = false;
            }

            if ksSchedulerAction == SchedulerAction_ChooseNewThread {
                scheduleChooseNewThread();
            } else {
                let candidate = ksSchedulerAction as *const tcb_t;
                let fastfail = ksCurThread == ksIdleThread
                    || (*candidate).tcbPriority < (*(ksCurThread as *const tcb_t)).tcbPriority;
                if fastfail && !isHighestPrio(ksCurDomain, (*candidate).tcbPriority) {
                    tcbSchedEnqueue(candidate as *mut tcb_t);
                    ksSchedulerAction = SchedulerAction_ChooseNewThread;
                    scheduleChooseNewThread();
                } else if was_runnable
                    && (*candidate).tcbPriority == (*(ksCurThread as *const tcb_t)).tcbPriority
                {
                    tcbSchedAppend(candidate as *mut tcb_t);
                    ksSchedulerAction = SchedulerAction_ChooseNewThread;
                    scheduleChooseNewThread();
                } else {
                    switchToThread(candidate);
                }
            }
        }
        ksSchedulerAction = SchedulerAction_ResumeCurrentThread;
    }
}
