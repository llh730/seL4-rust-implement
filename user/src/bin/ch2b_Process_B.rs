#![no_std]
#![no_main]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(non_upper_case_globals)]

extern crate alloc;
use core::{arch::asm, mem::forget};

use alloc::string::String;
use user_lib::{
    init, messageInfoFromWord_raw, seL4_MessageInfo_new, seL4_MessageInfo_ptr_get_length,
    seL4_MessageInfo_ptr_set_extraCaps, seL4_MessageInfo_t, setExtraCptr, sys_recv, sys_send,
};

#[macro_use]
extern crate user_lib;

const ipc_buffer: usize = 0xc002a000;

pub fn recv() {
    let temp: usize;
    unsafe {
        asm!("mv {},a1",out(reg)temp);
    }
    let msg = messageInfoFromWord_raw(temp);
    let length = seL4_MessageInfo_ptr_get_length((&msg) as *const seL4_MessageInfo_t) - 4;
    unsafe {
        let msg = String::from_raw_parts(ipc_buffer as *mut u8, length, length);
        println!("[Process B] receive message: {}", msg);
    }
}
#[no_mangle]
fn main() -> i32 {
    println!("in process B");
    let epptr_to_A: usize = 0x80a000b0;
    let epptr_to_C: usize = 0x80a000c0;
    let src = String::from("hello world from [Process B]");
    let length = src.len() + 4;
    let msg_to_A = seL4_MessageInfo_new(0, 0, 0, length);
    let msg_to_C = seL4_MessageInfo_new(0, 0, 0, length);
    let dst = unsafe { core::slice::from_raw_parts_mut(ipc_buffer as *mut u8, src.len()) };
    dst.copy_from_slice(src.into_bytes().as_slice());
    forget(dst);
    sys_send(epptr_to_A, msg_to_A);
    sys_send(epptr_to_C, msg_to_C);
    
    let msg_pass_capability = seL4_MessageInfo_new(0, 0, 1, 0);
    setExtraCptr(ipc_buffer, 0, epptr_to_C);
    sys_send(epptr_to_A,msg_pass_capability);
    0
}
