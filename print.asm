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

section .text
	global print_string ; function: void
		; rdx <- string: char*
		; r8  <- length: u64
	global print_int ; function: void
		; eax <- int

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
