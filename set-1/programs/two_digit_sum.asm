;ADDING TWO TWO DIGIT NUMBERS

section .data
	msg1 : db 'enter the first digit of first number :'
	size_msg1 : equ $-msg1

	msg2 : db 'enter the second digit of first number :'
	size_msg2 : equ $-msg2

	msg3 : db 'enter the first digit of second number :'
	size_msg3 : equ $-msg3
	
	msg4 : db 'enter the second digit of second number :'
	size_msg4 : equ $-msg4

section .bss
	n1_d1 : resb 1
	n1_d2 : resd 1
	n2_d1 : resb 1
	n2_d2 : resb 1
	n1	  : resd 1
	n2	  : resd 1
	junk : resb 1
	ans1 : resb 1
	ans2 : resb 1
	ans3 : resb 1

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
		mov ecx,n1_d1
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
		mov ecx,n1_d2
		mov edx,1
	int 80h

		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1
	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,size_msg3
		
	int 80h
		mov eax,3
		mov ebx,0
		mov ecx,n2_d1
		mov edx,1
	int 80h

		mov eax,3
		mov ebx,0
		mov ecx,junk
		mov edx,1
	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,size_msg4
	int 80h

		mov eax,3
		mov ebx,0
		mov ecx,n2_d2
		mov edx,1
	int 80h
	
		sub byte[n1_d1],30h
		sub byte[n1_d2],30h
		sub byte[n2_d1],30h
		sub byte[n2_d2],30h

		mov al,byte[n1_d1]
		mov ah,0
		mov bl,10
		mul bl

		mov bl,byte[n1_d2]
		mov bh,0
		add ax,bx
		mov word[n1],ax
		
		mov al,byte[n2_d1]
		mov ah,0
		mov bl,10
		mul bl

		mov bl,byte[n2_d2]
		mov bh,0
		add ax,bx
		
		add word[n1],ax

		mov bl,100
		mov ax,word[n1]
		div bl
		mov byte[ans1],al

		mov al,0
		mov al,ah
		mov ah,0

		mov bl,10
		div bl
		mov byte[ans2],al
		mov byte[ans3],ah

		add byte[ans1],30h
		add byte[ans2],30h
		add byte[ans3],30h

		mov eax,4
		mov ebx,1
		mov ecx,ans1
		mov edx,1
	int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,ans2
		mov edx,1
	int 80h

		mov eax,4
		mov ebx,1
		mov ecx,ans3
		mov edx,1
	int 80h

		mov eax,1
		mov ebx,0
	int 80h
