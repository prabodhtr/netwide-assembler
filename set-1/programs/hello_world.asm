section .data
	string : db 'Hello World!' ,0ah
	size_string : equ $-string


section .text
	global _start
	_start :
		mov eax,4
		mov ebx,1
		mov ecx,string
		mov edx,size_string	
	int 80h
		mov eax,1
		mov ebx,0
	int 80h
