#![allow(warnings)]
extern crate cc;
use std::env;
fn main() { 
    cc::Build::new()
    .compiler("riscv64-unknown-elf-gcc")
    .flag("-w")
    .file("src/elfloader/common.c")
    .file("src/elfloader/boot.c")
    .file("src/crt0.S")
    .compile("sel4_build")
    ;
}