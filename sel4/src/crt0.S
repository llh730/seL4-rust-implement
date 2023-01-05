/*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 */


.extern rust_main
.extern __global_pointer$
.extern elfloader_stack_alloc
.extern hsm_exists


.section ".text.start"

/* OpenSBI starts us these parameters:
 *   a0: hart id
 *   a1: dtb
 *
 * On RISC-V, only M-Mode can access the CSR mhartid to get the actual hart ID,
 * the SBI running there is responsible for passing this ID up. In S-Mode there
 * is no way to ever query it again, so we have to preserve what we get passed
 * here. This is a RISC-V design decision, more background can be found at
 * https://github.com/riscv/riscv-sbi-doc/issues/25.
 * It seems that OpenSBI starts us at a random hart and keeps all other harts
 * suspended or spinning. However, even on non-SMP configurations there might
 * be an expectation that we are running on CONFIG_FIRST_HART_ID. If the current
 * hart turns out to be a different one, we have to switch harts somehow. The
 * SBI Heart State Management (HSM) extension exists for this, but it might not
 * be implemented. In this case, there is nothing we can do here in the assembly
 * startup code, but C boot code might still have platform specific proprietary
 * ways to switch harts.
 */

.global _start
_start:

.option push
.option norelax
1:auipc gp, %pcrel_hi(__global_pointer$)
  addi  gp, gp, %pcrel_lo(1b)
.option pop

  /* save the parameters passed */
  mv s0, a0 
  mv s2, a1 

  /* Attach the stack to sp before calling any C functions */
  la sp, (elfloader_stack_alloc + (1<<(12)))

  jal clear_bss

  /* Check if the Heart State Management (HSM) extension exists, so it can be
   * used to switch harts if we are not running on hart CONFIG_FIRST_HART_ID.
   * The SBI returns SBI_SUCCESS (0) in a0 if the call could be processed or an
   * error code if not. On SBI_SUCCESS the value in a1 is 0 if the extension is
   * not available or an extension-specific non-zero value if it is available.
   */
  li a7, 0x10
  li a6, 3
  li a0, 0x48534DULL
  ecall /* call SBI to probe for HSM extension */
  mv a2, a0 
  mv a3, a1 
  mv a0, s0 
  mv a1, s2 
  bnez a2, _start1 /* goto _start1 if SBI did not return SBI_SUCCESS (0) */
  beqz a3, _start1 /* goto _start1 if HSM extension is missing */

  /* Update global bool variable to tell boot code the HSM extension exists. */
  la t1, hsm_exists
  li t2, 1
  amoadd.w t1, t2, (t1)

  /*  Check if we are on CONFIG_FIRST_HART_ID */
  li s1, 0
  beq  a0, s1, _start1 /* goto _start1 if we are on CONFIG_FIRST_HART_ID */

  /* Use HSM extension to start hart CONFIG_FIRST_HART_ID. */
hsm_switch_hart:
  li a7, 0x48534DULL
  li a6, 0
  li a0, 0 /* hart id to start */
  mv a2, s2 
  la a1, _start1 /* where to start the hart */
  ecall /* call SBI to start hart FIRST_HART_ID */

  /* Since we are not the designated primary hart, continue the boot process as
   * secondary hart
   */
  mv a0, s0 
  j secondary_harts


_start1: 
.option push
.option norelax
1:auipc gp, %pcrel_hi(__global_pointer$)
  addi  gp, gp, %pcrel_lo(1b)
.option pop


  la sp, (elfloader_stack_alloc + (1<<(12)))
  la s0, rust_main
  jr s0

.text

.global secondary_harts
secondary_harts:

.option push
.option norelax
1:auipc gp, %pcrel_hi(__global_pointer$)
  addi  gp, gp, %pcrel_lo(1b)
.option pop

/* If we get here then the HSM extension exists and the current
 * HART is not going to be used and needs to be suspended. */
hsm_suspend_hart:
  li a7, 0x48534DULL
  li a6, 1
  ecall /* call SBI to suspend current HART */

spin_hart:
  wfi
  j spin_hart
