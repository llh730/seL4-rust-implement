use core::arch::asm;

use alloc::string::String;

use crate::TaskInfo;

use super::{Stat, TimeVal};

pub const SYSCALL_OPENAT: usize = 56;
pub const SYSCALL_CLOSE: usize = 57;
pub const SYSCALL_READ: usize = 63;
pub const SYSCALL_WRITE: usize = 64;
pub const SYSCALL_UNLINKAT: usize = 35;
pub const SYSCALL_LINKAT: usize = 37;
pub const SYSCALL_FSTAT: usize = 80;
pub const SYSCALL_EXIT: usize = 93;
pub const SYSCALL_SLEEP: usize = 101;
pub const SYSCALL_YIELD: usize = 124;
pub const SYSCALL_GETTIMEOFDAY: usize = 169;
pub const SYSCALL_GETPID: usize = 172;
pub const SYSCALL_GETTID: usize = 178;
pub const SYSCALL_FORK: usize = 220;
pub const SYSCALL_EXEC: usize = 221;
pub const SYSCALL_WAITPID: usize = 260;
pub const SYSCALL_SET_PRIORITY: usize = 140;
pub const SYSCALL_MUNMAP: usize = 215;
pub const SYSCALL_MMAP: usize = 222;
pub const SYSCALL_SPAWN: usize = 400;
pub const SYSCALL_MAIL_READ: usize = 401;
pub const SYSCALL_MAIL_WRITE: usize = 402;
pub const SYSCALL_DUP: usize = 24;
pub const SYSCALL_PIPE: usize = 59;
pub const SYSCALL_TASK_INFO: usize = 410;
pub const SYSCALL_THREAD_CREATE: usize = 460;
pub const SYSCALL_WAITTID: usize = 462;
pub const SYSCALL_MUTEX_CREATE: usize = 463;
pub const SYSCALL_MUTEX_LOCK: usize = 464;
pub const SYSCALL_MUTEX_UNLOCK: usize = 466;
pub const SYSCALL_SEMAPHORE_CREATE: usize = 467;
pub const SYSCALL_SEMAPHORE_UP: usize = 468;
pub const SYSCALL_ENABLE_DEADLOCK_DETECT: usize = 469;
pub const SYSCALL_SEMAPHORE_DOWN: usize = 470;
pub const SYSCALL_CONDVAR_CREATE: usize = 471;
pub const SYSCALL_CONDVAR_SIGNAL: usize = 472;
pub const SYSCALL_CONDVAR_WAIT: usize = 473;

pub const SYSCALL_SEND:usize=usize::MAX;
pub const SYSCALL_RECV:usize=usize::MAX-5;

pub fn syscall(id: usize, args: [usize; 3]) -> isize {
    let mut ret: isize;
    unsafe {
        core::arch::asm!(
            "ecall",
            inlateout("x10") args[0] => ret,
            in("x11") args[1],
            in("x12") args[2],
            in("x17") id
        );
    }
    ret
}

pub fn syscall6(id: usize, args: [usize; 6]) -> isize {
    let mut ret: isize;
    unsafe {
        core::arch::asm!("ecall",
            inlateout("x10") args[0] => ret,
            in("x11") args[1],
            in("x12") args[2],
            in("x13") args[3],
            in("x14") args[4],
            in("x15") args[5],
            in("x17") id
        );
    }
    ret
}

pub fn sys_openat(dirfd: usize, path: &str, flags: u32, mode: u32) -> isize {
    syscall6(
        SYSCALL_OPENAT,
        [
            dirfd,
            path.as_ptr() as usize,
            flags as usize,
            mode as usize,
            0,
            0,
        ],
    )
}

pub fn sys_close(fd: usize) -> isize {
    syscall(SYSCALL_CLOSE, [fd, 0, 0])
}

pub fn sys_read(fd: usize, buffer: &mut [u8]) -> isize {
    syscall(
        SYSCALL_READ,
        [fd, buffer.as_mut_ptr() as usize, buffer.len()],
    )
}

pub fn sys_write(fd: usize, buffer: &[u8]) -> isize {
    syscall(SYSCALL_WRITE, [fd, buffer.as_ptr() as usize, buffer.len()])
}

pub fn sys_linkat(
    old_dirfd: usize,
    old_path: &str,
    new_dirfd: usize,
    new_path: &str,
    flags: usize,
) -> isize {
    syscall6(
        SYSCALL_LINKAT,
        [
            old_dirfd,
            old_path.as_ptr() as usize,
            new_dirfd,
            new_path.as_ptr() as usize,
            flags,
            0,
        ],
    )
}

pub fn sys_unlinkat(dirfd: usize, path: &str, flags: usize) -> isize {
    syscall(SYSCALL_UNLINKAT, [dirfd, path.as_ptr() as usize, flags])
}

pub fn sys_fstat(fd: usize, st: &Stat) -> isize {
    syscall(SYSCALL_FSTAT, [fd, st as *const _ as usize, 0])
}

pub fn sys_mail_read(buffer: &mut [u8]) -> isize {
    syscall(
        SYSCALL_MAIL_READ,
        [buffer.as_ptr() as usize, buffer.len(), 0],
    )
}

pub fn sys_mail_write(pid: usize, buffer: &[u8]) -> isize {
    syscall(
        SYSCALL_MAIL_WRITE,
        [pid, buffer.as_ptr() as usize, buffer.len()],
    )
}

pub fn sys_exit(exit_code: i32) -> ! {
    syscall(SYSCALL_EXIT, [exit_code as usize, 0, 0]);
    panic!("sys_exit never returns!");
}

pub fn sys_sleep(sleep_ms: usize) -> isize {
    syscall(SYSCALL_SLEEP, [sleep_ms, 0, 0])
}

pub fn sys_yield() -> isize {
    syscall(SYSCALL_YIELD, [0, 0, 0])
}

pub fn sys_get_time(time: &TimeVal, tz: usize) -> isize {
    syscall(SYSCALL_GETTIMEOFDAY, [time as *const _ as usize, tz, 0])
}

pub fn sys_getpid() -> isize {
    syscall(SYSCALL_GETPID, [0, 0, 0])
}

pub fn sys_fork() -> isize {
    syscall(SYSCALL_FORK, [0, 0, 0])
}

pub fn sys_exec(path: &str, args: &[*const u8]) -> isize {
    syscall(
        SYSCALL_EXEC,
        [path.as_ptr() as usize, args.as_ptr() as usize, 0],
    )
}

pub fn sys_waitpid(pid: isize, xstatus: *mut i32) -> isize {
    syscall(SYSCALL_WAITPID, [pid as usize, xstatus as usize, 0])
}

pub fn sys_set_priority(prio: isize) -> isize {
    syscall(SYSCALL_SET_PRIORITY, [prio as usize, 0, 0])
}

pub fn sys_mmap(start: usize, len: usize, prot: usize) -> isize {
    syscall(SYSCALL_MMAP, [start, len, prot])
}

pub fn sys_munmap(start: usize, len: usize) -> isize {
    syscall(SYSCALL_MUNMAP, [start, len, 0])
}

pub fn sys_spawn(path: &str) -> isize {
    syscall(SYSCALL_SPAWN, [path.as_ptr() as usize, 0, 0])
}

pub fn sys_dup(fd: usize) -> isize {
    syscall(SYSCALL_DUP, [fd, 0, 0])
}

pub fn sys_pipe(pipe: &mut [usize]) -> isize {
    syscall(SYSCALL_PIPE, [pipe.as_mut_ptr() as usize, 0, 0])
}

pub fn sys_task_info(info: &TaskInfo) -> isize {
    syscall(SYSCALL_TASK_INFO, [info as *const _ as usize, 0, 0])
}

pub fn sys_thread_create(entry: usize, arg: usize) -> isize {
    syscall(SYSCALL_THREAD_CREATE, [entry, arg, 0])
}

pub fn sys_gettid() -> isize {
    syscall(SYSCALL_GETTID, [0; 3])
}

pub fn sys_waittid(tid: usize) -> isize {
    syscall(SYSCALL_WAITTID, [tid, 0, 0])
}

pub fn sys_mutex_create(blocking: bool) -> isize {
    syscall(SYSCALL_MUTEX_CREATE, [blocking as usize, 0, 0])
}

pub fn sys_mutex_lock(id: usize) -> isize {
    syscall(SYSCALL_MUTEX_LOCK, [id, 0, 0])
}

pub fn sys_mutex_unlock(id: usize) -> isize {
    syscall(SYSCALL_MUTEX_UNLOCK, [id, 0, 0])
}

pub fn sys_semaphore_create(res_count: usize) -> isize {
    syscall(SYSCALL_SEMAPHORE_CREATE, [res_count, 0, 0])
}

pub fn sys_semaphore_up(sem_id: usize) -> isize {
    syscall(SYSCALL_SEMAPHORE_UP, [sem_id, 0, 0])
}

pub fn sys_enable_deadlock_detect(enabled: usize) -> isize {
    syscall(SYSCALL_ENABLE_DEADLOCK_DETECT, [enabled, 0, 0])
}

pub fn sys_semaphore_down(sem_id: usize) -> isize {
    syscall(SYSCALL_SEMAPHORE_DOWN, [sem_id, 0, 0])
}

pub fn sys_condvar_create(_arg: usize) -> isize {
    syscall(SYSCALL_CONDVAR_CREATE, [_arg, 0, 0])
}

pub fn sys_condvar_signal(condvar_id: usize) -> isize {
    syscall(SYSCALL_CONDVAR_SIGNAL, [condvar_id, 0, 0])
}

pub fn sys_condvar_wait(condvar_id: usize, mutex_id: usize) -> isize {
    syscall(SYSCALL_CONDVAR_WAIT, [condvar_id, mutex_id, 0])
}

pub fn sys_send(ep:usize,msg:&seL4_MessageInfo_t)->isize{
    syscall(SYSCALL_SEND,[ep,msg.words[0],0])
}

pub fn sys_recv(ep:usize)->isize{
    syscall(SYSCALL_RECV,[ep,0,0])
}



const seL4_MsgMaxLength:usize=120;
const seL4_MsgMaxExtraCaps:usize=3;

pub fn setExtraCptr(bufferPtr:usize,i:usize,CPtr:usize){
    unsafe{
        *((bufferPtr + (seL4_MsgMaxLength + 2 + i) * 8) as *mut usize)=CPtr;
    }
}

pub fn setTransferCap(buffer:usize,root:usize,index:usize,depth:usize){
    let offset = seL4_MsgMaxLength + 2 + seL4_MsgMaxExtraCaps;
    unsafe{
        *((buffer+offset*8) as *mut usize )=root;
        *((buffer+offset*8+8) as *mut usize )=index;
        *((buffer+offset*8+16) as *mut usize )=depth;
    }
}


pub struct seL4_MessageInfo_t {
    pub words: [usize; 1],
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_length(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = (*ptr).words[0] & 0x7fusize;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_length(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x7fusize;
        (*ptr).words[0] |= v64 & 0x7f;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_extraCaps(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0x180usize) >> 7;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_extraCaps(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x180usize;
        (*ptr).words[0] |= (v64 << 7) & 0x180;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_capsUnwrapped(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0xe00usize) >> 9;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_capsUnwrapped(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0xe00usize;
        (*ptr).words[0] |= (v64 << 9) & 0xe00;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_label(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0xfffffffffffff000usize) >> 12;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_label(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0xfffffffffffff000usize;
        (*ptr).words[0] |= (v64 << 12) & 0xfffffffffffff000;
    }
}

#[inline]
pub fn seL4_MessageInfo_new(
    label: usize,
    capsUnwrapped: usize,
    extraCaps: usize,
    length: usize,
) -> seL4_MessageInfo_t {
    let seL4_MessageInfo = seL4_MessageInfo_t {
        words: [0
            | (label & 0xfffffffffffffusize) << 12
            | (capsUnwrapped & 0x7usize) << 9
            | (extraCaps & 0x3usize) << 7
            | (length & 0x7fusize) << 0],
    };

    seL4_MessageInfo
}


pub fn messageInfoFromWord_raw(w: usize) -> seL4_MessageInfo_t {
    let mi = seL4_MessageInfo_t { words: [w] };
    mi
}