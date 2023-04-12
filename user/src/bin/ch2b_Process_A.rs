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
    seL4_MessageInfo_t, setTransferCap, sys_recv, sys_send,
};

#[macro_use]
extern crate user_lib;
const ipc_buffer: usize = 0xc000a000;
pub fn decode() {
    let temp: usize;
    unsafe {
        asm!("mv {},a1",out(reg)temp);
    }
    let msg = messageInfoFromWord_raw(temp);
    let length = seL4_MessageInfo_ptr_get_length((&msg) as *const seL4_MessageInfo_t) - 4;
    unsafe {
        let words = String::from_raw_parts(ipc_buffer as *mut u8, length, length);
        println!("[Process A] receive message: {}", words);
        forget(words);
    }
}
const epptr: usize = 0x80a000b0;
const epptr_to_C: usize = 0x80a000c0;
pub fn send_to_C(){
    println!("[Process A] try to send message to Process C");
    let src = String::from("hello world from [Process A]");
    let length = src.len() + 4;
    let msg_to_C = seL4_MessageInfo_new(0, 0, 0, length);
    let dst = unsafe { core::slice::from_raw_parts_mut(ipc_buffer as *mut u8, src.len()) };
    dst.copy_from_slice(src.into_bytes().as_slice());
    forget(dst);
    sys_send(epptr_to_C,&msg_to_C);
}
#[no_mangle]
fn main() -> i32 {
    println!("in process A");
    
    send_to_C();

    sys_recv(epptr);
    decode();
    
    setTransferCap(ipc_buffer, 0x80a00020, epptr_to_C, 64);
    sys_recv(epptr);
    
    send_to_C();

    0
}
