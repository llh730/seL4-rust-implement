OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000;


SECTIONS
{


    . = BASE_ADDRESS;

    .boot.text . : 
    {
        *(.boot.text)
    }
    .boot.rodata . : 
    {
        *(.boot.rodata)
    }
    .boot.data . : 
    {
        *(.boot.data)
    }
    .boot.bss . : 
    {
        *(.boot.bss)
    }
    . = ALIGN(4K);

    ki_boot_end = .;

    .text . : 
    {
        . = ALIGN(4K);


        /* Standard kernel */
        *(.text)
    }

    /* Start of data section */
    _sdata = .;
    .small : {
        /* Small data that should be accessed relative to gp.  ld has trouble
           with the relaxation if they are not in a single section. */
        __global_pointer$ = . + 0x800;
        *(.srodata*)
        *(.sdata*)
        *(.sbss)
    }

    .rodata . : 
    {
        *(.rodata)
        *(.rodata.*)
    }

    .data . : 
    {
        *(.data)
    }

    /* The kernel's idle thread section contains no code or data. */
    ._idle_thread . (NOLOAD): 
    {
        *(._idle_thread)
    }

    .bss . (NOLOAD): 
    {
        *(.bss)
        *(COMMON) /* fallback in case '-fno-common' is not used */

        /* 4k breakpoint stack */
        _breakpoint_stack_bottom = .;
        . = . + 4K;
        _breakpoint_stack_top = .;

        /* large data such as the globals frame and global PD */
        *(.bss.aligned)
    }

    . = ALIGN(4K);
    ki_end = .;
}