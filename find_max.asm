section .text
global   find_max

find_max:
	; ecx: int size
	; [rdx]: int* arr

	mov eax, [rdx]
	dec ecx
	jz  return; if edx == 0

compare:
	add   rdx, 4; move to next array element
	mov   r8d, [rdx]
	cmp   r8d, eax
	cmovg eax, r8d; if r8d > eax
	loop  compare; if ecx != 0

return:
	ret
