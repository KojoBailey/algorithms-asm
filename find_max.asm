section .text
global   find_max

find_max:
	; ecx: int size
	; [rdx]: int* arr

	mov eax, [rdx]
	dec ecx
	jz  return

compare:
	add   rdx, 4; move to next array element
	mov   r8d, [rdx]
	cmp   r8d, eax
	cmovg eax, r8d
	loop  compare

return:
	ret
