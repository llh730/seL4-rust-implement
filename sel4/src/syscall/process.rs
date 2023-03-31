use crate::elfloader::{run_next_task, mark_current_suspended, mark_current_exited};
use crate::sbi::shutdown;
use crate::tasks::{exit_current_and_run_next, suspend_current_and_run_next};
// use crate::tasks::{exit_current_and_run_next, suspend_current_and_run_next};
// use crate::tasks::{exit_current_and_run_next, suspend_current_and_run_next, TaskStatus};
use crate::timer::get_time_us;

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





pub fn sys_exit(exit_code: i32) -> ! {
    info!("[kernel] Application exited with code {}", exit_code);
    // exit_current_and_run_next();
    // mark_current_exited();
    // run_next_task();
    shutdown();
    panic!("Unreachable in sys_exit!");
}

pub fn sys_yield() -> isize {
    info!("[kernel] Application yield");
    // suspend_current_and_run_next();
    // mark_current_suspended();
    // run_next_task();
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

