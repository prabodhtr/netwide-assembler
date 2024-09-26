section .data
	msg1 : db 'Enter the total number of rows and columns'
	size_msg1 : equ $-msg1

	msg2 : db 'Enter the matrix :',10
	size_msg2 : equ $-msg2

	msg3 : db ' '
	size_msg3 : equ $-msg3
	newline : db 10

section .bss
	n 		: resw 1
	m 		: resw 1
	num 	: resw 1
	temp 	: resb 1
	count 	: resb 1
	array	: resw 10000
	size	: resw 1
	i		: resw 1
	j		: resw 1
section .text
	global _start
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,size_msg1
	int 80h

	call read_num
	mov ax,word[num]
	mov word[n],ax

	call read_num
	mov ax,word[num]
	mov word[m],ax

	mov ax,word[n]
	mov bx,word[m]
	mul bx
	mov word[size],ax

	call read_matrix

	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h

	call print_matrix
	mov eax,1
	mov ebx,0
	int 80h

print_num:
	pusha
	mov byte[count],0
print_num_l1:
	mov ax,word[num]
	mov dx,0
	mov bx,10
	div bx
	push dx
	inc byte[count]
	mov word[num],ax
	cmp ax,0
	je print_num_pop

	jmp print_num_l1

print_num_pop:
	pop dx
	dec byte[count]
	mov byte[temp],dl
	add byte[temp],30h

	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h

	cmp byte[count],0
	je print_num_end

	jmp print_num_pop
print_num_end:
	popa	
	ret
	
read_matrix:
	pusha
	CLD
	mov edi,array
	movzx ecx,word[size]
read_matrix_loop:		
	call read_num
	mov ax,word[num]
	STOSW
	loop read_matrix_loop

	popa
	ret


print_matrix:
	pusha
	mov esi,0
	movzx ecx,word[size]

print_matrix_l1:
	mov ax,word[array + 2*esi]
	mov word[num],ax
	call print_num
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,size_msg3
	int 80h
	popa

	mov eax,esi
	mov bx,word[m]
	inc eax
	mov edx,0
	div bx
	cmp dx,0
	jne l1
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
l1:
	inc esi
	cmp esi,ecx
	jb print_matrix_l1
	popa
	ret

read_num:
	pusha
	mov word[num],0

read_num_l1:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h

	cmp byte[temp],10
	je read_num_end

	sub byte[temp],30h

	mov ax,word[num]
	mov bx,10
	mul bx
	add al,byte[temp]
	mov word[num],ax
	jmp read_num_l1

read_num_end:
	popa
	ret
