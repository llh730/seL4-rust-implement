# seL4-rust-implement

本仓库为llh使用rust实现seL4仓库，当前刚阅读完seL4参考文档，在完成[seL4-tutorial](https://docs.sel4.systems/Tutorials/)，了解c版seL4后，会开始完成seL4 rust语言的重写工作。

## 环境配置

### qemu

运行以下指令可以安装qemu：

```bash
git clone https://github.com/qemu/qemu
cd qemu
git checkout v6.2.0
./configure --target-list=riscv64-softmmu
make -j $(nproc)
sudo make install
```



### rust

cargo安装：

```bash
curl https://sh.rustup.rs -sSf | sh
```



进入sel4文件夹后输入

```makefile
make env
```

即可进行环境的配置工作。

## 如何运行

在sel4文件夹下输入

```makefile
make run
```

即可运行，需要注意的是，sel4同目录下的user文件是根据rcore修改的用户态程序，当前我简单的实现了三个程序用来测试endpoint的通信工作。由于当前我的实现中所有的内核对象都必须在boot阶段创建完成（tcb endpoint等），用户程序只能通过输入固定的内存的值来确定自己的内核对象所在的位置，又因为内存创建内核对象的位置是动态的，有可能会出现内核对象创建位置与用户程序中规定位置不匹配的问题。

