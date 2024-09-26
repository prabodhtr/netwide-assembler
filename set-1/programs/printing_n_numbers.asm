section .data
	msg_1 : db 'Enter the number'
	size_msg_1 : equ $-msg_1
	
	
section .bss
	num : resb 1	
	temp : resb 1
	junk : resb 1
	temp2 : resb 1

section .text

	global _start
	_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg_1
	mov edx,size_msg_1
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
	mov al,0
	mov byte[temp2],0
	L1:
		cmp al,byte[num]
		je L2
		mov byte[temp],al
		add byte[temp],48
			;Printing numbers	
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
		sub byte[temp],30h
		mov al,byte[temp]
		inc al
		jmp L1
	L2:
	
	mov eax,1
	mov ebx,0
int 80h
