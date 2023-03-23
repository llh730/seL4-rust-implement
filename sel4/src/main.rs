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

use alloc::rc::Rc;
use riscv::register::{satp, sepc, sstatus};

use crate::heap_alloc::init_heap;
use crate::kernel::thread::idle_thread;
use crate::kernel::vspace::{map_kernel_window, pt_init, read_satp, write_satp};
use crate::tasks::run_first_task;
use crate::test::cspace_test::test_cspace;
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
mod test;
mod timer;
mod trap;
mod utils;

// core::arch::global_asm!(include_str!("link_app.S"));

// fn clear_bss() {
//     extern "C" {
//         fn sbss();
//         fn ebss();
//     }
//     unsafe {
//         core::slice::from_raw_parts_mut(sbss as usize as *mut u8, ebss as usize - sbss as usize)
//             .fill(0);
//     }
// }

core::arch::global_asm!(include_str!("crt0.S"));

#[no_mangle]
#[link_section = ".text"]
pub fn rust_main() {
    // clear_bss();
    println!("[kernel] Hello, world!");
    init_heap();
    pt_init();
    unsafe {
        let cap=Rc::from_raw(get() as *const RefCell<cap_t>);
        println!("{} {}",cap.borrow_mut().words[0],cap.borrow_mut().words[1]);
        // let c = cap_t { words: [1, 2] };
        // let size = mem::size_of::<Rc<RefCell<cap_t>>>();
        // let layout = Layout::from_size_align(size, 8).ok().unwrap();
        // let ptr: *mut u8;
        // let cap2 = Rc::new(RefCell::new(c));
        // ptr = alloc::alloc::alloc(layout);
        // let ptr1 = ptr as *mut Rc<RefCell<cap_t>>;
        // *ptr1 = cap2;
        // // let cap1 = *ptr1;
        // // let cap = cap1.borrow_mut();
        // println!("{} {}", (*ptr1).borrow_mut().words[0], (*ptr1).borrow_mut().words[1]);
    }

    shutdown();
}

pub fn get() -> usize {
    unsafe {
        let c = cap_t { words: [1, 2] };
        let size = mem::size_of::<Rc<RefCell<cap_t>>>();
        let layout = Layout::from_size_align(size, 8).ok().unwrap();
        let ptr: *mut u8;
        let cap2 = Rc::new(RefCell::new(c));
        ptr = alloc::alloc::alloc(layout);
        let cap_ptr = ptr as *mut Rc<RefCell<cap_t>>;
        *cap_ptr = cap2;
        (*cap_ptr).as_ptr() as usize
    }
}
