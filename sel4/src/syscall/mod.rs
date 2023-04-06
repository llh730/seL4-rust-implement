const SYSCALL_WRITE: usize = 64;
const SYSCALL_EXIT: usize = 93;
const SYSCALL_YIELD: usize = 124;
const SYSCALL_GET_TIME: usize = 169;
const SYSCALL_TASK_INFO: usize = 410;
const SYSCALL_SEND: usize = usize::MAX;
const SYSCALL_RECV: usize = usize::MAX - 5;

pub mod fs;
pub mod process;


use fs::*;
use process::*;


pub fn syscall(syscall_id: usize, args: [usize; 3]) -> isize {
    // record_syscall_times(syscall_id);
    // println!("syscall id:{:#x}",syscall_id);
    match syscall_id {
        SYSCALL_WRITE => sys_write(args[0], args[1] as *const u8, args[2]),
        SYSCALL_EXIT => sys_exit(args[0] as i32),
        SYSCALL_YIELD => sys_yield(),
        SYSCALL_GET_TIME => sys_get_time(args[0] as *mut TimeVal, args[1]),
        SYSCALL_SEND => sys_send(),
        SYSCALL_RECV=>sys_recv(),
        _ => panic!("Unsupported syscall_id: {:#x}", syscall_id),
    }
}
