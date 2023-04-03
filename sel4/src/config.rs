//! Constants used in rCore

use crate::{BIT, MASK};

pub const USER_STACK_SIZE: usize = 4096 * 2;
pub const KERNEL_STACK_SIZE: usize = 4096 * 10;
pub const KERNEL_HEAP_SIZE: usize = 0x800000;
pub const MEMORY_END: usize = 0x88000000;
pub const PAGE_SIZE: usize = 0x1000;
pub const PAGE_SIZE_BITS: usize = 0xc;
pub const MAX_SYSCALL_NUM: usize = 500;
pub const MAX_APP_NUM: usize = 16;

pub const TRAMPOLINE: usize = usize::MAX - PAGE_SIZE + 1;
pub const TRAP_CONTEXT: usize = TRAMPOLINE - PAGE_SIZE;
pub const CLOCK_FREQ: usize = 12500000;
pub const BIG_STRIDE: isize = 1024;
pub const APP_BASE_ADDRESS: usize = 0x81400000;
pub const APP_SIZE_LIMIT: usize = 0x20000;

pub const PPTR_BASE: usize = 0xFFFFFFC000000000;
pub const PADDR_BASE: usize = 0x0;
pub const PT_INDEX_BITS: usize = 9;
pub const PT_OFFSET_BITS: usize = 12;
pub const CONFIG_PT_LEVELS: usize = 3;
pub const seL4_PageBits: usize = 12;
pub const PAGE_BITS: usize = seL4_PageBits;
pub const PPTR_TOP: usize = 0xFFFFFFFF80000000;
pub const physBase: usize = 0x80000000;
pub const KERNEL_ELF_PADDR_BASE: usize = physBase + 0x200000;
pub const KERNEL_ELF_BASE: usize = PPTR_TOP + (KERNEL_ELF_PADDR_BASE & MASK!(30));
pub const KDEV_BASE: usize = 0xFFFFFFFFC0000000;
pub const KS_LOG_PPTR: usize = 0xFFFFFFFFFFE00000;
pub const PPTR_BASE_OFFSET: usize = PPTR_BASE - PADDR_BASE;
pub const PADDR_TOP: usize = PPTR_TOP - PPTR_BASE_OFFSET;
pub const KERNEL_ELF_BASE_OFFSET: usize = KERNEL_ELF_BASE - KERNEL_ELF_PADDR_BASE;
pub const seL4_PageTableBits: usize = 12;
pub const asidLowBits: usize = 9;
pub const asidHighBits: usize = 7;
pub const IT_ASID: usize = 1;
pub const RISCVPageBits: usize = 12;
pub const RISCVMegaPageBits: usize = 21;
pub const RISCVGigaPageBits: usize = 30;
pub const wordRadix: usize = 6;
pub const wordBits: usize = BIT!(wordRadix);
pub const CONFIG_NUM_DOMAINS: usize = 1;
pub const CONFIG_NUM_PRIORITIES: usize = 256;
pub const L2_BITMAP_SIZE: usize = (CONFIG_NUM_PRIORITIES + wordBits - 1) / wordBits;
pub const NUM_READY_QUEUES: usize = CONFIG_NUM_DOMAINS * CONFIG_NUM_PRIORITIES;
pub const CONFIG_MAX_NUM_NODES: usize = 1;
pub const KERNEL_STACK_ALIGNMENT: usize = 4096;
pub const tcbCTable: usize = 0;
pub const tcbVTable: usize = 1;
pub const tcbReply: usize = 2;
pub const tcbCaller: usize = 3;
pub const tcbBuffer: usize = 4;
pub const tcbCNodeEntries: usize = 5;

pub const SSTATUS_SPIE: usize = 0x00000020;
pub const SSTATUS_SPP: usize = 0x00000010;
pub const CONFIG_KERNEL_STACK_BITS: usize = 12;

pub const ksDomScheduleLength: usize = 1;

pub const SchedulerAction_ResumeCurrentThread: usize = 0;
pub const SchedulerAction_ChooseNewThread: usize = 1;

pub const MAX_NUM_FREEMEM_REG: usize = 16;
pub const NUM_RESERVED_REGION: usize = 3;
pub const MAX_NUM_RESV_REG: usize = MAX_NUM_FREEMEM_REG + NUM_RESERVED_REGION;

pub const CONFIG_ROOT_CNODE_SIZE_BITS: usize = 13;
pub const seL4_SlotBits: usize = 5;
pub const seL4_PML4Bits: usize = 12;
pub const seL4_VSpaceBits: usize = seL4_PML4Bits;
pub const seL4_TCBBits: usize = 12;
pub const BI_FRAME_SIZE_BITS: usize = 12;
pub const seL4_ASIDPoolBits: usize = 12;
pub const seL4_NumInitialCaps: usize = 14;

pub const seL4_CapNull: usize = 0;
pub const seL4_CapInitThreadTCB: usize = 1;
pub const seL4_CapInitThreadCNode: usize = 2;
pub const seL4_CapInitThreadVspace: usize = 3;
pub const seL4_CapIRQControl: usize = 4;
pub const seL4_CapASIDControl: usize = 5;
pub const seL4_CapInitThreadASIDPool: usize = 6;
pub const seL4_CapInitThreadIPCBuffer: usize = 10;
pub const seL4_CapDomain: usize = 11;

pub const SIE_STIE: usize = 5;
pub const SIE_SEIE: usize = 9;

pub const seL4_MsgMaxLength: usize = 120;
pub const msgInfoRegister: usize = 10;
pub const badgeRegister: usize = 9;
pub const seL4_MsgExtraCapBits: usize = 2;
pub const seL4_MsgMaxExtraCaps: usize = BIT!(seL4_MsgExtraCapBits) - 1;
pub const n_msgRegisters: usize = 4;

pub const RISCVInstructionMisaligned: usize = 0;
pub const RISCVInstructionAccessFault: usize = 1;
pub const RISCVInstructionIllegal: usize = 2;
pub const RISCVBreakPoint: usize = 3;
pub const RISCVLoadAccessFault: usize = 5;
pub const RISCVAddressMisaligned: usize = 6;
pub const RISCVStoreAccessFault: usize = 7;
pub const RISCVEnvCall: usize = 8;
pub const RISCVInstructionPageFault: usize = 12;
pub const RISCVLoadPageFault: usize = 13;
pub const RISCVStorePageFault: usize = 15;
pub const RISCVSupervisorTimer: usize = 9223372036854775813;
