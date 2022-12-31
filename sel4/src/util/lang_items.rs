//! The panic handler

use crate::println;

use core::panic::PanicInfo;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("Sel4 paniced!");
    loop {}
}
