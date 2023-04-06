use crate::config::{msgInfoRegister, n_msgRegisters, SchedulerAction_ChooseNewThread};
use crate::kernel::object::cspace::{lookupCap, lookupCapAndSlot};
use crate::kernel::object::endpoint::receiveIPC;
use crate::kernel::object::msg::{
    seL4_MessageInfo_ptr_get_label, seL4_MessageInfo_ptr_get_length, seL4_MessageInfo_t,
};
use crate::kernel::object::objecttype::{cap_endpoint_cap, decodeInvocation};
use crate::kernel::object::structures::cap_get_capType;
use crate::kernel::thread::{
    activateThread, capRegister, getMsgRegisterNumber, getRegister, ksCurThread, ksSchedulerAction,
    lookupExtraCaps, messageInfoFromWord, rescheduleRequired, schedule, setThreadState,
    tcbSchedDequeue, tcbSchedEnqueue, tcb_t, ThreadStateExited,
};
use crate::kernel::vspace::lookupIPCBuffer;
use crate::println;
use crate::timer::get_time_us;
use crate::traps::restore_user_context;

#[repr(C)]
#[derive(Debug)]
pub struct TimeVal {
    pub sec: usize,
    pub usec: usize,
}

// pub struct TaskInfo {
//     status: TaskStatus,
//     syscall_times: [u32; MAX_SYSCALL_NUM],
//     time: usize
// }

// struct SyscallInfo {
//     id: usize,
//     times: usize
// }

// pub struct TaskInfo {
//     id: usize,
//     status: TaskStatus,
//     call: [SyscallInfo; MAX_SYSCALL_NUM],
//     time: usize
// }

pub fn sys_exit(exit_code: i32) -> isize {
    println!("[kernel] Application exited with code {}", exit_code);
    unsafe {
        tcbSchedDequeue(ksCurThread as *const tcb_t);
        ksSchedulerAction = SchedulerAction_ChooseNewThread;
        setThreadState(ksCurThread as *mut tcb_t, ThreadStateExited);
    }
    rescheduleRequired();
    schedule();
    activateThread();
    restore_user_context();
    0
}

pub fn sys_yield() -> isize {
    info!("[kernel] Application yield");
    unsafe {
        tcbSchedEnqueue(ksCurThread as *mut tcb_t);
    }
    rescheduleRequired();
    schedule();
    activateThread();
    0
}

pub fn sys_get_time(ts: *mut TimeVal, _tz: usize) -> isize {
    let us = get_time_us();
    unsafe {
        *ts = TimeVal {
            sec: us / 1_000_000,
            usec: us % 1_000_000,
        };
    }
    0
}

pub fn sys_send() -> isize {
    handleInvocation(false, true);
    rescheduleRequired();
    schedule();
    activateThread();
    0
}

pub fn sys_recv() -> isize {
    handleRecv(true);
    rescheduleRequired();
    schedule();
    activateThread();
    0
}

pub fn handleInvocation(isCall: bool, isBlocking: bool) -> isize {
    let thread: *const tcb_t;
    unsafe {
        thread = ksCurThread as *const tcb_t;
    }
    let info = messageInfoFromWord(getRegister(thread, msgInfoRegister));
    let cptr = getRegister(thread, capRegister);

    let lu_ret = lookupCapAndSlot(thread, cptr);

    let buffer = lookupIPCBuffer(false, thread as *mut tcb_t);
    let mut status = lookupExtraCaps(thread as *mut tcb_t, buffer, &info);

    let mut length = seL4_MessageInfo_ptr_get_length((&info) as *const seL4_MessageInfo_t);
    if length > n_msgRegisters && buffer == 0 {
        length = n_msgRegisters;
    }
    status = decodeInvocation(
        seL4_MessageInfo_ptr_get_label((&info) as *const seL4_MessageInfo_t),
        length,
        cptr,
        lu_ret.slot,
        lu_ret.cap,
        isBlocking,
        isCall,
        buffer,
    );
    0
}

pub fn handleRecv(isBlocking: bool) -> isize {
    unsafe {
        let epCPtr = getRegister(ksCurThread as *const tcb_t, capRegister);
        let lu_ret = lookupCap(ksCurThread as *const tcb_t, epCPtr);
        match cap_get_capType(lu_ret.cap) {
            cap_endpoint_cap => {
                receiveIPC(ksCurThread as *mut tcb_t, lu_ret.cap, isBlocking);
            }
            _ => panic!("unknown cap:{}", cap_get_capType(lu_ret.cap)),
        }
    }
    0
}

#[inline]
pub fn getSyscallArg(i: usize, ipc_buffer: usize) -> usize {
    unsafe {
        if i < n_msgRegisters {
            return getRegister(ksCurThread as *const tcb_t, getMsgRegisterNumber(i));
        } else {
            let ptr = (ipc_buffer + i + 1) as *const usize;
            assert!(ipc_buffer != 0);
            return *ptr;
        }
    }
}
