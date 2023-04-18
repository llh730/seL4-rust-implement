extern crate alloc;
use crate::{
    config::{
        frameRegisters, gpRegisters, msgInfoRegister, msgRegister, n_frameRegisters, n_gpRegisters,
        n_msgRegisters, seL4_MsgMaxExtraCaps, seL4_MsgMaxLength, tcbBuffer, tcbCNodeEntries,
        tcbCTable, tcbCaller, tcbReply, tcbVTable, thread_control_update_ipc_buffer,
        thread_control_update_mcp, thread_control_update_priority, thread_control_update_space,
        wordBits, CopyRegisters_resumeTarget, CopyRegisters_suspendSource,
        CopyRegisters_transferFrame, CopyRegisters_transferInteger, ReadRegisters_suspend,
        SchedulerAction_ChooseNewThread, SchedulerAction_ResumeCurrentThread, TCBBindNotification,
        TCBConfigure, TCBCopyRegisters, TCBReadRegisters, TCBResume, TCBSetIPCBuffer,
        TCBSetMCPriority, TCBSetPriority, TCBSetSchedParams, TCBSetSpace, TCBSuspend,
        TCBUnbindNotification, TCBWriteRegisters, CONFIG_NUM_DOMAINS, CONFIG_NUM_PRIORITIES,
        L2_BITMAP_SIZE, NUM_READY_QUEUES, SSTATUS_SPIE, SSTATUS_SPP,
    },
    elfloader::KERNEL_STACK,
    kernel::object::objecttype::cap_reply_cap,
    println,
    sbi::shutdown,
    syscall::process::getSyscallArg,
    BIT, MASK,
};
use alloc::string::String;
use core::{arch::asm, panic};
use riscv::register::sstatus::{self, SPP};

use super::{
    boot::current_extra_caps,
    object::{
        cap::{cteDelete, cteInsert, slotCapLongRunningDelete},
        cspace::{capTransferFromWords, cap_transfer_t, lookupCap, lookupSlot, lookupTargetSlot},
        endpoint::cancelIPC,
        msg::{
            seL4_MessageInfo_new, seL4_MessageInfo_ptr_get_capsUnwrapped,
            seL4_MessageInfo_ptr_get_extraCaps, seL4_MessageInfo_ptr_get_length,
            seL4_MessageInfo_ptr_set_capsUnwrapped, seL4_MessageInfo_ptr_set_extraCaps,
            seL4_MessageInfo_ptr_set_length, seL4_MessageInfo_t,
        },
        notification::{bindNotification, unbindNotification},
        objecttype::{
            cap_cnode_cap, cap_endpoint_cap, cap_notification_cap, cap_null_cap, cap_thread_cap,
            deriveCap, sameObjectAs, updateCapData,
        },
        structures::*,
    },
    vspace::{checkValidIPCBuffer, isValidVTableRoot, lookupIPCBuffer, setVMRoot},
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
    pub tcbBoundNotification: usize,
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
            (*tcb).tcbBoundNotification = 0;
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

pub static mut ksSchedulerAction: usize = 1;

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
        ksReadyQueuesL2Bitmap[dom][l1index_inverted] &= !BIT!(prio & MASK!(wordRadix));
        if ksReadyQueuesL2Bitmap[dom][l1index_inverted] == 0 {
            ksReadyQueuesL1Bitmap[dom] &= !(BIT!((l1index)));
        }
        // println!("after remove bitmap:{} ,prio:{}", ksReadyQueuesL1Bitmap[dom], prio);
    }
}

pub fn setMR(receiver: *const tcb_t, receivedBuffer: usize, offset: usize, reg: usize) -> usize {
    if offset >= n_msgRegisters {
        if receivedBuffer != 0 {
            let ptr = (receivedBuffer + (offset + 1) * 8) as *mut usize;
            unsafe {
                *ptr = reg;
            }
            return offset + 1;
        } else {
            return n_msgRegisters;
        }
    } else {
        setRegister(receiver as *mut tcb_t, msgRegister[offset], reg);
        return offset + 1;
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
            queue.tail = tcb as *const tcb_t as usize;
            ksReadyQueues[idx] = queue;

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
                queue.head = tcb.tcbSchedNext;
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
        if thread_state_get_tcbQueued((*tcb).tcbState) == 0 {
            let dom = (*tcb).domain;
            let prio = (*tcb).tcbPriority;
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

pub fn setThreadState(tptr: *mut tcb_t, ts: usize) {
    unsafe {
        thread_state_set_tsType((*tptr).tcbState as *mut thread_state_t, ts);
        scheduleTCB(tptr);
    }
}

pub fn getReStartPC(thread: *const tcb_t) -> usize {
    getRegister(thread, FaultIP)
}

pub fn setRestartPC(thread: *mut tcb_t, v: usize) {
    setRegister(thread, NextIP, v);
}

pub fn setNextPC(thread: *mut tcb_t, v: usize) {
    setRegister(thread, NextIP, v);
}

pub fn configureIdleThread(tcb: *const tcb_t) {
    Arch_configureIdleThread(tcb);
    setThreadState(tcb as *mut tcb_t, ThreadStateIdleThreadState);
}

pub fn activateThread() {
    unsafe {
        assert!(ksCurThread != 0 && ksCurThread != 1);
        let thread = ksCurThread as *mut tcb_t;
        match thread_state_get_tsType((*thread).tcbState as *const thread_state_t) {
            ThreadStateRunning => {
                Arch_switchToThread(thread);
            }
            ThreadStateRestart => {
                let pc = getReStartPC(thread as *const tcb_t);
                setNextPC(thread, pc);
                setThreadState(thread as *mut tcb_t, ThreadStateRunning);
                Arch_switchToThread(thread);
            }
            ThreadStateIdleThreadState => return,
            _ => panic!(
                "current thread is blocked , state id :{}",
                thread_state_get_tsType((*thread).tcbState as *const thread_state_t)
            ),
        }
    }
}

#[inline]
pub fn updateReStartPC(tcb: *mut tcb_t) {
    setRegister(tcb, FaultIP, getRegister(tcb, NextIP));
}

pub fn suspend(target: *mut tcb_t) {
    //FIXME::implement cancelIPC;
    cancelIPC(target);
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
            // println!("[kernel] all applications finished! turn to shutdown");
            println!("in idle thread ,waiting for interrupt");
            // while true {
            //     asm!("wfi");
            // }
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
        lookupExtraCaps(sender, sendBuffer, &tag);
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
            msgRegister[i],
            getRegister(sender, msgRegister[i]),
        );
        i += 1;
    }
    // unsafe {
    // let msg1 = String::from_raw_parts(sendBuf as *mut u8, 32, 32);
    // println!("receive message123:{}", msg1);
    // }

    if recvBuf == 0 || sendBuf == 0 {
        return i;
    }

    // println!("recvBuf :{:#x} , sendBuf :{:#x}", recvBuf,sendBuf);
    while i < n {
        unsafe {
            let recvPtr = (recvBuf + (i - 4)) as *mut u8;
            let sendPtr = (sendBuf + (i - 4)) as *const u8;
            *recvPtr = *sendPtr;
            // println!("recvPtr :{} sendPtr:{}",*recvPtr , *sendPtr);
            i += 1;
        }
    }
    // for i in 4..n {
    //     let recvPtr = (recvBuf + (i - 4)) as *mut u8;
    //     let sendPtr = (sendBuf + (i - 4)) as *const u8;
    //     unsafe {
    //         println!("recvPtr :{} sendPtr:{}", *recvPtr, *sendPtr);
    //     }
    // }
    // unsafe {
    //     let msg = String::from_raw_parts((recvBuf) as *mut u8, 32, 32);
    //     println!("receive message1:{}", msg);
    //     forget(msg);
    //     // drop(msg);
    // }
    i
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
            // println!("excaprefs[{}]:{:#x}",i,lu_ret.slot as usize);
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
        if current_extra_caps.excaprefs[0] as usize == 0 || receivedBuffer == 0 {
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
    // println!("receiveindex:{:#x} , root :{:#x} , depth:{:#x}",ct.ctReceiveIndex,ct.ctReceiveRoot,ct.ctReceiveDepth);
    let cptr = ct.ctReceiveRoot;
    let luc_ret = lookupCap(thread, cptr);
    let cnode = luc_ret.cap;
    let lus_ret = lookupTargetSlot(cnode, ct.ctReceiveIndex, ct.ctReceiveDepth);
    lus_ret.slot
}

pub fn loadCapTransfer(buffer: usize) -> cap_transfer_t {
    let offset = seL4_MsgMaxLength + 2 + seL4_MsgMaxExtraCaps;
    // println!("sel4 buffer :{:#x}",buffer + offset *8);
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

pub fn decodeTCBInvocation(
    invLabel: usize,
    length: usize,
    cap: *const cap_t,
    slot: *const cte_t,
    call: bool,
    buffer: usize,
) -> exception_t {
    match invLabel {
        TCBReadRegisters => decodeReadRegisters(cap, length, call, buffer),
        TCBWriteRegisters => decodeWriteRegisters(cap, length, buffer),
        TCBCopyRegisters => decodeCopyRegisters(cap, length, buffer),
        TCBSuspend => unsafe {
            setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
            invokeTCB_Suspend(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)
        },
        TCBResume => unsafe {
            setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
            invokeTCB_Resume(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)
        },
        TCBConfigure => decodeTCBConfigure(cap, length, slot, buffer),
        TCBSetPriority => decodeSetPriority(cap, length, buffer),
        TCBSetMCPriority => decodeSetMCPriority(cap, length, buffer),
        TCBSetSchedParams => decodeSetSchedParams(cap, length, buffer),
        TCBSetIPCBuffer => decodeSetIPCBuffer(cap, length, slot as *mut cte_t, buffer),
        TCBSetSpace => decodeSetSpace(cap, length, slot as *mut cte_t, buffer),
        TCBBindNotification => decodeBindNotification(cap),
        TCBUnbindNotification => decodeUnbindNotification(cap),
        _ => panic!("invalid invLabel :{}", invLabel),
    }
}

pub fn decodeReadRegisters(
    cap: *const cap_t,
    length: usize,
    call: bool,
    buffer: usize,
) -> exception_t {
    if length < 2 {
        panic!("Truncated message");
    }
    let flags = getSyscallArg(0, buffer);
    let n = getSyscallArg(1, buffer);
    if n < 1 || n > n_frameRegisters + n_gpRegisters {
        panic!(
            "TCB ReadRegisters: Attempted to read an invalid number of registers:{}",
            n
        );
    }
    unsafe {
        let source_cap = (*current_extra_caps.excaprefs[0]).cap;
        if cap_get_capType(source_cap) != cap_thread_cap {
            panic!("TCB CopyRegisters: Invalid source TCB");
        }
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
        invokeTCB_ReadRegisters(
            cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
            flags & BIT!(ReadRegisters_suspend),
            n,
            0,
            call,
        )
    }
}

pub fn decodeWriteRegisters(cap: *const cap_t, length: usize, buffer: usize) -> exception_t {
    if length < 2 {
        panic!("Truncated message");
    }
    let flags = getSyscallArg(0, buffer);
    let w = getSyscallArg(1, buffer);

    if length - 2 < w {
        panic!(
            "TCB WriteRegisters: Message too short for requested write size {}/{}",
            length - 2,
            w
        );
    }
    let thread = cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t;
    unsafe {
        if thread as usize == ksCurThread {
            panic!("TCB WriteRegisters: Attempted to write our own registers.");
        }
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_WriteRegisters(thread, flags & BIT!(0), w, 0, buffer)
}

pub fn decodeCopyRegisters(cap: *const cap_t, _length: usize, buffer: usize) -> exception_t {
    let flags = getSyscallArg(0, buffer);
    let source_cap: *mut cap_t;
    unsafe {
        source_cap = (*current_extra_caps.excaprefs[0]).cap;
    }
    if cap_get_capType(cap) != cap_thread_cap {
        panic!("TCB CopyRegisters: Invalid source TCB.");
    }
    let srcTCB = cap_thread_cap_get_capTCBPtr(source_cap) as *mut tcb_t;
    return invokeTCB_CopyRegisters(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        srcTCB,
        flags & BIT!(CopyRegisters_suspendSource),
        flags & BIT!(CopyRegisters_resumeTarget),
        flags & BIT!(CopyRegisters_transferFrame),
        flags & BIT!(CopyRegisters_transferInteger),
        0,
    );
}

pub fn invokeTCB_CopyRegisters(
    dest: *mut tcb_t,
    src: *mut tcb_t,
    suspendSource: usize,
    resumeTarget: usize,
    transferFrame: usize,
    _transferInteger: usize,
    _transferArch: usize,
) -> exception_t {
    if suspendSource != 0 {
        suspend(src);
    }
    if resumeTarget != 0 {
        restart(dest);
    }
    if transferFrame != 0 {
        for i in 0..n_gpRegisters {
            let v = getRegister(src, gpRegisters[i]);
            setRegister(dest, gpRegisters[i], v);
        }
    }
    unsafe {
        if dest as usize == ksCurThread {
            rescheduleRequired();
        }
    }
    exception_t::EXCEPTION_NONE
}

pub fn invokeTCB_ReadRegisters(
    src: *mut tcb_t,
    suspendSource: usize,
    n: usize,
    _arch: usize,
    call: bool,
) -> exception_t {
    let thread: *mut tcb_t;
    unsafe {
        thread = ksCurThread as *mut tcb_t;
    }
    if suspendSource != 0 {
        suspend(src);
    }

    if call {
        let ipcBuffer = lookupIPCBuffer(true, thread);
        setRegister(thread, badgeRegister, 0);
        let mut i: usize = 0;
        while i < n && i < n_frameRegisters && i < n_msgRegisters {
            setRegister(thread, msgRegister[i], getRegister(src, frameRegisters[i]));
            i += 1;
        }
        if ipcBuffer != 0 && i < n && i < n_frameRegisters {
            while i < n && i < n_frameRegisters {
                unsafe {
                    let ptr = (ipcBuffer + (i + 1) * 8) as *mut usize;
                    *ptr = getRegister(src, frameRegisters[i]);
                }
                i += 1;
            }
        }
        let j = i;
        i = 0;
        while i < n_gpRegisters && i + n_frameRegisters < n && i + n_frameRegisters < n_msgRegisters
        {
            setRegister(
                thread,
                msgRegister[i + n_frameRegisters],
                getRegister(src, gpRegisters[i]),
            );
            i += 1;
        }
        if ipcBuffer != 0 && i < n_gpRegisters && i + n_frameRegisters < n {
            while i < n_gpRegisters && i + n_frameRegisters < n {
                let ptr = (ipcBuffer + (i + 1 + n_frameRegisters) * 8) as *mut usize;
                unsafe {
                    *ptr = getRegister(src, frameRegisters[i]);
                }
                i += 1;
            }
        }
        setRegister(
            thread,
            msgInfoRegister,
            wordFromMEssageInfo(seL4_MessageInfo_new(0, 0, 0, i + j)),
        );
    }
    setThreadState(thread, ThreadStateRunning);
    exception_t::EXCEPTION_NONE
}

pub fn invokeTCB_WriteRegisters(
    dest: *mut tcb_t,
    resumeTarget: usize,
    mut n: usize,
    _arch: usize,
    buffer: usize,
) -> exception_t {
    if n > n_frameRegisters + n_gpRegisters {
        n = n_frameRegisters + n_gpRegisters;
    }
    let mut i = 0;
    while i < n_frameRegisters && i < n {
        setRegister(
            dest,
            frameRegisters[i],
            getSyscallArg(i + n_frameRegisters + 2, buffer),
        );
        i += 1;
    }
    let pc = getReStartPC(dest);
    setNextPC(dest, pc);

    if resumeTarget != 0 {
        restart(dest);
    }
    unsafe {
        if dest as usize == ksCurThread {
            rescheduleRequired();
        }
    }
    exception_t::EXCEPTION_NONE
}

pub fn invokeTCB_Suspend(thread: *mut tcb_t) -> exception_t {
    suspend(thread);
    exception_t::EXCEPTION_NONE
}
pub fn invokeTCB_Resume(thread: *mut tcb_t) -> exception_t {
    restart(thread);
    exception_t::EXCEPTION_NONE
}

pub fn decodeSetSpace(
    cap: *const cap_t,
    length: usize,
    slot: *mut cte_t,
    buffer: usize,
) -> exception_t {
    unsafe {
        if length < 3
            || current_extra_caps.excaprefs[0] as usize == 0
            || current_extra_caps.excaprefs[0] as usize == 0
        {
            panic!("TCB SetSpace: Truncated message.");
        }
    }
    let faultEP = getSyscallArg(0, buffer);
    let cRootData = getSyscallArg(1, buffer);
    let vRootData = getSyscallArg(2, buffer);

    let cRootSlot: *const cte_t;
    let mut cRootCap: *mut cap_t;
    let vRootSlot: *const cte_t;
    let mut vRootCap: *mut cap_t;
    unsafe {
        cRootSlot = current_extra_caps.excaprefs[0];
        cRootCap = (*current_extra_caps.excaprefs[0]).cap;
        vRootSlot = current_extra_caps.excaprefs[1];
        vRootCap = (*current_extra_caps.excaprefs[1]).cap;
    }

    unsafe {
        if slotCapLongRunningDelete(
            (*(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)).rootCap[tcbCTable],
        ) || slotCapLongRunningDelete(
            (*(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)).rootCap[tcbVTable],
        ) {
            panic!("TCB Configure: CSpace or VSpace currently being deleted.");
        }
    }

    if cRootData as usize != 0 {
        cRootCap = updateCapData(false, cRootData, cRootCap) as *mut cap_t;
    }
    let dc_ret = deriveCap(cRootSlot, cRootCap);
    if dc_ret.status != exception_t::EXCEPTION_NONE {
        panic!("error occur when deriveCap");
    }
    cRootCap = dc_ret.cap as *mut cap_t;
    if cap_get_capType(cRootCap) != cap_cnode_cap {
        panic!("TCB Configure: CSpace cap is invalid.");
    }

    if vRootData as usize != 0 {
        vRootCap = updateCapData(false, cRootData, cRootCap) as *mut cap_t;
    }
    let dc_ret = deriveCap(vRootSlot, vRootCap);
    if dc_ret.status != exception_t::EXCEPTION_NONE {
        panic!("error occur when deriveCap");
    }
    vRootCap = dc_ret.cap as *mut cap_t;
    if !isValidVTableRoot(vRootCap) {
        panic!("TCB Configure: VSpace cap is invalid.");
    }

    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }

    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        slot as *mut cte_t,
        faultEP,
        0,
        0,
        cRootCap,
        cRootSlot as *mut cte_t,
        vRootCap,
        vRootSlot as *mut cte_t,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        thread_control_update_space,
    )
}

pub fn decodeTCBConfigure(
    cap: *const cap_t,
    _length: usize,
    slot: *const cte_t,
    buffer: usize,
) -> exception_t {
    let faultEP = getSyscallArg(0, buffer);
    let cRootData = getSyscallArg(1, buffer);
    let vRootData = getSyscallArg(2, buffer);
    let bufferAddr = getSyscallArg(3, buffer);
    let cRootSlot: *const cte_t;
    let mut cRootCap: *mut cap_t;
    let vRootSlot: *const cte_t;
    let mut vRootCap: *mut cap_t;
    let mut bufferSlot: *const cte_t;
    let mut bufferCap: *mut cap_t;
    unsafe {
        cRootSlot = current_extra_caps.excaprefs[0];
        cRootCap = (*current_extra_caps.excaprefs[0]).cap;
        vRootSlot = current_extra_caps.excaprefs[1];
        vRootCap = (*current_extra_caps.excaprefs[1]).cap;
        bufferSlot = current_extra_caps.excaprefs[2];
        bufferCap = (*current_extra_caps.excaprefs[2]).cap;
    }
    if bufferAddr == 0 {
        bufferSlot = 0 as *const cte_t;
    } else {
        let dc_ret = deriveCap(bufferSlot, bufferCap);
        if dc_ret.status != exception_t::EXCEPTION_NONE {
            panic!("error occur when deriveCap");
        }
        bufferCap = dc_ret.cap as *mut cap_t;
        checkValidIPCBuffer(bufferAddr, bufferCap);
    }
    unsafe {
        if slotCapLongRunningDelete(
            (*(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)).rootCap[tcbCTable],
        ) || slotCapLongRunningDelete(
            (*(cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t)).rootCap[tcbVTable],
        ) {
            panic!("TCB Configure: CSpace or VSpace currently being deleted.");
        }
    }

    if cRootData as usize != 0 {
        cRootCap = updateCapData(false, cRootData, cRootCap) as *mut cap_t;
    }
    let dc_ret = deriveCap(cRootSlot, cRootCap);
    if dc_ret.status != exception_t::EXCEPTION_NONE {
        panic!("error occur when deriveCap");
    }
    cRootCap = dc_ret.cap as *mut cap_t;
    if cap_get_capType(cRootCap) != cap_cnode_cap {
        panic!("TCB Configure: CSpace cap is invalid.");
    }

    if vRootData as usize != 0 {
        vRootCap = updateCapData(false, cRootData, cRootCap) as *mut cap_t;
    }
    let dc_ret = deriveCap(vRootSlot, vRootCap);
    if dc_ret.status != exception_t::EXCEPTION_NONE {
        panic!("error occur when deriveCap");
    }
    vRootCap = dc_ret.cap as *mut cap_t;
    if !isValidVTableRoot(vRootCap) {
        panic!("TCB Configure: VSpace cap is invalid.");
    }

    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        slot as *mut cte_t,
        faultEP,
        0,
        0,
        cRootCap,
        cRootSlot as *mut cte_t,
        vRootCap,
        vRootSlot as *mut cte_t,
        bufferAddr,
        bufferCap,
        bufferSlot as *mut cte_t,
        thread_control_update_space | thread_control_update_ipc_buffer,
    )
}

pub fn invokeTCB_ThreadControl(
    target: *mut tcb_t,
    slot: *mut cte_t,
    faultep: usize,
    mcp: usize,
    prio: usize,
    cRoot_newCap: *const cap_t,
    cRoot_srcSlot: *mut cte_t,
    vRoot_newCap: *const cap_t,
    vRoot_srcSlot: *mut cte_t,
    bufferAddr: usize,
    bufferCap: *const cap_t,
    bufferSrcSlot: *mut cte_t,
    updateFlags: usize,
) -> exception_t {
    unsafe {
        let tCap = cap_thread_cap_new(target as usize);

        if updateFlags & thread_control_update_mcp != 0 {
            setMCPriority(target, mcp);
        }
        if updateFlags & thread_control_update_space != 0 {
            (*target).tcbFaultHandler = faultep;

            let rootSlot = (*target).rootCap[tcbCTable] as *mut cte_t;
            let e = cteDelete(rootSlot, true);
            if e != exception_t::EXCEPTION_NONE {
                panic!("error occur when deleting ccap");
            }
            if sameObjectAs(cRoot_newCap, (*cRoot_srcSlot).cap) && sameObjectAs(tCap, (*slot).cap) {
                cteInsert(cRoot_newCap, cRoot_srcSlot, rootSlot);
            }

            let rootVSlot = (*target).rootCap[tcbCTable] as *mut cte_t;
            let e = cteDelete(rootVSlot, true);
            if e != exception_t::EXCEPTION_NONE {
                panic!("error occur when deleting vcap");
            }
            if sameObjectAs(vRoot_newCap, (*vRoot_srcSlot).cap) && sameObjectAs(tCap, (*slot).cap) {
                cteInsert(vRoot_newCap, vRoot_srcSlot, rootVSlot);
            }
        }

        if (updateFlags & thread_control_update_ipc_buffer) != 0 {
            let bufferSlot = (*target).rootCap[tcbBuffer];
            let e = cteDelete(bufferSlot, true);
            if e != exception_t::EXCEPTION_NONE {
                panic!("error occur when deleting buffercap");
            }
            (*target).tcbIPCBuffer = bufferAddr;
            if bufferSrcSlot as usize != 0
                && sameObjectAs(bufferCap, (*bufferSrcSlot).cap)
                && sameObjectAs(tCap, (*slot).cap)
            {
                cteInsert(bufferCap, bufferSrcSlot, bufferSlot);
            }
            if target as usize == ksCurThread {
                rescheduleRequired();
            }
        }
        if (updateFlags & thread_control_update_priority) != 0 {
            setPriority(target, prio);
        }
    }
    exception_t::EXCEPTION_NONE
}

pub fn checkPrio(prio: usize, auth: *const tcb_t) {
    unsafe {
        let mcp = (*auth).tcbMCP;
        if prio > mcp {
            panic!(
                "TCB Priority: Requested priority {}  too high (max {} ).",
                prio,
                (*auth).tcbMCP
            );
        }
    }
}

pub fn decodeSetPriority(cap: *const cap_t, length: usize, buffer: usize) -> exception_t {
    unsafe {
        if length < 1 || current_extra_caps.excaprefs[0] as usize == 0 {
            panic!("TCB SetPriority: Truncated message.");
        }
    }
    let newPrio = getSyscallArg(0, buffer);
    let authCap: *mut cap_t;
    unsafe {
        authCap = (*current_extra_caps.excaprefs[0]).cap;
    }
    if cap_get_capType(authCap) != cap_thread_cap {
        panic!("Set priority: authority cap not a TCB.");
    }
    let authTCB = cap_thread_cap_get_capTCBPtr(authCap) as *const tcb_t;
    checkPrio(newPrio, authTCB);
    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        0 as *mut cte_t,
        0,
        0,
        newPrio,
        cap_null_cap_new(),
        0 as *mut cte_t,
        cap_null_cap_new(),
        0 as *mut cte_t,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        thread_control_update_priority,
    )
}

pub fn decodeSetMCPriority(cap: *const cap_t, length: usize, buffer: usize) -> exception_t {
    unsafe {
        if length < 1 || current_extra_caps.excaprefs[0] as usize == 0 {
            panic!("TCB SetMCPPriority: Truncated message.");
        }
    }
    let newMcp = getSyscallArg(0, buffer);
    let authCap: *mut cap_t;
    unsafe {
        authCap = (*current_extra_caps.excaprefs[0]).cap;
    }
    if cap_get_capType(authCap) != cap_thread_cap {
        panic!("SetMCPriority: authority cap not a TCB.");
    }
    let authTCB = cap_thread_cap_get_capTCBPtr(authCap) as *const tcb_t;
    checkPrio(newMcp, authTCB);
    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        0 as *mut cte_t,
        0,
        newMcp,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        cap_null_cap_new(),
        0 as *mut cte_t,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        thread_control_update_mcp,
    )
}

pub fn decodeSetSchedParams(cap: *const cap_t, length: usize, buffer: usize) -> exception_t {
    unsafe {
        if length < 2 || current_extra_caps.excaprefs[0] as usize == 0 {
            panic!("TCB SetSchedParams: Truncated message.");
        }
    }
    let newMcp = getSyscallArg(0, buffer);
    let newPrio = getSyscallArg(1, buffer);
    let authCap: *mut cap_t;
    unsafe {
        authCap = (*current_extra_caps.excaprefs[0]).cap;
    }
    if cap_get_capType(authCap) != cap_thread_cap {
        panic!("SetSchedParams: authority cap not a TCB.");
    }

    let authTCB = cap_thread_cap_get_capTCBPtr(authCap) as *const tcb_t;
    checkPrio(newMcp, authTCB);
    checkPrio(newPrio, authTCB);
    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        0 as *mut cte_t,
        0,
        newMcp,
        newPrio,
        cap_null_cap_new(),
        0 as *mut cte_t,
        cap_null_cap_new(),
        0 as *mut cte_t,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        thread_control_update_mcp | thread_control_update_priority,
    )
}

pub fn decodeSetIPCBuffer(
    cap: *const cap_t,
    length: usize,
    slot: *mut cte_t,
    buffer: usize,
) -> exception_t {
    unsafe {
        if length < 1 || current_extra_caps.excaprefs[0] as usize == 0 {
            panic!("TCB SetIPCBuffer: Truncated message.");
        }
    }
    let cptr_bufferPtr = getSyscallArg(0, buffer);
    let mut bufferSlot: *mut cte_t;
    let mut bufferCap: *mut cap_t;
    unsafe {
        bufferSlot = current_extra_caps.excaprefs[0] as *mut cte_t;
        bufferCap = (*current_extra_caps.excaprefs[0]).cap;
    }
    if cptr_bufferPtr == 0 {
        bufferSlot = 0 as *mut cte_t;
    } else {
        let dc_ret = deriveCap(bufferSlot, bufferCap);
        if dc_ret.status != exception_t::EXCEPTION_NONE {
            panic!("error occur when deriving cap");
        }
        bufferCap = dc_ret.cap as *mut cap_t;
        checkValidIPCBuffer(cptr_bufferPtr, bufferCap);
    }
    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_ThreadControl(
        cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t,
        slot,
        0,
        0,
        0,
        cap_null_cap_new(),
        0 as *mut cte_t,
        cap_null_cap_new(),
        0 as *mut cte_t,
        cptr_bufferPtr,
        bufferCap,
        bufferSlot,
        thread_control_update_ipc_buffer,
    )
}

pub fn decodeBindNotification(cap: *const cap_t) -> exception_t {
    let tcb = cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t;
    let ntfnPtr: *mut notification_t;
    unsafe {
        if (*tcb).tcbBoundNotification != 0 {
            panic!("TCB BindNotification: TCB already has a bound notification.");
        }
    }
    let ntfn_cap: *mut cap_t;
    unsafe {
        ntfn_cap = (*current_extra_caps.excaprefs[0]).cap as *mut cap_t;
    }
    if cap_get_capType(ntfn_cap) == cap_notification_cap {
        ntfnPtr = cap_notification_cap_get_capNtfnPtr(ntfn_cap) as *mut notification_t;
    } else {
        panic!("TCB BindNotification: Notification is invalid.");
    }
    if cap_notification_cap_get_capNtfnCanReceive(ntfn_cap) == 0 {
        panic!("TCB BindNotification: Insufficient access rights");
    }

    if notification_ptr_get_ntfnQueue_head(ntfnPtr) != 0
        || notification_ptr_get_ntfnQueue_tail(ntfnPtr) != 0
    {
        panic!("TCB BindNotification: Notification cannot be bound.");
    }
    unsafe {
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_NotificationControl(tcb, ntfnPtr)
}

pub fn invokeTCB_NotificationControl(tcb: *mut tcb_t, ntfnPtr: *mut notification_t) -> exception_t {
    if ntfnPtr as usize != 0 {
        bindNotification(tcb, ntfnPtr);
    } else {
        unbindNotification(tcb);
    }
    exception_t::EXCEPTION_NONE
}

pub fn decodeUnbindNotification(cap: *const cap_t)->exception_t {
    let tcb = cap_thread_cap_get_capTCBPtr(cap) as *mut tcb_t;
    unsafe {
        if (*tcb).tcbBoundNotification != 0 {
            panic!("TCB BindNotification: TCB already has a bound notification.");
        }

        setThreadState(ksCurThread as *mut tcb_t, ThreadStateRestart);
    }
    invokeTCB_NotificationControl(tcb, 0 as *mut notification_t)
}
