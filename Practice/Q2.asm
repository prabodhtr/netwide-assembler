section .data
	msg1 : db 'Enter the total number of elements: '
	size_msg1 : equ $-msg1

	msg2 : db 'Enter the elements :',10
	size_msg2 : equ $-msg2

	newline : db 10

section .bss
	data  : resw 1
	num   : resw 1
	n	  :	resw 1
	array : resw 100
	temp  : resb 1
	count : resb 1
	smallest : resw 1
	index : resb 1
	n1    : resw 1
	array2: resw 1

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

		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size_msg2
		int 80h
		call read_array
		call traverse_array
	;	call sort_array

		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h

		call print_array

		mov eax,1
		mov ebx,0
		int 80h

traverse_array:
		pusha
		mov edi,0
	loop1:
		mov ax,word[array + 2*edi]
		mov word[num],ax
		call get_add
		mov ax,word[num]
		;mov eax,1
		;movzx ebx,word[num]
		;int 80h
		mov word[array2 + 2*edi],ax
		inc edi
		movzx eax,word[n]
		cmp edi,eax
		jb loop1

		popa
ret

get_add:
		pusha
		mov byte[count],0
	get_add_push:
		mov eax,0
		mov ebx,0
		mov dx,0
		mov ax,word[num]
		mov bx,10
		div bx
		push dx
		inc byte[count]
		mov word[num],ax
		cmp ax,0
		je get_add_pop
		jmp get_add_push
	get_add_pop:
		mov edx,0

		pop dx
		dec byte[count]
			
		add word[num],dx

		cmp byte[count],0
		je get_add_pop_end

		jmp get_add_pop

	get_add_pop_end:
		popa
ret

sort_array:
		pusha
		mov edi,0
		mov edx,0
	sort_array_outer:
		mov edx,edi
		mov word[smallest],200
	sort_inner_array:
		mov ax,word[array2 + 2*edx]
		cmp ax,word[smallest]
		ja L1
		mov byte[index],dl
		mov word[smallest],ax
	L1:
		inc edx
		movzx eax,word[n]
		cmp edx,eax
		jb sort_inner_array
		
		movzx edx,byte[index]
		
		;swap
		mov ax,word[array2 + 2*edi]
		mov bx,word[array2 + 2*edx]
		cmp ax,bx
		je cmp1
	cmp1:
		mov ax,word[array + 2*edi]
		mov bx,word[array + 2*edx]
		cmp ax,bx
		ja cmp2
	cmp2:
		

		inc edi
		movzx eax,word[n]
		cmp edi,eax
		jb sort_array_outer
		
		popa
ret

read_num:
		pusha
		mov word[num],0
	read_num_L1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h

		cmp byte[temp],10
		je read_num_end

		sub byte[temp],30h
		
		mov ax,0
		mov bx,0
		mov dx,0

		mov ax,word[num]
		mov bx,10
		mul bx
		add al,byte[temp]
		mov word[num],ax
		jmp read_num_L1

	read_num_end:
		popa
ret

read_array:
		pusha
		mov edi,0
	read_array_L1:
		call read_num

		mov ax,word[num]
		mov word[array + 2*edi],ax
		movzx eax,word[n]
		inc edi

		cmp edi,eax
		jb read_array_L1

		popa
ret

print_num:
		pusha
		mov byte[count],0
	print_num_push:
		mov eax,0
		mov ebx,0
		mov dx,0
		mov ax,word[num]
		mov bx,10
		div bx
		push dx
		inc byte[count]
		mov word[num],ax
		cmp ax,0
		je print_num_pop
		jmp print_num_push
	print_num_pop:
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
		je print_num_pop_end

		jmp print_num_pop

	print_num_pop_end:
		popa
ret
		

print_array:
		pusha
		mov edi,0
	print_array_L1:
		mov eax,0
		mov ax,word[array2 + 2*edi]
		mov word[num],ax
		call print_num

		pusha
		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h
		popa

		mov eax,0
		movzx eax,word[n]
		inc edi

		cmp edi,eax
		jb print_array_L1

		popa
ret
