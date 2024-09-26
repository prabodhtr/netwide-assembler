section .data
	msg1 : db "Enter the string: "
	size_msg1 : equ $-msg1
	delim : db " ",10,0
	newline : db 10,0
	space : db " ",0
section .bss
	string : resb 100
	string_arr : resb 10000
	t 	: resd 1
	str_length : resd 1

section .text
	global main

	extern fgets
	extern fputs
	extern strlen
	extern strtok
	extern stdout
	extern stdin
	extern strcpy
	main:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		push dword [stdin]
		push dword 100
		push string
		call fgets

		;push dword[stdout]
		;push string
		;call fputs

		call store
		call print
		mov eax,1
		mov ebx,0
		int 80h

print:
	pusha
	push ebp
	mov ebp,esp
	mov esi,0
	mov edi,string_arr
	mov eax,dword[str_length]
	dec eax
	imul ebx,eax,100
	add edi,ebx
	print_loop:
		
	push dword[stdout]
	push edi
	call fputs
	sub edi,100
	
	push dword[stdout]
	push space
	call fputs
	inc esi

	mov eax,dword[str_length]
	cmp esi,eax
	jb print_loop
	push dword[stdout]
	push newline
	call fputs


	mov esp,ebp
	pop ebp
	popa
	ret

store:
	pusha
	push ebp
	mov dword[str_length],0
	mov ebp,esp
	mov esi,string_arr
	push delim
	push string
	call strtok
	
	mov dword[t],eax
		

	loop1:
				
	push dword[t]
	push esi
	call strcpy

	add esi,100
	inc dword[str_length]

	push delim
	push dword 0
	call strtok

	mov dword[t],eax
	cmp dword[t],0
	jne loop1
	mov esp,ebp
	pop ebp
	
	popa
	ret
