# Sel4 中断处理

Sel4的中断处理并无特色，遵循riscv 基本理念



```assembly
/*traps.S:*/
.global trap_entry
.extern c_handle_syscall
.extern c_handle_fastpath_reply_recv
.extern c_handle_fastpath_call
.extern c_handle_interrupt
.extern c_handle_exception

/*中断异常处理的入口，stvec设置的中断处理地址*/
trap_entry:
csrrw sp, sscratch, sp ;内核栈与用户栈的切换
csrrw t0, sscratch, t0
STORE ra, (0*REGBYTES)(t0)
STORE sp, (1*REGBYTES)(t0) ;在用户占保存返回地址与内核栈的指针
... ;此处省略保存通用寄存器的过程，所有通用寄存器均被保存


  csrr x1, sstatus
  STORE x1, (32*REGBYTES)(t0)

  csrr s0, scause
  STORE s0, (31*REGBYTES)(t0) ;读取scause sstatus寄存器
  
  la sp, (kernel_stack_alloc + BIT(CONFIG_KERNEL_STACK_BITS)) :加载内核栈地址
  
  csrr x1,  sepc
  STORE   x1, (33*REGBYTES)(t0);保存sepc
  
  ...;接下来根据s0的值判断是否为中断异常，如果是，就调入对应的c函数去处理
```

## 中断处理

中断处理部分比较简单，其中``getActiveIrq``函数会获得当前被触发的中断，然后进入handleInterrupt函数具体处理，在此仅展示部分代码：

```c++
void handleInterrupt(irq_t irq)
{
    switch (intStateIRQTable[(irq)]) {
            ...
       case IRQTimer:




        timerTick();
        resetTimer();

        break;
    }
    ackInterrupt(irq);
}
```

当完成中断处理后，会进入用户态的函数restore_user_context，这一部分用c的内联汇编编写,基本内容与```trap.S```中内容类似，不做展示。

## 异常处理

这一部分的内容的大致流程与中断类似，具体处理函数为c_handler_exception

```c++
void VISIBLE NORETURN c_handle_exception(void)
{
    NODE_LOCK_SYS;

    c_entry_hook();

    word_t scause = read_scause();
    switch (scause) {
    case RISCVInstructionAccessFault:
    case RISCVLoadAccessFault:
    case RISCVStoreAccessFault:
    case RISCVLoadPageFault:
    case RISCVStorePageFault:
    case RISCVInstructionPageFault:
        handleVMFaultEvent(scause);
        break;
    default:
        handleUserLevelFault(scause, 0);
        break;
    }

    restore_user_context();
    UNREACHABLE();
}
```

