# AT&T atau gas(gnu assambly)
#
# Compile: as --march=i386 --32 ./hello_gas_solution2.s -o hello_gas_solution2.o
# Link   : ld -m elf_i386 hello_gas_solution2.o -o hello_gas_solution2

.global _start

.text
_start:
	jmp my_string
payload:
	xor %eax, %eax	#Zero out eax. example 0xdeadbeef to 0x00000
	xor %ebx, %ebx
	xor %edx, %edx
	mov $4, %al	#saved to register al 8bit
	mov $1, %bl
	pop %ecx
	mov $len, %dl
	int $0x80


	#syscall - exit(0);
	#NOTE
	#jika msg lebih dari 255 karakter, anda perlu menolkan eax lagi
	#melalui xor, atau mov %ebx, eax

	mov $1, %al
	xor %ebx, %ebx
	int $0x80

my_string:
	call payload	#call the payload label.
			#ini akan push/mendorong the pointer to msg onto/keatas the stack
			#as a return address

msg:
	.ascii "Hello AT&T payload delete null\n"
	len = . - msg

