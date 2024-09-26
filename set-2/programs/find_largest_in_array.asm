section .data
msg1 : db 'Enter the number of elements :'
size_msg1 : equ $-msg1
msg2 : db 'Array is',10
size_msg2 : equ $-msg2
newline : db 10


section .bss
n     : resb 1
junk  : resb 1
temp  : resb 1
temp2 : resb 1
num   : resb 1
array : resb 50
count : resb 1
tempn : resw 1
largest : resb 1
A1 : resb 1
A2 : resb 1

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

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

;READ ARRAY
	sub byte[n],30h
	mov eax,array
	mov ebx,0
loop1:
	call read_num
	mov ecx,0
	mov cl,byte[num]
	mov byte[eax+ebx],cl
	inc ebx
	cmp bl,byte[n]
	jb loop1
	
;-------FINDING LARGEST-------

	mov eax,array
	mov ebx,0
	mov byte[largest],0

array_loop:
	mov cl,byte[eax+ebx]
	cmp byte[largest],cl
	ja L1
	mov byte[largest],cl
L1:
	inc ebx
	cmp bl,byte[n]
	jb array_loop

	call print_largest

	mov eax,1
	mov ebx,0
	int 80h

;------------FUNCTION-----------
print_largest:
	pusha
	mov byte[count],0
loop_print:
	mov ax,0
	mov al,byte[largest]
	mov bl,10
	div bl
	mov byte[A1],al
	mov byte[A2],ah
	add byte[A1],30h
	add byte[A2],30h
	mov eax,4
	mov ebx,1
	mov ecx,A1
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,A2
	mov edx,1
	int 80h
	popa
	ret	

;--------FUNCTION-------------
read_num :
	pusha 
	mov byte[num],0
loop:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	
	cmp byte[temp],10
	je end_read
	
	sub byte[temp],30h
	mov ebx,0
	mov bl,10
	mov ax,0
	mov al,byte[num]
	mul bl
	add al,byte[temp]
	mov byte[num],al
	jmp loop
	
end_read:
	popa
	ret
	
	
