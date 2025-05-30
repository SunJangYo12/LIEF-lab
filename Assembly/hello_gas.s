# AT&T atau gas(gnu assambly)
#
# Compile: as --march=i386 --32 ./hello_gas.s -o hello_gas.o
# Link   : ld -m elf_i386 hello_gas.o -o hello_gas

.global _start

.data
msg:
	.ascii "Hello AT&T\n"
	len = . - msg

.text
_start:
	#syscall - write(1, msg, len);
	mov $4, %eax	#4 is number syscall write, $ memberi compiler nilai langsung % ini baru register
	mov $1, %ebx	#param(1), 1 is descriptor to STDOUT
	mov $msg, %ecx	#param(2), pointer msg
	mov $len, %edx	#param(3), len msg
	int $0x80	#call syscall

	#syscall - exit(0);
	mov $1, %al	#1 is number syscall exit
	mov $0, %ebx	#param1, 0 is status code
	int $0x80	#call syscall
