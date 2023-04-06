
    .align 3
    .section .data
    .global _num_app
_num_app:
    .quad 2
    .quad app_0_start
    .quad app_1_start
    .quad app_1_end

    .section .data
    .global app_0_start
    .global app_0_end
    .align 12
app_0_start:
    .incbin "../user/build/elf/ch2b_sys_recv.elf"
    .space 4096*4
app_0_end:

    .section .data
    .global app_1_start
    .global app_1_end
    .align 12
app_1_start:
    .incbin "../user/build/elf/ch2b_sys_send.elf"
    .space 4096*4
app_1_end:
