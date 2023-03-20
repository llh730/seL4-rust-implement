#![feature(core_intrinsics)]
#![no_std]
#![no_main]
#![allow(dead_code)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(non_upper_case_globals)]
#![allow(while_true)]
#![feature(alloc_error_handler)]
#![feature(panic_info_message)]
#![feature(stdsimd)]


#[macro_use]
extern crate bitflags;
#[macro_use]
extern crate log;

extern crate alloc;



use core::arch::asm;
use core::arch::riscv64::sfence_vma_all;

use riscv::register::{satp, sstatus, sepc};

use crate::kernel::vspace::{write_satp, read_satp, map_kernel_window, pt_init};
use crate::tasks::run_first_task;
use crate::{sbi::shutdown, kernel::object::structures::cap_t};
use crate::test::cspace_test::test_cspace;
mod heap_alloc;
mod sync;
mod console;
mod lang_items;
mod sbi;
mod kernel;
mod utils;
mod config;
mod test;
mod tasks;
mod trap;
mod timer;
mod loader;
mod syscall;

core::arch::global_asm!(include_str!("link_app.S"));
core::arch::global_asm!(include_str!("crt0.S"));

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    unsafe {
        core::slice::from_raw_parts_mut(sbss as usize as *mut u8, ebss as usize - sbss as usize)
            .fill(0);
    }
}




#[no_mangle]
pub fn rust_main() {
    clear_bss();
    println!("[kernel] Hello, world!");
    pt_init();
    shutdown();
}

#[no_mangle]
pub fn jump_to_virtual_address(){
    println!("jump to virtual address");
    unsafe{
        sfence_vma_all();
    }
}
