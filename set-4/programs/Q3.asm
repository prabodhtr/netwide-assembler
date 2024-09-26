extern fgets
extern fputs
extern strtok
extern strcpy
extern strcmp
extern stdin
extern stdout
extern printf
extern qsort

section .data
	msg1 : db "Enter the first string :"
	size_msg1 : equ $-msg1

	msg2 : db "Enter the second string :"
	size_msg2 : equ $-msg2

	msg3 : db "Enter the third string :"
	size_msg3 : equ $-msg3

	delim : db " ",10,0
	newline : db 10,0
	space : db " ",0

section .bss
	string1 	: resb 100
	string2 	: resb 100
	string3 	: resb 100

	str_arr1 	: resb 10000
	str_arr2 	: resb 10000
	str_arr3 	: resb 10000

	str_len1	: resd 1
	str_len2	: resd 1
	str_len3	: resd 1
	temp1		: resd 1
	temp2		: resd 1
	t			: resd 1
section .text
	global main
	main:
		
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		push dword[stdin]
		push dword 100
		push string1
		call fgets

		push dword[stdin]
		push dword 100
		push string2
		call fgets	
	
		push dword[stdin]
		push dword 100
		push string3
		call fgets

		call store_1
		call store_2
		call store_3

	;	call sort_array_1

		call find_array_1

		call print_1
		;call print_2
		;call print_3

		mov eax,1
		mov ebx,0
		int 80h

find_array_1:
	pusha
	push ebp
	mov ebp,esp
	mov esi,0
	mov edi,0
	mov ecx,str_arr1
	mov edx,str_arr2
	mov ebx,str_arr3
	find_array_o_loop:
	
	mov edi,0
	mov ecx,str_arr1

		find_array_i_loop:
		
		mov dword[temp1],ecx
		mov dword[temp2],edx

		push ecx
		push edx
		call strcmp

		mov ecx,dword[temp1]
		mov edx,dword[temp2]

		mov dword[t],eax
		cmp dword[t],0
		jne cont

		mov dword[temp1],ebx
		mov dword[temp2],ecx

		push ebx
		push ecx
		call strcpy
		
		mov ebx,dword[temp1]
		mov ecx,dword[temp2]
		
		add ebx, 100
		jmp inner_fin
		cont:
		
		inc edi
		add ecx, 100
		mov eax,dword[str_len1]
		cmp edi,eax
		jb find_array_i_loop
	inner_fin:
	inc esi
	add edx,100
	mov eax,dword[str_len2]
	cmp esi,eax
	jb find_array_o_loop

	mov esp,ebp
	pop ebp
	popa
	ret

sort_array_1:
	pusha
	push ebp
	mov ebp,esp

	push strcmp
	push dword 100
	push dword[str_len1]
	push str_arr1
	call qsort

	mov esp,ebp
	pop ebp
	popa
	ret

print_3:
	pusha
	push ebp
	mov ebp,esp
	mov esi,0
	mov edi,str_arr3
	
	print_3_loop:
	
	push dword[stdout]
	push edi
	call fputs

	push dword[stdout]
	push space
	call fputs

	add edi,100
	inc esi
	
	cmp esi,dword[str_len3]
	jb print_3_loop

	push dword[stdout]
	push newline
	call fputs

	mov esp,ebp
	pop	ebp
	popa
	ret


print_2:
	pusha
	push ebp
	mov ebp,esp
	mov esi,0
	mov edi,str_arr2
	
	print_2_loop:
	
	push dword[stdout]
	push edi
	call fputs

	push dword[stdout]
	push space
	call fputs

	add edi,100
	inc esi
	
	cmp esi,dword[str_len2]
	jb print_2_loop

	push dword[stdout]
	push newline
	call fputs

	mov esp,ebp
	pop	ebp
	popa
	ret


print_1:
	pusha
	push ebp
	mov ebp,esp
	mov esi,0
	mov edi,str_arr1
	
	print_1_loop:
	
	push dword[stdout]
	push edi
	call fputs

	push dword[stdout]
	push space
	call fputs

	add edi,100
	inc esi
	
	cmp esi,dword[str_len1]
	jb print_1_loop

	push dword[stdout]
	push newline
	call fputs

	mov esp,ebp
	pop	ebp
	popa
	ret

store_3:
	pusha
	push ebp
	mov ebp,esp
	mov edi,str_arr3
	mov dword[str_len3],0

	push delim
	push string3
	call strtok
	mov dword[t],eax
	
	store_3_loop:
	
	push dword[t]
	push edi
	call strcpy

	inc dword[str_len3]
	add edi,100
	
	push delim
	push dword 0
	call strtok

	mov dword[t],eax

	cmp dword[t],0
	jne store_3_loop


	mov esp,ebp
	pop ebp
	popa
	ret

store_2:
	pusha
	push ebp
	mov ebp,esp
	mov edi,str_arr2
	mov dword[str_len2],0

	push delim
	push string2
	call strtok
	mov dword[t],eax
	
	store_2_loop:
	
	push dword[t]
	push edi
	call strcpy

	inc dword[str_len2]
	add edi,100
	
	push delim
	push dword 0
	call strtok

	mov dword[t],eax

	cmp dword[t],0
	jne store_2_loop


	mov esp,ebp
	pop ebp
	popa
	ret
	
store_1:
	pusha
	push ebp
	mov ebp,esp
	mov edi,str_arr1
	mov dword[str_len1],0

	push delim
	push string1
	call strtok
	mov dword[t],eax
	
	store_1_loop:
	
	push dword[t]
	push edi
	call strcpy

	inc dword[str_len1]
	add edi,100
	
	push delim
	push dword 0
	call strtok

	mov dword[t],eax

	cmp dword[t],0
	jne store_1_loop


	mov esp,ebp
	pop ebp
	popa
	ret
