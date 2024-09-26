section .data
	msg_1 : db 'Enter first number'
	size_msg_1 : equ $-msg_1
	
	msg_2 : db 'Enter second number'
	size_msg_2 : equ $-msg_2
	
section .bss
	
	num_1 : resb 1
	num_2 : resb 1
	ans_1 : resb 1
	ans_2 : resb 1
	junk : resb 1

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
		mov ecx,num_1
		mov edx,1
	int 80h
	
		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1

	int 80h
				
		mov eax,4
		mov ebx,1
		mov ecx,msg_2
		mov edx,size_msg_2
	
	int 80h

		mov eax,3
		mov ebx,0
		mov ecx,num_2
		mov edx,1
		
	int 80h
		
		sub byte[num_1],30h
		sub byte[num_2],30h
		mov ax,word[num_1]
		add ax,word[num_2]

		mov bl,10
		mov ah,0
		div bl
		
		mov byte[ans_1],al
		mov byte[ans_2],ah
	
		add byte[ans_1],30h
		add byte[ans_2],30h
	
	int 80h
					
		mov eax,4
		mov ebx,1
		mov ecx,ans_1
		mov edx,1
	
	int 80h
				
		mov eax,4
		mov ebx,1
		mov ecx,ans_2
		mov edx,1
	int 80h
	
		mov eax,1
		mov ebx,0
	
	int 80h	

