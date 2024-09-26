section .data
	msg1 : db 'Enter string :'
	size_msg1 : equ $-msg1

	msg2 : db 'Length is :'
	size_msg2: equ $-msg2

	newline : db 10
section .bss
	array : resb 100
	length : resb 1
	temp  : resb 1

section .text
	global _start
	_start:

		mov eax,1
		mov ebx,'a'
		int 80h

		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		call read_string

		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size_msg2
		int 80h

		add byte[length],30h
		mov eax,4
		mov ebx,1
		mov ecx,length
		mov edx,1
		int 80h

		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h
	
		call print_string
	
		mov eax,1
		mov ebx,0
		int 80h

read_string:
		pusha
		mov byte[length],0
		mov esi,0
	loop1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h

		cmp byte[temp],10
		je end_read

		
		mov cl,byte[temp]
		mov byte[array + esi],cl
		inc esi
		inc byte[length]
		jmp loop1

	end_read:
		mov byte[array + esi],0
		popa
		ret

print_string:
		pusha
		mov esi,0
	loop1_print:
		mov cl,byte[array + esi]
		mov byte[temp],cl

		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h

		inc esi
		movzx eax,byte[length]
		cmp esi,eax
		jb loop1_print
		popa
		ret
