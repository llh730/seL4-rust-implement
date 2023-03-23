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

use core::alloc::Layout;
use core::arch::asm;
use core::arch::riscv64::sfence_vma_all;
use core::borrow::Borrow;
use core::cell::RefCell;
use core::mem;

use riscv::register::{satp, sepc, sstatus};

use crate::heap_alloc::init_heap;
use crate::kernel::thread::idle_thread;
use crate::kernel::vspace::{map_kernel_window, pt_init, read_satp, write_satp};
use crate::tasks::run_first_task;
use crate::{kernel::object::structures::cap_t, sbi::shutdown};
mod config;
mod console;
mod heap_alloc;
mod kernel;
mod lang_items;
mod loader;
mod sbi;
mod sync;
mod syscall;
mod tasks;
mod timer;
mod trap;
mod utils;


core::arch::global_asm!(include_str!("crt0.S"));

#[no_mangle]
#[link_section = ".text"]
pub fn rust_main() {
    println!("[kernel] Hello, world!");
    init_heap();
    pt_init();

    shutdown();
}

