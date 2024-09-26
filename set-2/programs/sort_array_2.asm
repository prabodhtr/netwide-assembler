section .data
msg1 : db 'Enter the total number of elements :'
size_msg1 : equ $-msg1

msg2 : db 'Enter the array elements :'
size_msg2 : equ $-msg2

newline : db 10

section .bss
n     : resb 1
junk  : resb 1
num   : resw 1
array : resw 100
temp  : resb 1
count : resb 1

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
	mov ecx,n
	mov edx,1
	int 80h

	sub byte[n],30h	

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

	call read_array
;	call bubble_sort
	call print_array
	
	
	mov eax,1
	mov ebx,0
	int 80h

print_array:
	pusha
	mov edi,0
print_array_loop1:
	mov word[num],0
	mov eax,0
	mov ax,word[array + 2*edi]
	mov word[num],ax
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
	call print_num
	inc edi
	movzx eax,byte[n]
	cmp edi,eax
	jb print_array_loop1
	popa
	ret

print_num:
	pusha
	mov byte[count],0
print_num_loop1:
	mov eax,0
	mov edx,0
	mov ebx,0
	mov ax,word[num]
	mov bx,10
	div bx
	push dx
	inc byte[count]
	
	cmp ax,0
	je print_num_loop2
	
	mov word[num],ax
	jmp print_num_loop1
print_num_loop2:
	mov edx,0
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
	je print_num_loop2_end
	
	jmp print_num_loop2
print_num_loop2_end:
	popa
	ret

read_array:
	pusha
	mov edi,0
read_array_loop1:
	mov word[num],0
	call read_num
	mov eax,0
	mov ax,[num]
	mov word[array + 2*edi],ax
	inc edi
	mov eax,0
	movzx eax,byte[n]
	cmp edi,eax
	jb read_array_loop1
	popa
	ret

read_num:
	pusha
read_num_loop1:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h

	cmp byte[temp],10
	je read_num_loop1_end

	sub byte[temp],30h
	mov ax,word[num]
	mov bx,10
	mul bx
	add al,byte[temp]
	mov [num],ax
	jmp read_num_loop1
	
read_num_loop1_end:
	popa
	ret
