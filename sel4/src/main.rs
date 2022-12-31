#![no_std]
#![no_main]

use elfloader::boot::{sfence_vma, abort};

use crate::util::sbi::shutdown;


#[macro_use]
mod elfloader;

mod util;

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) }
    });
}


const SYSCALL_EXIT: usize = 93;

fn syscall(id: usize, args: [usize; 3]) -> isize {
    let mut ret;
    unsafe {
        core::arch::asm!(
            "ecall",
            inlateout("x10") args[0] => ret,
            in("x11") args[1],
            in("x12") args[2],
            in("x17") id,
        );
    }
    ret
}

pub fn sys_exit(xstate: i32) -> isize {
    syscall(SYSCALL_EXIT, [xstate as usize, 0, 0])
}


core::arch::global_asm!(include_str!("crt0.S"));

// extern "C" {
//     hsm_exists:i32=0;
// }

#[no_mangle]
pub fn rust_main()->! {
    println!("hello world!");
    // clear_bss();
    // sfence_vma();
    shutdown();
}
