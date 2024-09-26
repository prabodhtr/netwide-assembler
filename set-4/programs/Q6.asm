extern printf
extern fgets
extern stdin
extern stdout
extern fputs
extern strcat
extern strstr
extern strlen
extern strtok

section .data
	msg1 : db "Enter the string :",10
	size_msg1 : equ $-msg1

	msg2 : db "The new string is :",10
	size_msg2 : equ $-msg2
	print_s : db "%s",10,0
	newline: db 10,0
	an : db "an",0
section .bss
	string1 : resb 100
	string2 : resb 100
	temp_string : resb 100
	length : resb 1
	temp   : resb 1	
	loc    : resd 1
	new_string : resb 100
	s_index : resb 1
	l_index : resb 1
	index : resb 1
section .text
	global main

	main:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		call scan_string1

		push string1
		call strlen
		mov byte[length],al
		dec byte[length]

		call add_an
		call print_new

		mov eax,1
		mov ebx,0
		int 80h

add_an_final:
	pusha
	movzx esi,byte[length]
	add esi,2

	add_an_loop:
		mov al,byte[string1 + esi]
		mov byte[string1 + esi +3],al

		dec esi
		movzx ebx,byte[index]
		cmp esi,ebx
		jnl add_an_loop

	movzx esi,byte[index]

	mov byte[string1 + esi + 0],'a'
	mov byte[string1 + esi + 1],'n'
	mov byte[string1 + esi + 2],' '

	add byte[length],3
	popa
	ret

add_an:
	pusha
	
	mov esi,0
	mov byte[temp],0
	loop1:
		mov al,byte[string1 + esi]
		cmp al,' ' 
		jne cont

		movzx eax,byte[temp]
		mov byte[temp],-1

		mov edx,esi

		sub edx,eax
		mov byte[index],dl
		mov bl,byte[string1 + edx]
		
		cmp bl,'a'
		je a

		cmp bl,'i'
		je a

		cmp bl,'e'
		je a

		cmp bl,'o'
		je a

		cmp bl,'u'
		je a

		jmp cont
		a:
			call add_an_final
			add esi,3
	
		cont:
			inc esi
			inc byte[temp]
			movzx eax,byte[length]
			cmp esi,eax
			jb loop1
	
		movzx eax,byte[temp]

		sub esi,eax

		mov eax,esi

		;mov ebx,eax
		;mov eax,1
		;int 80h

		mov byte[index],al
		mov bl,byte[string1 + eax]

		cmp bl,'a'
		je b

		cmp bl,'e'
		je b

		cmp bl,'i'
		je b

		cmp bl,'o'
		je b

		cmp bl,'u'
		je b

		jmp exit

		b:
			call add_an_final
			add esi,3
	exit:
	popa
	ret


find_newline:
	push ebp
	pusha

	mov ebp,esp
	push newline
	push string1
	call strstr
	mov dword[loc],eax
	mov eax,dword[loc]
	mov eax,' '
	mov esp,ebp
	popa
	pop ebp

	ret

cat:
	push ebp
	pusha

	mov ebp,esp
	push string2
	push string1
	call strcat
	mov esp,ebp
	popa
	pop ebp
	
	ret


print_new :
	pusha
	push ebp

	mov ebp,esp
	push dword[stdout]
	push string1
	call fputs

	mov esp,ebp

	pop ebp
	popa
	ret
	
scan_string2:
	push ebp
	pusha

	mov ebp,esp

	push dword[stdin]
	push dword 100
	push string2
	call fgets
	
	mov esp,ebp

	popa
	pop ebp

	ret
scan_string1:
	push ebp
	pusha

	mov ebp,esp

	push dword[stdin]
	push dword 100
	push string1
	call fgets
	
	mov esp,ebp

	popa
	pop ebp

	ret
