section.data
	msg0 db 10,"ASSIGNMENT 2A",10
	msg0_len equ $- msg0
	msg1 db 10,"Before Transfer",10
	msg1_len equ $- msg1
	msg2 db 10,"After Transfer",10
	msg2_len equ $- msg2
	msg3 db 10,"Source Block",10
	msg3_len equ $-msg3
	msg4 db 10,"Destination Block",10
	msg4_len equ $-msg4


	array dq 11111111H,-22222222H,33333333H,-44444444H
	n equ 4

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
			print msg0,msg0_len
			print msg1,msg1_len
			print msg2,msg2_len
			print msg3,msg3_len
			print msg4,msg4_len

		exit

