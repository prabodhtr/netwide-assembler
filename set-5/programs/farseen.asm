section .data
	msg1 : db "Enter the floating point number :"
	size_msg1 : equ $-msg1
	in_msg1 : db "%f",0
	msg2 : db "The number is : %f",10,0

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
		movzx ebx,word[num]
		int 80h
		
read:
	push ebp
	mov ebp,esp
	sub esp,4
	lea eax,[ebp-4]
	push eax
	push in_msg1
	call scanf
	mov eax,dword[ebp-4]
	mov dword[num],eax
;	fld dword[ebp-4]
	mov esp,ebp
	pop ebp
	ret

print:
	push ebp
	mov ebp,esp
	;sub esp,4
	push dword[num]
;	fst dword[ebp-4]
	push msg2
	call printf
	mov esp,ebp
	pop ebp
	ret

