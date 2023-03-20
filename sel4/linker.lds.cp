/*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 */

/*
 * NOTE: For RISC-V 32-bit, having the .rodata section before the .data section causes the elfloader to
 *       freeze up. Thus, for 32-bit we move the .rodata section to after the .bss section as previously
 *       before some refactoring. The 64-bit version does not seem to be affect by this issue and uses thus
 *       uses the new layout.
 */

OUTPUT_ARCH(riscv)
ENTRY( _start )
BASE_ADDRESS = 0x84000000;


SECTIONS
{
    . = BASE_ADDRESS;
    _text = .;
    .start :
    {
        *(.text.start)
    }
    .text :
    {
        *(.text)
    }
    . = ALIGN(16);
    .rodata :
    {
        *(.srodata*)
        . = ALIGN(16);
        *(.rodata)
        *(.rodata.*)
        /*
         * ld crashes when we add this here: *(_driver_list)
         */
        . = ALIGN(16);
        _archive_start = .;
        *(._archive_cpio)
        _archive_end = .;
    }
    . = ALIGN(16);
    .data :
    {
        __global_pointer$ = . + 0x800;
        *(.sdata*)
        *(.data)
        *(.data.*)
    }
    . = ALIGN(16);
    .bss :
    {
        _bss = .;
        *(.sbss*)
        *(.bss)
        *(.bss.*)
        _bss_end = .;
    }
     _end = .;
}
