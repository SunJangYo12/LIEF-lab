# AT&T atau gas(gnu assambly)
#
# Compile: as --march=i386 --32 ./hello_gas_solution2.s -o hello_gas_solution2.o
# Link   : ld -m elf_i386 hello_gas_solution2.o -o hello_gas_solution2

.global _start

.text
_start:
	jmp my_string
payload:
	xor %eax, %eax
	xor %ebx, %ebx
	xor %edx, %edx
	mov $4, %al	#saved to register al 8bit
	mov $1, %bl
	pop %ecx
	mov $len, %dl
	int $0x80

	ret

my_string:
	call payload

msg:
	.ascii "Hello zzzzzzzzzz\n"
	len = . - msg

