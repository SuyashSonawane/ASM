section.data:

	msg0 db 10,"ASSIGNMENT 2A",10
	msg0_len equ $- msg0

	msg1 db 10,"Before Transfer",10
	msg1_len equ $- msg1

	msg2 db 10,"After Transfer"
	msg2_len equ $- msg2

	msg3 db 10,"Source Block",10
	msg3_len equ $-msg3

	msg4 db 10,"Destination Block",10
	msg4_len equ $-msg4

	space db " " 

	sblock db 11H,22H,33H,44H,55H
	dblock times 5 db 0


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


section .bss

	p_count resq 1
	n_count resq 1
	char_ans resb 16





section .text
	global _start
		_start:
			print msg0,msg0_len    ;ASS 2A
			print msg1,msg1_len    ;Before Transfer
		
			print msg3,msg3_len    ;Source
			mov rsi, sblock
			call Display_block

			print msg4,msg4_len		;Destination
			mov rsi ,dblock
			call Display_block
			print msg2,msg2_len       ;After Transfer
			
			call Block_transfer
			
			print msg3,msg3_len    ;Source
			mov rsi, sblock
			call Display_block

			

			print msg4,msg4_len		;Destination
			mov rsi ,dblock
			call Display_block

		exit


Display_block:
	mov rbp , 5
	next_num:
		mov al,[rsi]
		push rsi
		call Display
		print space , 1
		pop rsi
		inc rsi
		dec rbp
		jnz next_num
	ret


Block_transfer:
	mov rsi ,sblock
	mov rdi ,dblock
	mov rcx ,5
	back:
		mov al,[rsi]
		mov [rdi],al
		inc rsi
		inc rdi
		dec rcx
		jnz back
	ret


Display:
	mov rbx , 16
	mov rcx ,2
	mov rsi , char_ans+1

	cnt:
		mov rdx,0
		div rbx
		cmp dl,09h
		jbe add30
		add dl ,07h

	add30:
		add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz cnt
		print char_ans,2


	ret