# FreeRTOS Record

## kernel 模块

FreeRTOS内核模块，实现了任务调度、消息队列、信号量等功能。

### 任务调度

任务调度实现内容包括任务创建、删除、延迟、挂起、恢复等基本功能，具体相关代码在```kernel/task.rs```中。

##### 启动流程

使用时的基本框架如下：

```rust
//main.rs:
pub fn main() {
    //必要的初始化工作
    //创建任务1
    //创建任务2
    vTaskStartScheduler();//启动调度器
    loop {
        panic! {"error in loop!!!!!"};
    }
}
fn vTaskStartScheduler(){
    //创建初始任务，最低优先级任务。
    xPortStartScheduler();
}
fn xPortStartScheduler(){
    //设置计时器
    //关中断
    xPortStartFirstTask();//启动第一个任务
}
```

##### 时间片轮转

时钟中断触发时会切换任务上下文，汇编中已经写好，只需提供函数vTaskSwitchContext：

```rust
#[no_mangle]
pub extern "C" fn vTaskSwitchContext() {
    //todo
    // // print("vTaskSwitchContext");
    //port_disable_interrupts!();
    unsafe {
        if uxSchedulerSuspended == 0 {
            xYieldPending = false;
            taskSELECT_HIGHEST_PRIORITY_TASK();
        } else {
            xYieldPending = true;
        }
    }
}
```



### 消息队列与信号量

提供了队列创建、读写、删除、复位功能，代码位于```kernel/queue.rs```中，

信号量其实调用了消息队列的接口

```rust
pub fn xQueueGenericCreate(uxQueueLength: UBaseType,uxItemSize: UBaseType,ucQueueType: u8) -> Self ;
pub fn xSemaphoreCreateCounting(
    uxMaxCount: UBaseType,
    uxInitialCount: UBaseType,
) -> QueueDefinition {
    let mut handle = QueueDefinition::xQueueGenericCreate(
        uxMaxCount,
        semSEMAPHORE_QUEUE_ITEM_LENGTH,
        queueQUEUE_TYPE_COUNTING_SEMAPHORE,
    );
    handle.uxMessagesWaiting = uxInitialCount;

    handle
}
```

xQueueSend流程（其他过程与之类似）：

![](C:\Users\ASUS\Desktop\seL4-rust-implement\record\pic\queueSend.png)

## portable模块

主要定义了底层硬件相关代码，如串口通信工具、时钟中断设置等。代码相较于kernel较少。

## ffi模块

主要是为c语言提供的接口，在kernel提供的接口的基础上又封装了一层。

```c
#define xTaskCreateStatic xTaskCreateStaticToC //提供了多个这样的封装

#define TaskHandle_t void*  //将任务调度、消息队列、信号量中的所有handle都定义为void* 类型

//当c中想要调用rust中的函数时，如果涉及到handle 首先就要将其从void*恢复，这也就是需要重写"ToC"结尾函数的原因

pub extern "C" fn vTaskSuspendToC(xTaskToSuspend_: TaskHandle_c) {
    if xTaskToSuspend_ as usize == 0 {
        vTaskSuspend(None);
    } else {
        let temp = unsafe { Some(Arc::from_raw(xTaskToSuspend_)) };
        vTaskSuspend(temp.clone());
        let xTaskToSuspend = Arc::into_raw(temp.unwrap());
    }
}
```

## 其他

如何将rust与c一起编译链接：

```rust
//build.rs 删除部分内容方便展示，使用了cc工具
#![allow(warnings)]
extern crate cc;
use std::env;
fn main() {
    let target = env::var("TARGET").expect("TARGET was not set");
    if (target.contains("riscv32")) {
        cc::Build::new()
            .compiler("riscv64-unknown-elf-gcc")
            .flag("-w")
            .file("src/portable/portASM.S")
            .file("src/kernel/start.S")
            .flag("-march=rv32ima")
            .file("src/kernel/config_resolve.c")
            .compile("portASM");
    } else if (target.contains("riscv64")) {
        cc::Build::new()
            .compiler("riscv64-unknown-elf-gcc")
            .file("src/portable/portASM.S")
            .flag("-march=rv64ima")
            .flag("-mabi=lp64")
            .compile("portASM");
    }
}
```

## 问题

1.对queue中部分内容（queuereceive中）还是不理解，但感觉对我的工作影响不大？
