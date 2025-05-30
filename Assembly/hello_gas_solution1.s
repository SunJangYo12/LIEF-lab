# AT&T atau gas(gnu assambly)
#
# Compile: as --march=i386 --32 ./hello_gas_solution1.s -o hello_gas_solution1.o
# Link   : ld -m elf_i386 hello_gas_solution1.o -o hello_gas_solution1

.global _start

.text
_start:
	jmp my_string
payload:
	mov $4, %eax
	mov $1, %ebx
	pop %ecx	#pop the string address pointer off the stack into ecx.
	mov $len, %edx
	int $0x80

	#syscall - exit(0);
	mov $1, %al
	mov $0, %ebx
	int $0x80

my_string:
	call payload	#call the payload label.
			#ini akan push/mendorong the pointer to msg onto/keatas the stack
			#as a return address

msg:
	.ascii "Hello AT&T payload\n"
	len = . - msg

