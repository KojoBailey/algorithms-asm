section .text
global   find_max

	INT_SIZE EQU 4

find_max:
	; ecx: int size
	; [rdx]: int* arr

	mov eax, [rdx]
	dec ecx
	jz  return

compare:
	add   rdx, INT_SIZE
	mov   r8d, [rdx]
	cmp   r8d, eax
	cmovg eax, r8d
	loop  compare

return:
	ret
