section .data
	msg1 : db "Enter the string :",10
	size_msg1 : equ $-msg1

	msg2 : db "The new string is :",10
	size_msg2 : equ $-msg2
	print_s : db "%s",10,0
	newline: db 10,0
section .bss
	string1 : resb 100
	string2 : resb 100
	temp_string : resb 100
	length : resb 1
	temp   : resb 1	
	loc    : resd 1
section .text
	global main
	extern printf
	extern fgets
	extern stdin
	extern stdout
	extern fputs
	extern strcat
	extern strstr
	extern strlen
	main:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		call scan_string1
		call scan_string2

		call cat

		call find_newline
	
		mov ebx, dword[loc]
		mov byte[ebx], 32
		
		call find_newline
	
		mov ebx, dword[loc]
		mov byte[ebx], 65
		inc ebx
		mov byte[ebx], 10
		inc ebx
		mov byte[ebx], 0


		call print_new

		push string1
		call strlen
		mov byte[length],al

		mov eax,1
		movzx ebx,byte[length]
		int 80h

find_newline:
	push ebp
	pusha

	mov ebp,esp
	push newline
	push string1
	call strstr
	mov dword[loc],eax
	mov esp,ebp
	popa
	pop ebp

	ret

cat:
	push ebp
	pusha

	mov ebp,esp
	push string2
	push string1
	call strcat
	mov esp,ebp
	popa
	pop ebp
	
	ret


print_new :
	pusha
	push ebp

	mov ebp,esp
	push dword[stdout]
	push string1
	call fputs

	mov esp,ebp

	pop ebp
	popa
	ret
	
scan_string2:
	push ebp
	pusha

	mov ebp,esp

	push dword[stdin]
	push dword 100
	push string2
	call fgets
	
	mov esp,ebp

	popa
	pop ebp

	ret
scan_string1:
	push ebp
	pusha

	mov ebp,esp

	push dword[stdin]
	push dword 100
	push string1
	call fgets
	
	mov esp,ebp

	popa
	pop ebp

	ret
