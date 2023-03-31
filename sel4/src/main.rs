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
// use crate::tasks::run_first_task;
use crate::elfloader::{create_thread_for_tasks, run_first_task, USER_STACK};
// use crate::elfloader::{KERNEL_STACK, create_thread_for_tasks, run_first_task};
use crate::kernel::boot::{create_root_cnode, try_inital_kernel};
use crate::kernel::object::structures::cap_t;
use crate::kernel::object::structures::pte_ptr_get_ppn;
use crate::kernel::thread::{
    activateThread, idle_thread, ksCurThread, schedule, setRegister, tcb_t,
};
use crate::kernel::vspace::{
    activate_kernel_vspace, lookupPTSlot, map_kernel_window, read_satp, setVMRoot, write_satp,
    RISCV_GET_PT_INDEX,
};
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
// core::arch::global_asm!(include_str!("link_apps.S"));

#[no_mangle]
pub fn rust_main() {
    println!("[kernel] Hello, world!");
    init_heap();
    try_inital_kernel();
    timer::set_next_trigger();
    schedule();
    activateThread();
    unsafe {
        setVMRoot(ksCurThread as *mut tcb_t);
    }
    restore_user_context();
    shutdown();
}
