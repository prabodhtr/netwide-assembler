section .data
	msg1 : db "Enter the number :"
	size_msg1 : equ $-msg1
	in_msg1 : db "%d",0
	msg2 : db "The number is : %d",10,0

section .bss
	num : resd 1
section .text 
	global main
	extern scanf
	extern printf

	main:

		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size_msg1
		int 80h

		call read

		call print

		mov eax,1
		mov ebx,0
		int 80h
		
read:
	push ebp
	mov ebp,esp
	;sub esp,8
	;lea eax,[ebp-8]
	;push eax
	push num
	push in_msg1
	call scanf
;	mov eax,dword[ebp-8]
;	mov dword[num],eax
;	fld dword[ebp-8]
	mov esp,ebp
	pop ebp
	ret

print:
	push ebp
	mov ebp,esp
;	sub esp,8
;	push qword[num]
;	fst qword[ebp-8]
	push dword[num]
	push msg2
	call printf
	mov esp,ebp
	pop ebp
	ret

