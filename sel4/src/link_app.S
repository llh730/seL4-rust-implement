
    .align 3
    .section .data
    .global _num_app
_num_app:
    .quad 1
    .quad app_0_start
    .quad app_0_end

    .section .data
    .global app_0_start
    .global app_0_end
    .align 12
app_0_start:
    .incbin "../user/build/elf/ch3b_sleep.elf"
    .space 4096*4
app_0_end:
