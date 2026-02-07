section.text
global find_max

find_max:
	; [rcx]: int* arr
	; edx: int size

	mov eax, [rcx]; eax <- *rcx
	dec edx; edx--
	jz  return; if edx == 0: jmp return

compare:
	add   rcx, 4; rcx++
	mov   r8d, [rcx]; r8d <- *rcx
	cmp   r8d, eax; if r8d > eax:
	cmovg eax, r8d; eax <- r8d
	dec   edx; edx--
	jnz   compare; if edx != 0: jmp compare

return:
	ret
