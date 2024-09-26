section .data
msg1 : db 'Enter the number of elements :'
size_msg1 : equ $-msg1
msg2 : db 'Enter the array :',10
size_msg2 : equ $-msg2
newline   : db 10

section .bss
n        : resb 1
array    : resb 50
num      : resb 1
temp     : resb 1
count    : resb 1
junk     : resb 1
smallest : resb 1
min_index: resb 1
i        : resb 1
j        : resb 1
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

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,size_msg2
	int 80h

	call read_array
	
	call sort_array
	call print_array

	mov eax,1
	mov ebx,0
	int 80h

;----Sorting array---------
sort_array:
	pusha
	mov eax,array
	mov ebx,0
	mov ecx,0
	

sort_array_outter:
	mov cl,bl

	mov byte[smallest], 255
sort_array_inner:
	mov dl,byte[eax+ecx]
	cmp dl,byte[smallest]
	ja L1
	mov byte[smallest],dl	
	mov byte[min_index],cl 	
L1:
	inc cl
	cmp cl,byte[n]
	jb sort_array_inner
	
;	temp = a[min]
;	a[min] = a[eax+ebx]
;	a[min] = temp

	push ecx	
	mov dh, byte[eax+ebx]
	mov dl, byte[smallest]
	mov byte[eax+ebx], dl
	mov cl, byte[min_index]
	mov byte[eax+ecx], dh	
	pop ecx
	inc bl
	cmp bl,byte[n]
	jb sort_array_outter 
	popa
	ret
;----Printing the array-----

print_array:
	pusha
	mov esi,array
	mov edi,0

print_array_L1:
	mov cl,byte[esi+edi]
	mov byte[num],cl
	call print_num

	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h

	inc edi
	mov eax,edi
	cmp al,byte[n]
	jb print_array_L1
	popa
	ret

;---Printing the number-----
print_num:
	pusha
	mov byte[count],0
print_num_push:
	mov ax,0
	mov al,byte[num]
	mov bl,10
	div bl
	cmp al,0
	je print_num_push_end
	mov byte[num],al
	mov al,ah
	mov ah,0
	push ax
	inc byte[count]
	jmp print_num_push

print_num_push_end:
	mov al,ah
	mov ah,0
	push ax
	inc byte[count]
	
print_num_pop:
	mov ax,0
	pop ax
	dec byte[count]	
	mov byte[temp],al
	add byte[temp],30h
	
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h

	cmp byte[count],0
	je print_num_pop_end
	jmp print_num_pop

print_num_pop_end:
	popa
	ret	
	
;---CALL READ_ARRAY function-----

read_array:
	pusha
	mov eax,array
	mov ebx,0
read_array_L1:
	mov byte[num],0
	call read_num
	mov cl,byte[num]
	mov byte[eax+ebx],cl
	inc ebx
	cmp bl,byte[n]
	jb read_array_L1
	
	popa
	ret
	

;----READING NUMBER FROM USER----		

read_num:
	pusha
read_num_L1:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	
	cmp byte[temp],10
	je read_num_end
	
	sub byte[temp],30h

	mov ah,0
	mov al,byte[num]
	mov bl,10
	mul bl
	add al,byte[temp]
	mov byte[num],al
	jmp read_num_L1
read_num_end:
	popa
	ret
