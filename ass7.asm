%include "macro.asm"

section .data
	nline db 10,10
	nline_len equ $-nline
	ano db "Asssignment 7: Bubble Sort",10
	ano_len equ $-ano

	msg0 db 10,"Enter file name",10
	msg0_len equ $- msg0

	msg1 db 10,"GDTR "
	msg1_len equ $- msg1

	msg2 db 10,"LDTR "
	msg2_len equ $- msg2

	msg3 db 10,"TR "
	msg3_len equ $- msg3

	msg4 db 10,"MSW "
	msg4_len equ $- msg4

	msg5 db 10,"Real Mode"
	msg5_len equ $- msg5

	msg6 db ":"
	msg6_len equ $- msg6

	msg7 db 10,"IDTR "
	msg7_len equ $- msg7

	err db "XXXXX"
	err_len equ $- err



section .bss
	buf resb 1024
	buf_len equ $-buf
	filename resb 50
	filehandler resq 1
	abuff resq 1
	array resq 1
	n resq 1	
	;char_ans resb 16


section .text
global _start
_start:
	print ano,ano_len
	print msg0,msg0_len
	read filename ,50
	dec rax
	mov byte[filename+rax],0
	fopen filename
	cmp rax,-1H
	jle error
	mov [filehandler],rax
	fread [filehandler],buf,buf_len
	mov [abuff],rax

	call BSort



exit	
	error:
	print err,err_len
	exit



BSort:
	call buf_array

	xor rax,rax
	mov rbp,[n]
	
	xor rcx,rcx
	xor rdx,rdx
	xor rsi,rsi
	xor rdi,rdi

	oloop:
		mov rbx,0
		mov rsi,array
	iloop:
		mov rdi,rsi
		inc rdi
		mov al,[rsi]
		cmp al,[rdi]
		jbe next
		mov dl,0
		mov dl,[rdi]
		mov [rdi],al
        mov [rsi],dl
    next:
    	inc rsi
        inc rbx                
        cmp rbx,rbp
        jb iloop
      
        inc rcx
        cmp rcx,rbp
        jb oloop

    fwrite    [filehandler],array,[n]

    fclose [filehandler]

    print array ,[n]  








ret

buf_array:	
	xor rcx,rcx
	xor rsi,rsi
	xor rdi,rdi

    mov    rcx,[abuff]
    mov    rsi,buf
    mov    rdi,array

next_num:
    mov    al,[rsi]
    mov    [rdi],al

    inc    rsi        
    inc    rsi       
    inc    rdi      
  		
  	inc byte[n]


    dec    rcx        
    dec    rcx        
    jnz    next_num

    print array,[n]

    ret

