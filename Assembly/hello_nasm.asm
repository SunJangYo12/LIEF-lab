; compile: nasm -f elf hello_nasm.asm
; link   : ld -m elf_i386 hello_nasm.o -o hello_nasm

global _start
section .data
	msg: db "Hello nasm", 0xa	; 0xa is \n, db adalah byte dan yang menikuti bukan intruksi
	len: equ $-msg

section .text
_start:
	;syscall - write(1, msg, len);

	mov eax, 4	;4 is syscall number write()
	mov ebx, 1	;param(1) 1 is stdout file descriptor
	mov ecx, msg	;param(2), pointer msg
	mov edx, len	;param(3), length string pointer
	int 0x80	;call syscall


	;syscall - exit(0)
	mov al, 1	;syscall for exit()
	mov ebx, 0	;param(1), status code
	int 0x80	;call syscall
