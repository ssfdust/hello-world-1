run:
	cargo build
	rust-objcopy --strip-all target/riscv64gc-unknown-none-elf/debug/rust_os_hello -O binary target/riscv64gc-unknown-none-elf/debug/os.bin
	qemu-system-riscv64 \
		-machine virt \
		-nographic \
		-bios ../rCore-Tutorial-v3/bootloader/rustsbi-qemu.bin \
		-device loader,file=target/riscv64gc-unknown-none-elf/debug/os.bin,addr=0x80200000 \
		-s -S

debug:
	riscv64-unknown-elf-gdb \
    -ex 'file target/riscv64gc-unknown-none-elf/debug/rust_os_hello' \
    -ex 'set arch riscv:rv64' \
    -ex 'target remote localhost:1234'
