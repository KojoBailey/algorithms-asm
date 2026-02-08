bits 64
default rel

; Windows API
	extern WriteFile ; function: void
		; rcx <- handle
	extern GetStdHandle ; function -> handle
		; rcx <- target
; int_to_string.asm
	extern ascii_digits ; array: int
	extern int_to_string ; function: void
		; eax <- integer: u64
		; rdi <- length: u64

section .data
	opening_brace db "arr = ["
	opening_brace_len equ $ - opening_brace
	closing_brace db "]", 0xA
	delimiter db ", "
	delimiter_len equ $ - delimiter

section .bss
	index resd 1

section .text
	global print_string ; function: void
		; rdx <- string: char*
		; r8  <- length: u64
	global print_int ; function: void
		; eax <- int
	global print_array ; function: void
		; rcx <- array: int*
		; edx <- length: u64

print_string:
	sub rsp, 40

	mov  rcx, -11; STD_OUTPUT_HANDLE
	call GetStdHandle
	mov  rbx, rax; rbx <- handle
	mov rcx, rbx ; arg1 <- handle
	xor r9, r9 ; arg4 <- NULL
	mov qword [rsp + 32], 0 ; arg5 <- NULL

	call WriteFile

	add rsp, 40 ; clean up stack
	ret

print_int:
	lea rdi, [ascii_digits + 20]
	call int_to_string
	lea r8, [ascii_digits + 20]
	sub r8, rdi ; arg2
	mov rdx, rdi ; arg1
	call print_string

	ret

print_array:
	push rcx
	mov dword [index], edx
	
	lea rdx, [opening_brace]
	mov r8, opening_brace_len
	call print_string

	.loop:
	pop rcx ; arg1
	movsxd rdx, dword [index]
	mov eax, [rcx + 4 * (rdx - 1)]
	push rcx
	call print_int

	cmp dword [index], 1
	jz .break

	lea rdx, [delimiter]
	mov r8, delimiter_len
	call print_string

	mov edx, dword [index]
	dec edx
	mov dword [index], edx
	jnz .loop

	.break:
	lea rdx, [closing_brace]
	mov r8, 2
	call print_string

	pop rcx
	ret
