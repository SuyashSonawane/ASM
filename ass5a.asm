
%include "macro.asm"
%include "ass5b.asm"

section .data

	msg0 db 10,"ASSIGNMENT 5",10	
	msg0_len equ $- msg0

	msg1 db 10,"1.No of Blank Spaces",10,"2.Occurance of a letter",10,"3.No of Lines",10,"4.Exit",10,"=>=>=>",10
	msg1_len equ $- msg1

	invalid_msg db 10,"Invalid Option Entered",10
	invalid_msg_len equ $- invalid_msg

	e_msg db 10,"Invalid input",10
	e_msg_len equ $- e_msg

	fmsg db 10,"Enter File name = "
	fmsg_len equ $- fmsg

	cmsg db 10,"Enter character to be serached = "
	cmsg_len equ $- cmsg




section .bss
	char resb 2
	char_ans resb 16
	buf resb 4096
	buf_len equ $-buf
	filename resb 50
	filehandler resq 1
	abuff resq 1



section .text
	global _start
		_start:
			print msg0,msg0_len   ; ASS5
			print fmsg,fmsg_len
			read filename ,50
			dec rax
			mov byte[filename+rax],0
			print cmsg,cmsg_len
			read char,2
			fopen filename
			cmp rax,-1H
			jle error
			mov [filehandler],rax
			fread [filehandler],buf,buf_len
			mov [abuff],rax
			call far_procedure
			exit

		error:
			print e_msg,e_msg_len
			exit


