#![no_std]
#![no_main]

use user_lib::sys_recv;

#[macro_use]
extern crate user_lib;

#[no_mangle]
fn main() -> i32 {
    sleep(10);
    println!("in sys_recv");
    // sys_recv();
    0
}
