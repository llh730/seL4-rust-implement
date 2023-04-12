TARGET := riscv64gc-unknown-none-elf
MODE := release
KERNEL_ELF := target/$(TARGET)/$(MODE)/sel4
KERNEL_BIN := $(KERNEL_ELF).bin
KERNEL_ASM := $(KERNEL_ELF).asm

CHAPTER ?= 3
TEST ?= $(CHAPTER)
BASE ?= 1


OBJDUMP := rust-objdump --arch-name=riscv64
OBJCOPY := rust-objcopy --binary-architecture=riscv64

run: $(KERNEL_BIN)
	qemu-system-riscv64 \
            -machine virt \
            -nographic \
            -bios ./bootloader/rustsbi-qemu.bin \
            -device loader,file=./target/riscv64gc-unknown-none-elf/release/sel4,addr=0x80200000

kernel:
	#@make -C ../user build TEST=3 CHAPTER=3 BASE=1
	@cargo  build --release

build: env $(KERNEL_BIN)

$(KERNEL_BIN): kernel
	@$(OBJCOPY) $(KERNEL_ELF) --strip-all -O binary $@
	@$(OBJDUMP) $(KERNEL_ELF) -S > $(KERNEL_ELF).asm

env:
	rustup install nightly
	rustup default nightly
	(rustup target list | grep "riscv64gc-unknown-none-elf (installed)") || rustup target add $(TARGET)
	cargo install cargo-binutils --vers ~0.2
	rustup component add rust-src
	rustup component add llvm-tools-preview

.PHONY: build env kernel clean run-inner