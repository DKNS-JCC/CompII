        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
c1:  .byte     0
c2:  .byte     0
c3:  .byte     0
c4:  .byte     0
tmp: .word    0
			; Fin declaración de variables
			; Comienzo del programa
programa:	
; Instrucciones del programa
    lda teclado
    suba #'0
    sta c4
    lda teclado
    suba #'0
    sta c3

    lda teclado
    suba #'0
    sta c2

    lda teclado
    suba #'0
    sta c1

    lda c4
    lsla
    lsla
    lsla
    lsla
    adda c3

    ldb c2
    lslb
    lslb
    lslb
    lslb

    addb c1

    tfr d,x

    lda c4
    lsla
    lsla
    ldb #250
    mul
    std tmp
    
    lda c3
    addd tmp
    std tmp

    lda c2
    ldb #10
    mul
    addb c1
    addd tmp

; Terminación e inicio del programa
acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
