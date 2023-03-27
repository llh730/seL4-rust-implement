    .section .text.entry
    .globl _start
    .extern ekernel_stack_alloc
_start:
    la sp, ekernel_stack_alloc
    call rust_main
