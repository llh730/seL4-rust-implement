run:
	cargo build --release
	qemu-system-riscv64 \
            -machine virt \
            -nographic \
            -bios ./bootloader/rustsbi-qemu.bin \
            -device loader,file=./target/riscv64imac-unknown-none-elf/release/sel4,addr=0x8020000