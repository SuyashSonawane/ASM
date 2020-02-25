section .data

	msg0 db 10,"ASSIGNMENT 5",10
	msg0_len equ $- msg0

	msg1 db 10,"1.No of Blank Spaces",10,"2.Occurance of a letter",10,"3.No of Lines",10,"4.Exit",10
	msg1_len equ $- msg1

	invalid_msg db 10,"Invalid Option Entered",10
	invalid_msg_len equ $- invalid_msg

	msg2 db 10,"No of blank Spaces are : ",10
	msg2_len equ $- msg2

	msg3 db 10,"Enter the letter : ",10
	msg3_len equ $- msg3

	e_msg db 10,"Invalid input",10
	e_msg_len equ $- e_msg

	answer_msg db 10,"ANS = "
	answer_msg_len equ $- answer_msg

	hex_msg db 10,"Hex format = "
	hex_msg_len equ $- hex_msg



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
%macro read 2
    	mov rax ,0
        mov rdi ,0
        mov rsi, %1
        mov rdx, %2
        syscall
%endmacro
%macro fopen 1
	mov rax,2
	mov rdi %1
	mov rsi,2
	mov rdx , 07770
	syscall
%endmacro
%macro fread 3
	mov rax,0
	mov rdi %1
	mov rsi,%2
	mov rdx , %3
	syscall
%endmacro
%macro fwrite 3
	mov rax,1
	mov rdi %1
	mov rsi,%2
	mov rdx , %3
	syscall
%endmacro
%macro fclose 1
	mov rax,3
	mov rdi %1
	syscall
%endmacro




section .bss
	char resb 2
	char_ans resb 2
	buf resb 3
	buf_len equ $-buf
	filename resb 50
	ncount resq 1
	scount resq 1
	ccount resq 1



section .text
	global _start
		_start:
			print msg0,msg0_len   ; ASS4
			menu:
				call Display_menu	
				read buf,2
				mov al ,[buf]
				c1:
					cmp al ,'1'
					jne c2
					call Blank
					jmp menu
				c2:
					cmp al,'2'
					jne c3
					call Occurance
					jmp menu
				c3:
					cmp al,'3'
					jne c4
					call Lines
					jmp menu
				c4:
					cmp al,'4'
					jne invalid
					exit
					
				invalid:
					print invalid_msg,invalid_msg_len
					jmp menu


		


Blank:
	print msg2,msg2_len
	ret

Occurance:
	print msg3,msg3_len
	ret
Lines:
	print answer_msg,answer_msg_len
	ret

Display_menu:
	mov rax ,1
    mov rdi, 1
    mov rsi ,msg1
    mov rdx ,msg1_len
    syscall

	ret


Display:
	mov rbx , 16
	mov rcx ,4
	mov rsi , char_ans+3

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
		print char_ans,4


	ret

