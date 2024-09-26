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
	
;PRINTING THE ARRAY
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,size_msg2
	int 80h
	
	mov esi,array
	mov edi,0
	
loop2:
	;mov al,byte[temp]
	mov cl,byte[esi+edi]
	mov byte[num],cl
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	call print_num
	inc edi
	;mov dword[tempn],eax
	mov eax,0
	mov eax,edi
	cmp al,byte[n]
	jb loop2

	mov eax,1
	mov ebx,0
	int 80h	
	
	

;-----------FUNCTION-------------
print_num:
	pusha 
	mov byte[count],0
loop_num:
	mov bl,10
	mov ax,0
	mov al,byte[num]
	div bl
	cmp al,0
	je end_loop_num
	mov byte[num],al
	mov al,ah
	mov ah,0
	push ax
	inc byte[count]
	jmp loop_num
	
end_loop_num:
	mov al,ah
	mov ah,0
	push ax
	inc byte[count]
loop_print:
	cmp byte[count],0
	je end_loop_print
	pop bx
	dec byte[count]

	mov byte[temp],bl
	add byte[temp],30h
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	
	jmp loop_print

end_loop_print:
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
	
	
