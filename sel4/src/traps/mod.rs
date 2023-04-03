use core::arch::asm;

use riscv::register::{
    mtvec::TrapMode,
    scause::{self, Exception, Interrupt, Trap},
    sie, stval, stvec,
};

use crate::{
    config::{
        RISCVEnvCall, RISCVInstructionAccessFault, RISCVInstructionIllegal,
        RISCVInstructionPageFault, RISCVLoadAccessFault, RISCVLoadPageFault, RISCVStoreAccessFault,
        RISCVStorePageFault, RISCVSupervisorTimer,
    },
    elfloader::{mark_current_exited, mark_current_suspended, run_next_task, THREAD},
    kernel::{
        thread::{arch_tcb_t, ksCurThread, n_contextRegisters, setRegister, tcb_t, NextIP},
        vspace::{activate_kernel_vspace, setVSpaceRoot},
    },
    println,
    sbi::shutdown,
    syscall::syscall,
    timer::set_next_trigger,
};
core::arch::global_asm!(include_str!("traps.S"));
pub fn init() {
    extern "C" {
        fn trap_entry();
    }
    unsafe {
        stvec::write(trap_entry as usize, TrapMode::Direct);
    }
}

pub fn enable_timer_interrupt() {
    unsafe {
        sie::set_stimer();
    }
}

pub fn restore_user_context() {
    unsafe {
        let cur_thread_reg = (*(ksCurThread as *const tcb_t)).tcbArch.registers.as_ptr() as usize;
        // for i in 0..n_contextRegisters {
        //     println!(
        //         "registers[{}]:{:#x}",
        //         i,
        //         (*(ksCurThread as *const tcb_t)).tcbArch.registers[i]
        //     );
        // }
        asm!("mv t0, {0}      \n",
        "ld  ra, (0*8)(t0)  \n",
        "ld  sp, (1*8)(t0)  \n",
        "ld  gp, (2*8)(t0)  \n",
        "ld  t2, (6*8)(t0)  \n",
        "ld  s0, (7*8)(t0)  \n",
        "ld  s1, (8*8)(t0)  \n",
        "ld  a0, (9*8)(t0)  \n",
        "ld  a1, (10*8)(t0) \n",
        "ld  a2, (11*8)(t0) \n",
        "ld  a3, (12*8)(t0) \n",
        "ld  a4, (13*8)(t0) \n",
        "ld  a5, (14*8)(t0) \n",
        "ld  a6, (15*8)(t0) \n",
        "ld  a7, (16*8)(t0) \n",
        "ld  s2, (17*8)(t0) \n",
        "ld  s3, (18*8)(t0) \n",
        "ld  s4, (19*8)(t0) \n",
        "ld  s5, (20*8)(t0) \n",
        "ld  s6, (21*8)(t0) \n",
        "ld  s7, (22*8)(t0) \n",
        "ld  s8, (23*8)(t0) \n",
        "ld  s9, (24*8)(t0) \n",
        "ld  s10, (25*8)(t0)\n",
        "ld  s11, (26*8)(t0)\n",
        "ld  t3, (27*8)(t0) \n",
        "ld  t4, (28*8)(t0) \n",
        "ld  t5, (29*8)(t0) \n",
        "ld  t6, (30*8)(t0) \n",
        "ld  t1, (3*8)(t0)  \n",
        "add tp, t1, x0  \n",
        "ld  t1, (34*8)(t0)\n",
        "csrw sepc, t1  \n",
        "csrw sscratch, t0         \n",
        "ld  t1, (32*8)(t0) \n",
        "csrw sstatus, t1\n",
        "ld  t1, (5*8)(t0) \n",
        "ld  t0, (4*8)(t0) \n",
        "sret",in(reg) cur_thread_reg);
    }
}

#[no_mangle]
pub fn trap_handler() {
    unsafe {
        let scause = (*(ksCurThread as *const tcb_t)).tcbArch.registers[31];
        let sepc = (*(ksCurThread as *const tcb_t)).tcbArch.registers[33];
        let stval = stval::read();
        match scause {
            RISCVEnvCall => {
                let mut cx = (&((*(ksCurThread as *const tcb_t)).tcbArch)) as *const arch_tcb_t
                    as *mut arch_tcb_t;
                (*cx).registers[NextIP] += sepc+4;
                (*cx).registers[9] = syscall(
                    (*cx).registers[16],
                    [(*cx).registers[9], (*cx).registers[10], (*cx).registers[11]],
                ) as usize;
                setRegister(ksCurThread as *const tcb_t as *mut tcb_t, NextIP, sepc + 4);
                restore_user_context();
            }
            RISCVStoreAccessFault
            | RISCVStorePageFault
            | RISCVInstructionAccessFault
            | RISCVInstructionPageFault
            | RISCVLoadAccessFault
            | RISCVLoadPageFault => {
                println!("[kernel] PageFault in application, bad addr = {:#x}, bad instruction = {:#x},scause:{}, core dumped.",sepc, stval, scause);
                shutdown();
                // mark_current_exited();
                // run_next_task();
                // restore_user_context();
            }
            RISCVInstructionIllegal => {
                println!("[kernel] IllegalInstruction in application, bad addr = {:#x}, bad instruction = {:#x},scause:{}, core dumped.", sepc,stval, scause);
                shutdown();
            }
            RISCVSupervisorTimer => {
                // println!("supervisor timer");
                set_next_trigger();
                restore_user_context();
            }
            _ => {
                panic!("Unsupported trap {}, stval = {:#x}!", scause, stval);
            }
        }
    }
}
