;PRINTING LARGEST OUT OF TWO ONE DIGIT NUMBER

section .data
	msg1 : db 'Enter the first number :'
	size_msg1 : equ $-msg1

	msg2 : db 'Enter the second number :'
	size_msg2 : equ $-msg2

section .bss
	number1 : resb 1
	number2 : resb 1
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
		mov ecx,number1
		mov edx,1
	int 80h
	
		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1
	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size_msg2
	int 80h

		mov eax,3
		mov ebx,0
		mov ecx,number2
		mov edx,1
	int 80h

		;sub byte[number1],30h
		;sub byte[number2],30h
		mov al,byte[number2]
		cmp byte[number1],al
		ja L1
			mov eax,4
			mov ebx,1
			mov ecx,number2
			mov edx,1
			int 80h
			jmp L2
		L1 :
			mov eax,4
			mov ebx,1
			mov ecx,number1
			mov edx,1
			int 80h

		L2 :
		mov eax,1
		mov ebx,0
	int 80h

