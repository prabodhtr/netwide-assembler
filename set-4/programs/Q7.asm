section .data
	msg1 : db 'Enter the string :'
	size_msg1 : equ $-msg1

	msg2 : db 'Enter n :'
	size_msg2 : equ $-msg2

section .bss
	temp : resb 1
	string : resb 100
	length : resb 1
	n :	resb 1
	length_temp : resb 1
	f_index : resb 1
	l_index : resb 1

section .text
	global _start
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,size_msg1
	int 80h

	call read_string
;	call print_string
	

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,size_msg2
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,n
	mov edx,1
	int 80h

	sub byte[n],30h

	call print

	mov eax,1
	mov ebx,0
	int 80h
print:
	pusha
	mov esi,0
	mov byte[length_temp],0
	mov cl,byte[n]
	loop1:
		mov eax,0
		mov al,byte[string + esi]
		cmp al,' '
		je check
		inc byte[length_temp]
		jmp not_check
	check:
		mov bl,byte[length_temp]
		mov byte[length_temp],0
		mov edx,esi
		mov byte[l_index],dl
		sub dl,bl
		mov byte[f_index],dl
		cmp bl,byte[n]
		jna not_check
		call print_word
	not_check:
		inc esi
		mov eax,esi
		cmp al,byte[length]
		jb loop1

		mov bl,byte[length_temp]
		mov byte[length_temp],0
		mov edx,esi
		mov byte[l_index],dl
		sub dl,bl
		mov byte[f_index],dl
		cmp bl,byte[n]
		jna exit
		call print_word
	exit:
	popa
	ret
print_word:
	pusha
	mov eax,0
	mov ebx,0
	mov al,byte[f_index]
	mov bl,byte[l_index]

	loop1_print:
		mov cl,byte[string + eax]
		mov byte[temp],cl
	pusha
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
	popa
	inc al
	cmp al,bl
	jna loop1_print

	popa
	ret

read_string:
	pusha
	mov esi,0
	read_string_l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		
		cmp byte[temp],10
		je read_string_end
		mov eax,0
		mov al,byte[temp]
		mov byte[string + esi],al
		inc esi
	jmp read_string_l1
		
	read_string_end:
		mov eax,esi
		mov byte[length],al
		popa
ret

print_string:
	pusha
	mov esi,0
	print_string_l1:
		mov al,byte[string + esi]
		mov byte[temp],al
		
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h

		inc esi
		mov eax,esi
		cmp al,byte[length]
		jb print_string_l1

		popa
		ret
