
    .align 3
    .section .data
    .global _num_app
_num_app:
    .quad 3
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_2_end

    .section .data
    .global app_0_start
    .global app_0_end
    .align 12
app_0_start:
    .incbin "../user/build/elf/ch2b_Process_A.elf"
    .space 4096*8
app_0_end:

    .section .data
    .global app_1_start
    .global app_1_end
    .align 12
app_1_start:
    .incbin "../user/build/elf/ch2b_Process_B.elf"
    .space 4096*8
app_1_end:

    .section .data
    .global app_2_start
    .global app_2_end
    .align 12
app_2_start:
    .incbin "../user/build/elf/ch2b_Process_C.elf"
    .space 4096*8
app_2_end:
