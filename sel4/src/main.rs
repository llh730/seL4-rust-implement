#![feature(core_intrinsics)]
#![no_std]
#![no_main]
#![allow(dead_code)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(non_upper_case_globals)]
#![allow(while_true)]





use crate::sbi::shutdown;

mod console;
mod lang_items;
mod sbi;
mod kernel;
mod util;
mod config;


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
    println!("hello world!");
    shutdown();
}
