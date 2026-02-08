bits 64
default rel

global _start
; Windows API
	extern ExitProcess; function: void
; print.asm
	extern print_string ; function: void
		; rdx <- string: char*
		; r8  <- length: u64
; find_max.asm
	extern find_max ; function: int
		; rcx <- arr: i32*
		; rdx <- size: u64
	extern print_int ; function: void
		; eax <- int

section .data
	msg     db "Hello, world!", 0xA
	msg_len equ $ - msg

	arr     dd 4, 2, 1, 5, 3

	max_str db "Max: "
	max_len equ $ - max_str

section .bss
	max_value resd 1

section .text
_start:
	;-- align stack
	sub rsp, 40 ; 32 bytes shadow space + 8 bytes stack alignment

	;-- print "Hello, world!"
	lea  rdx, [msg] ; arg1
	mov  r8, msg_len ; arg2
	call print_string

	;-- find max
	lea rcx, [arr]
	mov rdx, 5
	call find_max
	mov dword [max_value], eax

	;-- print max
	lea rdx, [max_str]
	mov r8, max_len
	call print_string

	mov eax, [max_value]
	call print_int

	;-- return
	xor  rcx, rcx ; return 0
	call ExitProcess
