use crate::elfloader::config::*;
use crate::BIT;
use crate::IS_ALIGNED;
use crate::println;
use core::arch::asm;
use lazy_static::lazy_static;

pub const PT_LEVEL_1: usize = 1;
pub const PT_LEVEL_2: usize = 2;

pub const PT_LEVEL_1_BITS: usize = 30;
pub const PT_LEVEL_2_BITS: usize = 21;

pub const PTE_TYPE_TABLE: usize = 0x00;
pub const PTE_TYPE_SRWX: usize = 0xCE;

pub const RISCV_PGSHIFT: usize = 12;

pub const RISCV_PGSIZE: usize = BIT!(RISCV_PGSHIFT);

pub const PTE_V: usize = 0x001;

pub const PTE_PPN0_SHIFT: usize = 10;

pub const PT_INDEX_BITS: usize = 9; //10 for riscv32 , 9 for riscv64

pub const PTES_PER_PT: usize = BIT!(PT_INDEX_BITS);

macro_rules! PTE_CREATE_PPN {
    ($PT_BASE:expr) => {
        ((($PT_BASE) >> RISCV_PGSHIFT) << PTE_PPN0_SHIFT) as u64
    };
}

macro_rules! PTE_CREATE_NEXT {
    ($PT_BASE:expr) => {
        (PTE_CREATE_PPN!($PT_BASE) | PTE_TYPE_TABLE | PTE_V) as u64
    };
}

macro_rules! PTE_CREATE_LEAF {
    ($PT_BASE:expr) => {
        (PTE_CREATE_PPN!($PT_BASE) | PTE_TYPE_TABLE | PTE_V) as u64
    };
}

macro_rules! GET_PT_INDEX {
    ($addr:expr,$n:expr) => {
        (PTE_CREATE_PPN!(PT_BASE) | PTE_TYPE_SRWX | PTE_V) as u64
    };
}

macro_rules! VIRT_PHYS_ALIGNED {
    ($virt:expr,$phys:expr,$level_bits:expr) => {
        IS_ALIGNED!(($virt), ($level_bits)) && IS_ALIGNED!(($phys), ($level_bits))
    };
}

#[derive(Default)]
struct image_info {
    /* Start/end byte of the image in physical memory. */
    phys_region_start: u64,
    phys_region_end: u64,

    /* Start/end byte in virtual memory the image requires to be located. */
    virt_region_start: u64,
    virt_region_end: u64,

    /* Virtual address of the user image's entry point. */
    virt_entry: u64,

    phys_virt_offset: u64,
}

lazy_static! {
    static ref kernel_info:image_info=Default::default();
    static ref user_info:image_info=Default::default();
    #[repr(align(4096))]
    static ref l1pt:[u64;PTES_PER_PT]=[0;PTES_PER_PT];
    #[repr(align(4096))]
    static ref l2pt:[u64;PTES_PER_PT]=[0;PTES_PER_PT];
    #[repr(align(4096))]
    static ref l2pt_elf:[u64;PTES_PER_PT]=[0;PTES_PER_PT];
}

pub const vm_mode: u64 = (0x8 as u64 )<< 60;


#[inline]
pub fn sfence_vma(){
    unsafe{ 
        asm!("sfence.vma",options(nomem));
    }
}

#[inline]
pub fn ifence(){
    unsafe{
        asm!("fence.i",options(nomem));
    }
}

#[inline]
pub fn enable_virtual_memory(){
    sfence_vma();
    unsafe{
        asm!(
            "csrw satp,{0}\n"
        ,in(reg) ((l1pt.as_ptr() as u64) >> RISCV_PGSHIFT));
    }
    ifence();
}

pub fn abort(){
    println!("HALT due to call to abort()\n");
    loop{
        unsafe{
            asm!("wfi",options(nomem));
        }
    }
}