section .data
	nline db 10,10
	nline_len equ $-nline
	an0 db "Asssignment 1",10
	db "+ and - counter ",10
	ano_len equ $-an0

	array dq 1111111H,-2222222H,3333333H,-4444444H
	n equ 4
	msg0 db 10,"Positive and Negative elements from 64bit array"
	msg0_len equ $- msg0
	msg1 db 10,"the number of positive elements are : "
	msg1_len equ $- msg1
	msg2 db 10,"the number of negative elements are :"
	msg2_len equ $- msg2


; A macro with 2 parameters
%macro print 2
    mov rax ,1
    mov rdi, 1
    mov rsi ,%1
    mov rdx ,%2
    syscall
%endmacro
%macro exit 0
    	mov rax ,60
        mov rdi ,0
        syscall
%endmacro

section .text
global _start
_start:

	print an0,an0_len
	mov rbx,0
	mov rcx,n
	mov rdx,0

	next_num:
		mov rax,[rsi]
		rol rax , 1
		jc negative

	positive:
		inc rbx
		jmp next

	negative :
		inc rdx

	next:
		add rsi ,8
		dec rcx
		jnz next_num
		mov [p_count],rbx
		mov [n_count],rdx
		print msg1,msg1_len
		mov rax,[p_count]
		call Display

		print pmsg2,pmsg2_len
		mov rax,[n-count]
		call Display


	exit

