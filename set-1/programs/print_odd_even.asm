;PRITING WHETHER A NUMBER IS ODD OR EVEN

section .data
	msg1 : db 'Enter the number'
	size_msg1 : equ $-msg1

	msg2 : db 'Even'
	size_msg2 : equ $-msg2

	msg3 : db 'Odd'
	size_msg3 : equ $-msg3

section .bss
	num : resb 1
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
		mov ecx,num
		mov edx,1
	int 80h
		
		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1
	int 80h
		
		sub byte[num],30h
		mov bl,2
		mov ah,0
		mov al,byte[num]
		div bl
		cmp ah,0
			je L1
		
			mov eax,4
			mov ebx,1
			mov ecx,msg3
			mov edx,size_msg3
		int 80h
			jmp L2
		L1 :
			mov eax,4
			mov ebx,1
			mov ecx,msg2
			mov edx,size_msg2
		int 80h
	L2:
		mov eax,1
		mov ebx,0
	int 80h


