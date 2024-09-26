section .data
	msg1 : db 'What is your name :'
	size_msg1 : equ $-msg1
	msg2 : db 'Your name is :'
	size_msg2 : equ $-msg2
		
section .bss
	name : resb 1
	size : resb 1
	junk : resb 1

section .text
	global _start
	
	_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1

	int 80h
		
		mov eax,3
		mov ebx,0
		mov ecx,name
		mov edx,size

	int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size_msg2

	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,name
		mov edx,size
	
	int 80h

		mov eax,1
		mov ebx,0

	int 80h
