
    .align 3
    .section .data
    .global _num_app
_num_app:
    .quad 10
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_3_start
    .quad app_4_start
    .quad app_5_start
    .quad app_6_start
    .quad app_7_start
    .quad app_8_start
    .quad app_9_start
    .quad app_9_end

    .section .data
    .global app_0_start
    .global app_0_end
    .align 12
app_0_start:
    .incbin "../user/build/elf/ch2b_hello_world.elf"
    .space 4096*4
app_0_end:

    .section .data
    .global app_1_start
    .global app_1_end
    .align 12
app_1_start:
    .incbin "../user/build/elf/ch2b_power_3.elf"
    .space 4096*4
app_1_end:

    .section .data
    .global app_2_start
    .global app_2_end
    .align 12
app_2_start:
    .incbin "../user/build/elf/ch2b_power_5.elf"
    .space 4096*4
app_2_end:

    .section .data
    .global app_3_start
    .global app_3_end
    .align 12
app_3_start:
    .incbin "../user/build/elf/ch2b_power_7.elf"
    .space 4096*4
app_3_end:

    .section .data
    .global app_4_start
    .global app_4_end
    .align 12
app_4_start:
    .incbin "../user/build/elf/ch2b_sys_send.elf"
    .space 4096*4
app_4_end:

    .section .data
    .global app_5_start
    .global app_5_end
    .align 12
app_5_start:
    .incbin "../user/build/elf/ch3b_sleep.elf"
    .space 4096*4
app_5_end:

    .section .data
    .global app_6_start
    .global app_6_end
    .align 12
app_6_start:
    .incbin "../user/build/elf/ch3b_sleep1.elf"
    .space 4096*4
app_6_end:

    .section .data
    .global app_7_start
    .global app_7_end
    .align 12
app_7_start:
    .incbin "../user/build/elf/ch3b_yield0.elf"
    .space 4096*4
app_7_end:

    .section .data
    .global app_8_start
    .global app_8_end
    .align 12
app_8_start:
    .incbin "../user/build/elf/ch3b_yield1.elf"
    .space 4096*4
app_8_end:

    .section .data
    .global app_9_start
    .global app_9_end
    .align 12
app_9_start:
    .incbin "../user/build/elf/ch3b_yield2.elf"
    .space 4096*4
app_9_end:
