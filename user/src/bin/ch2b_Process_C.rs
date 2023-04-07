#![no_std]
#![no_main]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(non_upper_case_globals)]

extern crate alloc;
use core::arch::asm;

use alloc::string::String;
use user_lib::{
    messageInfoFromWord_raw, seL4_MessageInfo_ptr_get_length, seL4_MessageInfo_t, sys_recv,
};

#[macro_use]
extern crate user_lib;
const ipc_buffer: usize = 0xc004a000;
pub fn recv() {
    let temp: usize;
    unsafe {
        asm!("mv {},a1",out(reg)temp);
    }
    let msg = messageInfoFromWord_raw(temp);
    let length = seL4_MessageInfo_ptr_get_length((&msg) as *const seL4_MessageInfo_t) - 4;
    unsafe {
        let msg = String::from_raw_parts(ipc_buffer as *mut u8, length, length);
        println!("[Process C] receive message: {}",msg);
    }
}
#[no_mangle]
fn main() -> i32 {
    let epptr: usize = 0x80a200c0;
    println!("in process C");
    sys_recv(epptr);
    recv();
    0
}
