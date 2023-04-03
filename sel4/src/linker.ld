OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000;


SECTIONS
{


    . = BASE_ADDRESS;

    . = ALIGN(4K);
    stext = .;
    
    .text  : 
    {
        *(.text.entry)
        *(.text .text.*)
    }
    . = ALIGN(4K);
    etext = .;

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
    . = ALIGN(4K);
    . = . + 4K;
    .rodata  : 
    {
        *(.rodata)
        *(.rodata.*)
    }
    . = ALIGN(4K);
    . = . + 4K;
    .data  : 
    {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }
    . = . + 4K;
    . = ALIGN(4K);
    .bss : 
    {
        *(.bss.stack)
        *(.bss)
        *(COMMON) /* fallback in case '-fno-common' is not used */

        /* 4k breakpoint stack */
        _breakpoint_stack_bottom = .;
        . = . + 4K;
        _breakpoint_stack_top = .;

        /* large data such as the globals frame and global PD */
        *(.bss.aligned)
    }

    . = . + 8K;
    . = ALIGN(4K);
    skernel_stack_alloc = .;
    .kernel_stack :
    {
        . = ALIGN(4K);
        *(.kernel_stack.aligned)
    }
    ekernel_stack_alloc = .;
    . = . + 8K;
    . = ALIGN(4K);
    suser_stack_alloc = .;
    .user_stack :
    {
        . = ALIGN(4K);
        *(.user_stack.aligned)
    }
    euser_stack_alloc = .;
    . = . + 8K;
    . = ALIGN(4K);
   .page_table :
    {
        . = ALIGN(4K);
        *(.page_table.aligned)
    }
    . = ALIGN(4K);
    ki_end = .;
}