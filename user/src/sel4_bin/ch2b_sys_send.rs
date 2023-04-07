#![no_std]
#![no_main]

use user_lib::sys_send;

#[macro_use]
extern crate user_lib;

#[no_mangle]
fn main() -> i32 {
    println!("in sys_send");
    // sys_send();
    0
}
