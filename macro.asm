; A macro with 2 parameters
%macro write_string 2
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
    msg db 10,"Printed using macros"
    msg_len equ $- msg
	la db 10,"Printed 2 using macros"
    la_len equ $- la

section .text
    global _start
    _start:
        write_string msg,msg_len
  write_string la,la_len
	exit
       
