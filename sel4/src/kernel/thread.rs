extern crate alloc;
use crate::{
    config::{
        ksDomScheduleLength, msgInfoRegister, n_msgRegisters, seL4_MsgMaxExtraCaps,
        seL4_MsgMaxLength, tcbCNodeEntries, tcbCaller, tcbReply, wordBits,
        SchedulerAction_ChooseNewThread, SchedulerAction_ResumeCurrentThread,
        CONFIG_KERNEL_STACK_BITS, CONFIG_NUM_DOMAINS, CONFIG_NUM_PRIORITIES, L2_BITMAP_SIZE,
        NUM_READY_QUEUES, SSTATUS_SPIE, SSTATUS_SPP,
    },
    elfloader::KERNEL_STACK,
    kernel::object::objecttype::cap_reply_cap,
    println,
    sbi::shutdown,
    BIT, MASK,
};
use alloc::string::String;
use core::arch::asm;
use riscv::register::sstatus::{self, SPP};

use super::{
    boot::current_extra_caps,
    object::{
        cap::cteInsert,
        cspace::{capTransferFromWords, cap_transfer_t, lookupCap, lookupSlot, lookupTargetSlot},
        endpoint::cancelIPC,
        msg::{
            seL4_MessageInfo_ptr_get_capsUnwrapped, seL4_MessageInfo_ptr_get_extraCaps,
            seL4_MessageInfo_ptr_get_length, seL4_MessageInfo_ptr_set_capsUnwrapped,
            seL4_MessageInfo_ptr_set_extraCaps, seL4_MessageInfo_ptr_set_length,
            seL4_MessageInfo_t,
        },
        objecttype::{cap_endpoint_cap, cap_null_cap, deriveCap, deriveCap_ret},
        structures::*,
    },
    vspace::{lookupIPCBuffer, setVMRoot},
};

type prio_t = usize;

pub const ThreadStateInactive: usize = 0;
pub const ThreadStateRunning: usize = 1;
pub const ThreadStateRestart: usize = 2;
pub const ThreadStateBlockedOnReceive: usize = 3;
pub const ThreadStateBlockedOnSend: usize = 4;
pub const ThreadStateBlockedOnReply: usize = 5;
pub const ThreadStateBlockedOnNotification: usize = 6;
pub const ThreadStateIdleThreadState: usize = 7;
pub const ThreadStateExited: usize = 8;

pub struct tcb_t {
    pub tcbArch: arch_tcb_t,
    pub tcbState: *const thread_state_t,
    pub seL4_Fault_t: usize,
    pub tcbLookupFailure: usize,
    pub domain: usize,
    pub tcbMCP: usize,
    pub tcbPriority: usize,
    pub tcbTimeSlice: usize,
    pub tcbFaultHandler: usize,
    pub tcbIPCBuffer: usize,
    pub tcbSchedNext: usize,
    pub tcbSchedPrev: usize,
    pub tcbEPNext: usize,
    pub tcbEPPrev: usize,
    pub rootCap: [*const cte_t; tcbCNodeEntries],
    pub tcbName: String,
}
impl tcb_t {
    pub fn init(tcb: *mut tcb_t) {
        unsafe {
            (*tcb).tcbArch = arch_tcb_t::new();
            (*tcb).tcbState = 0 as *const thread_state_t;
            (*tcb).seL4_Fault_t = 0;
            (*tcb).tcbLookupFailure = 0;
            (*tcb).domain = 0;
            (*tcb).tcbMCP = 0;
            (*tcb).tcbPriority = 0;
            (*tcb).tcbTimeSlice = 0;
            (*tcb).tcbFaultHandler = 0;
            (*tcb).tcbIPCBuffer = 0;
            (*tcb).tcbSchedNext = 0;
            (*tcb).tcbSchedPrev = 0;
            (*tcb).tcbEPNext = 0;
            (*tcb).tcbEPPrev = 0;
            (*tcb).rootCap = [0 as *const cte_t; tcbCNodeEntries];
            (*tcb).tcbName = String::from(" ");
        }
    }
}

pub struct arch_tcb_t {
    pub registers: [usize; n_contextRegisters],
}

impl arch_tcb_t {
    pub fn new() -> Self {
        arch_tcb_t {
            registers: [0; n_contextRegisters],
        }
    }
    pub fn set_sp(&mut self, value: usize) {
        self.registers[1] = value;
    }
    pub fn app_init_context(entry: usize, sp_value: usize) -> Self {
        let mut status = sstatus::read();
        status.set_spp(SPP::User);
        let mut cx = Self {
            registers: [0; n_contextRegisters],
        };
        cx.registers[SSTATUS] = status.bits();
        cx.registers[NextIP] = entry;
        cx.set_sp(sp_value);
        cx
    }
}

pub struct dschedule {
    domain: usize,
    length: usize,
}

pub const ra: usize = 0;
pub const sp: usize = 1;
const gp: usize = 2;
const tp: usize = 3;
const t0: usize = 4;
const t1: usize = 5;
const t2: usize = 6;
const s0: usize = 7;
const s1: usize = 8;
const a0: usize = 9;
pub const capRegister: usize = 9;
pub const badgeRegister: usize = 9;
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
pub const SCAUSE: usize = 31;
pub const SSTATUS: usize = 32;
pub const FaultIP: usize = 33;
pub const NextIP: usize = 34;
pub const n_contextRegisters: usize = 35;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct tcb_queue_t {
    pub head: usize,
    pub tail: usize,
}

static mut ksDomainTime: usize = 0;

pub static mut ksCurDomain: usize = 0;

static mut ksDomScheduleIdx: usize = 0;

pub static mut ksCurThread: usize = 0;

pub static mut ksIdleThread: usize = 0;

pub static mut ksSchedulerAction: usize = 0;

static mut ksReadyQueues: [tcb_queue_t; NUM_READY_QUEUES] =
    [tcb_queue_t { head: 0, tail: 0 }; NUM_READY_QUEUES];

static mut ksReadyQueuesL2Bitmap: [[usize; L2_BITMAP_SIZE]; CONFIG_NUM_DOMAINS] =
    [[0; L2_BITMAP_SIZE]; CONFIG_NUM_DOMAINS];
static mut ksReadyQueuesL1Bitmap: [usize; CONFIG_NUM_DOMAINS] = [0; CONFIG_NUM_DOMAINS];

pub fn Arch_initContext(context: *mut arch_tcb_t) {
    unsafe {
        (*context).registers[SSTATUS] = 0x00040020;
    }
}

#[inline]
pub fn isStopped(thread: *const tcb_t) -> bool {
    if thread as usize == 0 || thread as usize == 1 {
        return true;
    }
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
    if thread as usize == 0 || thread as usize == 1 {
        return false;
    }
    unsafe {
        // println!(
        //     "kscurthread state:{}",
        //     thread_state_get_tsType((*thread).tcbState)
        // );
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
        let l2index =
            wordBits - 1 - ksReadyQueuesL2Bitmap[dom][l1index_inverted].leading_zeros() as usize;
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
        // println!(
        //     "before add bitmap:{} , prio:{}",
        //     ksReadyQueuesL1Bitmap[dom], prio
        // );
        ksReadyQueuesL1Bitmap[dom] |= BIT!(l1index);
        ksReadyQueuesL2Bitmap[dom][l1index_inverted] |= BIT!(prio & MASK!(wordRadix));
        // println!("after add bitmap:{} ,prio:{}", ksReadyQueuesL1Bitmap[dom], prio);
    }
}

#[inline]
pub fn removeFromBitmap(dom: usize, prio: usize) {
    unsafe {
        let l1index = prio_to_l1index(prio);
        let l1index_inverted = invert_l1index(l1index);
        // println!("before remove bitmap:{} ,prio:{}", ksReadyQueuesL1Bitmap[dom], prio);
        ksReadyQueuesL2Bitmap[dom][l1index_inverted] &=! BIT!(prio&MASK!(wordRadix));
        if ksReadyQueuesL2Bitmap[dom][l1index_inverted] == 0 {
            ksReadyQueuesL1Bitmap[dom] &= !(BIT!((l1index)));
        }
        // println!("after remove bitmap:{} ,prio:{}", ksReadyQueuesL1Bitmap[dom], prio);
    }
}

pub fn tcbSchedEnqueue(_tcb: *mut tcb_t) {
    unsafe {
        let tcb = &(*_tcb);
        if thread_state_get_tcbQueued(tcb.tcbState) == 0 {
            let dom = tcb.domain;
            let prio = tcb.tcbPriority;
            let idx = ready_queues_index(dom, prio);
            let mut queue = ksReadyQueues[idx];
            // println!(
            //     " before enqueue queue head :{:#x} ,tail :{:#x}",
            //     queue.head, queue.tail
            // );
            if queue.tail == 0 {
                queue.head = _tcb as *const tcb_t as usize;
                addToBitmap(dom, prio);
            } else {
                (*(queue.tail as *mut tcb_t)).tcbSchedNext = tcb as *const tcb_t as usize;
            }
            // println!(
            //     "after enqueue queue head :{:#x} ,tail :{:#x}",
            //     queue.head, queue.tail
            // );
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
            // println!("in here");
            // let prio = getHighestPrio(dom);
            // println!("in dequeue prio:{}",prio);
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
        if thread_state_get_tcbQueued((*tcb).tcbState) == 0 {
            let dom = (*tcb).domain;
            let prio = (*tcb).tcbPriority;
            println!("{} {}", dom, prio);
            let idx = ready_queues_index(dom, prio);
            let mut queue = ksReadyQueues[idx];
            // println!("tail:{:#x} head:{:#x}", queue.tail, queue.head);
            if queue.head == 0 {
                queue.head = tcb as usize;
                addToBitmap(dom, prio);
            } else {
                let next = queue.tail as *mut tcb_t;
                (*next).tcbSchedNext = tcb as usize;
            }
            // println!("tail:{:#x} head:{:#x}", queue.tail, queue.head);
            (*tcb).tcbSchedPrev = queue.tail;
            (*tcb).tcbSchedNext = 0;
            ksReadyQueues[idx] = queue;

            thread_state_set_tcbQueued((*tcb).tcbState as *mut thread_state_t, 1);
        }
    }
}

pub fn tcbEPAppend(tcb: *mut tcb_t, mut queue: tcb_queue_t) -> tcb_queue_t {
    unsafe {
        if queue.head == 0 {
            queue.head = tcb as usize;
        } else {
            (*(queue.tail as *mut tcb_t)).tcbEPNext = tcb as usize;
        }
        (*tcb).tcbEPPrev = queue.tail;
        (*tcb).tcbEPNext = 0;
        queue.tail = tcb as usize;
        queue
    }
}

pub fn tcbEPDequeue(tcb: *mut tcb_t, mut queue: tcb_queue_t) -> tcb_queue_t {
    unsafe {
        if (*tcb).tcbEPPrev != 0 {
            (*((*tcb).tcbEPPrev as *mut tcb_t)).tcbEPNext = (*tcb).tcbEPNext;
        } else {
            queue.head = (*tcb).tcbEPNext as usize;
        }
        if (*tcb).tcbEPNext != 0 {
            (*((*tcb).tcbEPNext as *mut tcb_t)).tcbEPPrev = (*tcb).tcbEPPrev;
        } else {
            queue.tail = (*tcb).tcbEPPrev as usize;
        }
        queue
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
    setRegister(tcb as *mut tcb_t, sp, KERNEL_STACK.get_sp());
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

pub fn getReStartPC(thread: *const tcb_t) -> usize {
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
        assert!(ksCurThread != 0 && ksCurThread != 1);
        let thread = ksCurThread as *mut tcb_t;
        match thread_state_get_tsType((*thread).tcbState as *const thread_state_t) {
            ThreadStateRunning => return,
            ThreadStateRestart => {
                let pc = getReStartPC(thread as *const tcb_t);
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
        cancelIPC(target);
        // FIXME::implemented setupReplyMaster
        // setupReplyMaster(target);
        setThreadState(target, ThreadStateRestart);
        tcbSchedEnqueue(target);
        possibleSwitchTo(target);
    }
}

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
            // println!("prio:{}", prio);
            let _thread = ksReadyQueues[ready_queues_index(dom, prio)].head;
            assert!(_thread != 0);
            let thread = _thread as *const tcb_t;
            switchToThread(thread);
        } else {
            // println!("all applications finished! turn to shutdown");
            shutdown();
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
        // println!("ksSchedulerAction:{}", ksSchedulerAction);
        if ksSchedulerAction != SchedulerAction_ResumeCurrentThread {
            let was_runnable: bool;
            // println!("isRunnable:{}", isRunnable(ksCurThread as *const tcb_t));
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

pub fn doIPCTransfer(
    sender: *mut tcb_t,
    endpoint: *mut endpoint_t,
    badge: usize,
    grant: bool,
    receiver: *mut tcb_t,
) {
    let receiveBuffer = lookupIPCBuffer(true, receiver);
    let sendBuffer = lookupIPCBuffer(false, sender);
    doNormalTransfer(
        sender,
        sendBuffer,
        endpoint,
        badge,
        grant,
        receiver,
        receiveBuffer,
    );
}
pub fn doNormalTransfer(
    sender: *mut tcb_t,
    sendBuffer: usize,
    endpoint: *mut endpoint_t,
    badge: usize,
    canGrant: bool,
    receiver: *mut tcb_t,
    receivedBuffer: usize,
) {
    let mut tag = messageInfoFromWord(getRegister(sender, msgInfoRegister));

    if canGrant {
        let status = lookupExtraCaps(sender, sendBuffer, &tag);
    }
    let msgTransferred = copyMRs(
        sender,
        sendBuffer,
        receiver,
        receivedBuffer,
        seL4_MessageInfo_ptr_get_length((&tag) as *const seL4_MessageInfo_t),
    );
    tag = transferCaps(tag, endpoint, receiver, receivedBuffer);
    seL4_MessageInfo_ptr_set_length(
        (&tag) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
        msgTransferred,
    );
    setRegister(receiver, msgInfoRegister, wordFromMEssageInfo(tag));
    setRegister(receiver, badgeRegister, badge);
}

pub fn messageInfoFromWord_raw(w: usize) -> seL4_MessageInfo_t {
    let mi = seL4_MessageInfo_t { words: [w] };
    mi
}

pub fn messageInfoFromWord(w: usize) -> seL4_MessageInfo_t {
    let mi = seL4_MessageInfo_t { words: [w] };
    let len = seL4_MessageInfo_ptr_get_length((&mi) as *const seL4_MessageInfo_t);
    if len > seL4_MsgMaxLength {
        seL4_MessageInfo_ptr_set_length(
            (&mi) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
            seL4_MsgMaxLength,
        );
    }
    mi
}

#[inline]
pub fn wordFromMEssageInfo(mi: seL4_MessageInfo_t) -> usize {
    mi.words[0]
}

pub fn copyMRs(
    sender: *mut tcb_t,
    sendBuf: usize,
    receiver: *mut tcb_t,
    recvBuf: usize,
    n: usize,
) -> usize {
    let mut i = 0;
    while i < n && i < n_msgRegisters {
        setRegister(
            receiver,
            getMsgRegisterNumber(i),
            getRegister(sender, getMsgRegisterNumber(i)),
        );
        i += 1;
    }

    if recvBuf == 0 && sendBuf == 0 {
        return i;
    }
    while i < n {
        unsafe {
            let recvPtr = (recvBuf + i + 1) as *const usize as *mut usize;
            let sendPtr = (sendBuf + i + 1) as *const usize as *mut usize;
            *recvPtr = *sendPtr;
        }
    }
    i
}

pub fn getMsgRegisterNumber(index: usize) -> usize {
    index + 11
}

pub fn lookupExtraCaps(
    thread: *mut tcb_t,
    bufferPtr: usize,
    info: &seL4_MessageInfo_t,
) -> exception_t {
    unsafe {
        if bufferPtr == 0 {
            current_extra_caps.excaprefs[0] = 0 as *const cte_t;
            return exception_t::EXCEPTION_NONE;
        }
        let length = seL4_MessageInfo_ptr_get_extraCaps(info as *const seL4_MessageInfo_t);
        let mut i = 0;
        while i < length {
            let cptr = getExtraCPtr(bufferPtr, i);
            let lu_ret = lookupSlot(thread, cptr);
            if lu_ret.status != exception_t::EXCEPTION_NONE {
                panic!(" lookup slot error , found slot :{}", lu_ret.slot as usize);
            }
            current_extra_caps.excaprefs[i] = lu_ret.slot;
            i += 1;
        }
        if i < seL4_MsgMaxExtraCaps {
            current_extra_caps.excaprefs[i] = 0 as *const cte_t;
        }
        return exception_t::EXCEPTION_NONE;
    }
}

pub fn getExtraCPtr(bufferPtr: usize, i: usize) -> usize {
    unsafe {
        let ptr = (bufferPtr + (seL4_MsgMaxLength + 2 + i) * 8) as *const usize;
        *ptr
    }
}

pub fn setExtraBadge(bufferPtr: usize, badge: usize, i: usize) {
    unsafe {
        let ptr = (bufferPtr + seL4_MsgMaxLength + 2 + i) as *mut usize;
        *ptr = badge;
    }
}

pub fn transferCaps(
    info: seL4_MessageInfo_t,
    endpoint: *mut endpoint_t,
    receiver: *mut tcb_t,
    receivedBuffer: usize,
) -> seL4_MessageInfo_t {
    unsafe {
        seL4_MessageInfo_ptr_set_extraCaps(
            (&info) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
            0,
        );
        seL4_MessageInfo_ptr_set_capsUnwrapped(
            (&info) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
            0,
        );

        if current_extra_caps.excaprefs[0] as usize == 0 && receivedBuffer == 0 {
            return info;
        }

        let mut destSlot = getReceiveSlots(receiver, receivedBuffer);
        let mut i = 0;
        while i < seL4_MsgMaxExtraCaps && current_extra_caps.excaprefs[i] as usize != 0 {
            let slot = current_extra_caps.excaprefs[i];
            let cap = (*slot).cap;
            if cap_get_capType(cap) == cap_endpoint_cap
                && (cap_endpoint_cap_get_capEPPtr(cap) == endpoint as usize)
            {
                setExtraBadge(receivedBuffer, cap_endpoint_cap_get_capEPBadge(cap), i);
                seL4_MessageInfo_ptr_set_capsUnwrapped(
                    (&info) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
                    seL4_MessageInfo_ptr_get_capsUnwrapped((&info) as *const seL4_MessageInfo_t)
                        | (1 << i),
                );
            } else {
                if destSlot as usize == 0 {
                    break;
                }
                let dc_ret = deriveCap(slot, cap);
                if dc_ret.status != exception_t::EXCEPTION_NONE
                    || cap_get_capType(dc_ret.cap) == cap_null_cap
                {
                    break;
                }

                cteInsert(dc_ret.cap, slot, destSlot);
                destSlot = 0 as *const cte_t;
            }
            i += 1;
        }
        seL4_MessageInfo_ptr_set_extraCaps(
            (&info) as *const seL4_MessageInfo_t as *mut seL4_MessageInfo_t,
            i,
        );
        return info;
    }
}

pub fn getReceiveSlots(thread: *mut tcb_t, buffer: usize) -> *const cte_t {
    if buffer == 0 {
        return 0 as *const cte_t;
    }
    let ct = loadCapTransfer(buffer);
    let cptr = ct.ctReceiveRoot;
    let luc_ret = lookupCap(thread, cptr);
    let cnode = luc_ret.cap;
    let lus_ret = lookupTargetSlot(cnode, ct.ctReceiveIndex, ct.ctReceiveDepth);
    unsafe {
        if cap_get_capType((*lus_ret.slot).cap) != cap_null_cap {
            return 0 as *const cte_t;
        }
    }
    lus_ret.slot
}

pub fn loadCapTransfer(buffer: usize) -> cap_transfer_t {
    let offset = seL4_MsgMaxLength + 2 + seL4_MsgMaxExtraCaps;
    return capTransferFromWords(buffer + offset * 8);
}

pub fn setupCallerCap(sender: *const tcb_t, receiver: *const tcb_t, canGrant: bool) {
    unsafe {
        let replySlot = (*sender).rootCap[tcbReply];
        let masterCap = (*replySlot).cap;

        assert!(cap_get_capType(masterCap) == cap_reply_cap);
        assert!(cap_reply_cap_get_capReplyMaster(masterCap) == 1);
        assert!(cap_reply_cap_get_capReplyCanGrant(masterCap) == 1);
        assert!(cap_reply_cap_get_capTCBPtr(masterCap) == sender as usize);

        let callerSlot = (*receiver).rootCap[tcbCaller];
        let callerCap = (*callerSlot).cap;

        assert!(cap_get_capType(callerCap) == cap_null_cap);
        cteInsert(
            cap_reply_cap_new(canGrant as usize, 0, sender as usize),
            replySlot,
            callerSlot,
        );
    }
}
