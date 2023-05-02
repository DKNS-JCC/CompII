        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
num:	.word	0
			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:	
			; Instrucciones del programa
    lda teclado
    suba #'0
    ldb #50
    mul
    lda #200
    mul
    std num
    
    lda teclado
    suba #'0
    ldb #20
    mul
    lda #50
    mul
    addd num
    std num

    lda teclado
    suba #'0
    ldb #100
    mul
    addd num
    std num

    lda teclado
    suba #'0
    ldb #10
    mul
    addd num
    std num

    ldb teclado
    subb #'0
    addd num
    std num
    
    clra
    clrb

bucle: 
        tfr d,x
        cmpd num
        beq perfecto
        bhi noperfecto
        tfr x,d
        inca
        incb
        bra bucle

perfecto:
        lda #'5
        sta pantalla
        bra acabar

noperfecto: 
        lda #'N
        sta pantalla

			; Terminación e inicio del programa
acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
