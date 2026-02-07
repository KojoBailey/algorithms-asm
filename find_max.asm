section .text
global   find_max

	INT_SIZE EQU 4

find_max:
	; rcx <- int* arr
	; rdx <- size_t size

	mov eax, [rcx]
	dec rdx
	jz  return

compare:
	mov   r8d, [rcx + rdx * INT_SIZE]
	cmp   r8d, eax
	cmovg eax, r8d

	dec rdx
	jnz compare

return:
	ret
