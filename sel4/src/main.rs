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
extern crate log;

extern crate alloc;

use crate::kernel::boot::try_inital_kernel;
use crate::kernel::thread::{activateThread, schedule};
use crate::traps::restore_user_context;
use crate::{heap_alloc::init_heap, sbi::shutdown};
mod config;
mod console;
mod elfloader;
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
mod traps;
mod utils;

core::arch::global_asm!(include_str!("link_app.S"));
core::arch::global_asm!(include_str!("crt0.S"));

#[no_mangle]
pub fn rust_main() {
    println!("[kernel] Hello, world!");
    init_heap();
    try_inital_kernel();
    timer::set_next_trigger();
    schedule();
    activateThread();
    // unsafe {
    //     setVMRoot(ksCurThread as *mut tcb_t);
    // }
    restore_user_context();
    shutdown();
}
