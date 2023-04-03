use crate::config::{msgInfoRegister, SchedulerAction_ChooseNewThread};
use crate::kernel::object::cspace::{lookupCap, lookupCapAndSlot};
use crate::kernel::object::endpoint::{performInvocation_Endpoint, receiveIPC};
use crate::kernel::object::msg::{
    seL4_MessageInfo_ptr_get_label, seL4_MessageInfo_ptr_get_length, seL4_MessageInfo_t,
};
use crate::kernel::object::objecttype::cap_endpoint_cap;
use crate::kernel::object::structures::{
    cap_endpoint_cap_get_capCanGrant, cap_endpoint_cap_get_capCanGrantReply,
    cap_endpoint_cap_get_capEPBadge, cap_endpoint_cap_get_capEPPtr, cap_get_capType, cap_t, cte_t,
    endpoint_t, exception_t,
};
use crate::kernel::thread::{
    activateThread, capRegister, getRegister, ksCurThread, ksSchedulerAction, lookupExtraCaps,
    messageInfoFromWord, rescheduleRequired, schedule, setThreadState, tcbSchedDequeue,
    tcbSchedEnqueue, tcb_t, ThreadStateExited, ThreadStateRestart,
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
        setThreadState(ksCurThread as *const tcb_t, ThreadStateExited);
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
        // tcbSchedDequeue(ksCurThread as *const tcb_t);
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
    unsafe {
        let thread = ksCurThread as *const tcb_t;
        let info = messageInfoFromWord(getRegister(thread, msgInfoRegister));
        let cptr = getRegister(thread, capRegister);

        let lu_ret = lookupCapAndSlot(thread, cptr);

        let buffer = lookupIPCBuffer(false, thread as *mut tcb_t);
        let mut status = lookupExtraCaps(thread as *mut tcb_t, buffer, &info);

        let length = seL4_MessageInfo_ptr_get_length((&info) as *const seL4_MessageInfo_t);

        status = decodeInvocation(
            seL4_MessageInfo_ptr_get_label((&info) as *const seL4_MessageInfo_t),
            length,
            cptr,
            lu_ret.slot,
            lu_ret.cap,
            true,
            false,
            buffer,
        );
    }
    0
}

pub fn decodeInvocation(
    invLabel: usize,
    length: usize,
    capIndex: usize,
    slot: *const cte_t,
    cap: *const cap_t,
    block: bool,
    call: bool,
    buffer: usize,
) -> exception_t {
    match cap_get_capType(cap) {
        cap_endpoint_cap => unsafe {
            setThreadState(ksCurThread as *const tcb_t, ThreadStateRestart);
            let canGrant = if cap_endpoint_cap_get_capCanGrant(cap) != 0 {
                true
            } else {
                false
            };
            let canGrantReply = if cap_endpoint_cap_get_capCanGrantReply(cap) != 0 {
                true
            } else {
                false
            };
            performInvocation_Endpoint(
                cap_endpoint_cap_get_capEPPtr(cap) as *const endpoint_t,
                cap_endpoint_cap_get_capEPBadge(cap),
                canGrant,
                canGrantReply,
                block,
                call,
            )
        },
        _ => panic!("Invalid cap :{}", cap_get_capType(cap)),
    }
}

pub fn handleRecv(isBlocking: bool) {
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
}
