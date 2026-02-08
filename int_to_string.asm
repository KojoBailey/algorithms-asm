section .bss
global   ascii_digits
ascii_digits resb 20 ; 64-bit int max is 20 digits.

section .text
global  int_to_string

int_to_string:
	mov rcx, 10; rcx <- divisor

.loop:
	xor  rdx, rdx; clear rdx
	div  rcx; rax = quotient, rdx = remainder
	add  dl, '0'; remainder to ASCII
	dec  rdi
	mov  [rdi], dl; store char
	test rax, rax
	jnz  .loop

	ret
