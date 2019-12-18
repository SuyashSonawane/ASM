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

section .data
	msg0 db 10,"Positive and Negative elements from 64bit array"
	msg0_len equ $- msg0
	msg1 db 10,"the number of positive elements are : "
	msg1_len equ $- msg1
	msg2 db 10,"the number of negative elements are :"
	msg2_len equ $- msg2
	

section .text
	global _start
	_start:
		print msg0,msg0_len
		 print msg1,msg1_len
		print msg2,msg2_len
		exit
       
