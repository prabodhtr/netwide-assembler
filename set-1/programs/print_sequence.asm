; Reading a single digit number and printing n-1 numbers

section .data
	msg1 : db 'Enter a number'
	size_msg1 : equ $-msg1

section .bss
	number : resb 1
	variable : resb 1
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
		mov ecx,number
		mov edx,1
	int 80h
		
		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1
	int 80h


		sub byte[number],30h
		mov ah,0
		L1 :
			mov byte[variable],0
			cmp ah,byte[number]
			je L2
			mov byte[variable],ah
			add byte[variable],30h

			mov eax,4
			mov ebx,1
			mov ecx,variable
			mov edx,1
			int 80h
			sub byte[variable],30h
			mov ah,byte[variable]
		

			inc ah
			jmp L1

	L2:
		mov eax,1
		mov ebx,0
	int 80h
