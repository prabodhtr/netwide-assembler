;Reading two single digit numbers,adding and printing the solution

section .data
	msg1 : db 'Enter first number'
	size_msg1 : equ $-msg1

	msg2 : db 'Enter second number'
	size_msg2 : equ $-msg2

	;msg2 : db 'n-1 numbers are :'
	;size_msg2 : equ $-msg2

section .bss
	number1 : resb 1
	number2 : resb 1
	junk : resb 1

	answer1 : resb 1
	answer2 : resb 1

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

		sub byte[number1],30h
		sub byte[number2],30h
		mov ax,word[number1]
		add ax,word[number2]

		mov bl,10
		mov ah,0
		div bl

		mov byte[answer1],ah
		mov byte[answer2],al
		
		add byte[answer1],30h
		add byte[answer2],30h

		mov eax,4
		mov ebx,1
		mov ecx,answer2
		mov edx,1

	int 80h
		mov eax,4
		mov ebx,1
		mov ecx,answer1
		mov edx,1

	int 80h
	
		mov eax,1
		mov ebx,0

	int 80h
