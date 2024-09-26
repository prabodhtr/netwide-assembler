
section .data
	msg_1 : db 'Enter your name :'
	size_msg_1 : equ $-msg_1
	msg_2 : db 'Your name is :'
	size_msg_2 : equ $-msg_2
	
section .bss
	name : resb 1
	size_name : resb 1

section .text
	global _start:
	_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg_1
		mov edx,size_msg_1
		
	int 80h
		
		mov eax,3
		mov ebx,0
		mov ecx,name
		mov edx,10
	int 80h
	
		mov eax,4
		mov ebx,1
		mov ecx,msg_2
		mov edx,size_msg_2
		
	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,name
		mov edx,10
	
	int 80h
	
		mov eax,1
		mov ebx,0
	
	int 80h
		
