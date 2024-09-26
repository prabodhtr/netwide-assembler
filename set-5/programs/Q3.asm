section .data
	msg1 		: db "Enter the total number of elements :"
	size_msg1 	: equ $-msg1
	input_num 	: db "%d",0
	input_float : db "%f",0
	print_float : db "%lf",10,0
	msg2 		: db "The array is :",10
	size_msg2 	: equ $-msg2

section .bss
	array 		: resd 10
	num   		: resw 1
	temp_float	: resd 1
	avg			: resd 1
	num_dec 	: resw 1
section .text
	global main
	extern scanf
	extern printf
	main:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,size_msg1
	int 80h

	call read_num

	call read_float

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,size_msg2
	int 80h

	;call calculate_avg
	;call print_float_f
	mov ax,word[num]
	dec ax
	mov word[num_dec],ax
;	call sort
	call print_float_f


	mov eax,1
	mov ebx,0
	int 80h

sort:
	pusha	
	mov esi,0
	mov edi,0
	loop1_sort:
		mov edi,0
		loop2:
			fld dword[array + edi * 4]
			fcomp dword[array + edi *4 +4]
			fstsw ax
			sahf
			ja swap
			jmp cont
			swap:
				fld dword[array + edi*4]
				fld dword[array + edi*4 +4]
				fstp dword[array + edi*4]
				fstp dword[array + edi*4 +4]
			cont:
				inc edi
				movzx eax,word[num_dec]
				cmp edi,eax
				jb loop2
		inc esi
		movzx eax,word[num]
		cmp esi,eax
		jb loop1_sort
	
	popa
	ret

				
				
		

calculate_avg:
	mov esi,0
	fldz
	fstp dword[avg]
	pusha
	
	loop1:
		mov eax,dword[array + esi*4]	
		mov dword[temp_float],eax
		fld dword[temp_float]
		fadd dword[avg]
		fstp dword[avg]
		inc esi
		movzx eax,word[num]
		cmp esi,eax
		jb loop1
	
	fld dword[avg]
	movzx eax,word[num]
	mov dword[temp_float],eax
	fidiv dword[temp_float]
	fstp dword[avg]
	popa
	ret

print_float_f:
	mov esi,0
	push ebp
	pusha

	print_float_loop1:
		mov ebp,esp
		sub esp,8
		mov eax,dword[array + esi*4]
		mov dword[temp_float],eax
		fld dword[temp_float]
		;fld dword[avg]
		fstp qword[ebp-8]
		push print_float
		call printf
		mov esp,ebp
		inc esi
		movzx eax,word[num]
		cmp esi,eax
		jb print_float_loop1

	pop ebp
	popa
	ret

read_float:
	mov esi,0
	push ebp
	pusha

	read_float_loop1:
		mov ebp,esp
		sub esp,4
		lea eax,[ebp-4]
		push eax
		push input_float
		call scanf
		fld dword[ebp-4]
		fstp dword[array + esi*4]
		;mov eax,dword[temp_float]
		;mov dword[array + esi*4],eax
		mov esp,ebp
		inc esi
		movzx eax,word[num]
		cmp esi,eax
		jb read_float_loop1

	popa
	pop ebp
	ret

read_num:
	pusha
	push ebp
	mov ebp,esp
	sub esp,2
	lea eax,[ebp-2]
	push eax
	push input_num
	call scanf
	mov ax,word[ebp-2]
	mov word[num],ax
	mov esp,ebp
	pop ebp
	popa
	ret
