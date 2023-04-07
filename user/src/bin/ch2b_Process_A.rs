#![no_std]
#![no_main]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(non_upper_case_globals)]

extern crate alloc;
use core::{arch::asm, mem::forget};

use alloc::{string::String, alloc::dealloc};
use user_lib::{init,
    messageInfoFromWord_raw, seL4_MessageInfo_ptr_get_length, seL4_MessageInfo_t, sys_recv, sys_send, seL4_MessageInfo_new, setTransferCap,
};

#[macro_use]
extern crate user_lib;
const ipc_buffer: usize = 0xc000a000;
pub fn recv() {
    let temp: usize;
    unsafe {
        asm!("mv {},a1",out(reg)temp);
    }
    let msg = messageInfoFromWord_raw(temp);
    let length = seL4_MessageInfo_ptr_get_length((&msg) as *const seL4_MessageInfo_t)-4;
    unsafe {
        let words = String::from_raw_parts(ipc_buffer as *mut u8, length, length);
        println!("[Process A] receive message: {}",words);
        forget(words);
    }
}
#[no_mangle]
fn main() -> i32 {
    println!("in process A");
    let epptr: usize = 0x802600b0;
    let dst = unsafe { core::slice::from_raw_parts_mut(ipc_buffer as *mut u8, 4096) };
    forget(dst);
    sys_recv(epptr);
    recv();
    setTransferCap(ipc_buffer, 0x80260020, 0x802600c0, 64);
    sys_recv(epptr);
    recv();
    // unsafe{
    //     core::slice::from_raw_parts_mut(ipc_buffer as *mut u8, 1<<12).fill(0);
    // }
    // unsafe {
    //     let words = String::from_raw_parts(ipc_buffer as *mut u8, 28, 28);
    //     println!("[Process A] receive message: {}",words);
    // }
    // let src = String::from("hello world from [Process A]");
    // let length = src.len() + 4;
    // let msg = seL4_MessageInfo_new(0, 0, 0, 32);
    // let dst = unsafe { core::slice::from_raw_parts_mut(ipc_buffer as *mut u8, src.len()) };
    // dst.copy_from_slice(src.into_bytes().as_slice());
    // sys_send(epptr,msg);
    0
}
