section .text
global   find_max

	INT_SIZE EQU 4

find_max:
	; rcx <- int* arr
	; edx <- int size

	mov eax, [rcx]
	dec edx
	jz  return

compare:
	add   rcx, INT_SIZE
	mov   r8d, [rcx]
	cmp   r8d, eax
	cmovg eax, r8d
	dec   edx
	jnz   compare

return:
	ret
