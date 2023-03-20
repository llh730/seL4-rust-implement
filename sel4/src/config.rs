//! Constants used in rCore

use crate::MASK;

pub const USER_STACK_SIZE: usize = 4096 * 2;
pub const KERNEL_STACK_SIZE: usize = 4096 * 2;
pub const KERNEL_HEAP_SIZE: usize = 0x20_0000;
pub const MEMORY_END: usize = 0x88000000;
pub const PAGE_SIZE: usize = 0x1000;
pub const PAGE_SIZE_BITS: usize = 0xc;
pub const MAX_SYSCALL_NUM: usize = 500;
pub const MAX_APP_NUM: usize = 16;

pub const TRAMPOLINE: usize = usize::MAX - PAGE_SIZE + 1;
pub const TRAP_CONTEXT: usize = TRAMPOLINE - PAGE_SIZE;
pub const CLOCK_FREQ: usize = 12500000;
pub const BIG_STRIDE: isize = 1024;
pub const APP_BASE_ADDRESS: usize = 0x80400000;
pub const APP_SIZE_LIMIT: usize = 0x20000;



pub const PPTR_BASE:usize=0xFFFFFFC000000000;
pub const PADDR_BASE:usize=0x0;
pub const PT_INDEX_BITS:usize=9;
pub const CONFIG_PT_LEVELS:usize=3;
pub const seL4_PageBits:usize=12;
pub const PAGE_BITS:usize=seL4_PageBits;
pub const PPTR_TOP:usize=0xFFFFFFFF80000000;
pub const physBase:usize=0x80000000;
pub const KERNEL_ELF_PADDR_BASE:usize=physBase+0x200000;
pub const KERNEL_ELF_BASE:usize=KERNEL_ELF_PADDR_BASE;
pub const KDEV_BASE:usize=0xFFFFFFFFC0000000;
pub const KS_LOG_PPTR:usize=0xFFFFFFFFFFE00000;
pub const PPTR_BASE_OFFSET:usize=PPTR_BASE-PADDR_BASE;
pub const PADDR_TOP:usize=PPTR_TOP-PPTR_BASE_OFFSET;
pub const KERNEL_ELF_BASE_OFFSET:usize=KERNEL_ELF_BASE-KERNEL_ELF_PADDR_BASE;
pub const seL4_PageTableBits:usize=12;
pub const asidLowBits:usize=9;
pub const asidHighBits:usize=7;
pub const IT_ASID:usize=1;
pub const RISCVPageBits:usize=12;
pub const RISCVMegaPageBits:usize=21;
pub const RISCVGigaPageBits:usize=30;
