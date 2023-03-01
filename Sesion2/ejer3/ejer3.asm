        	.area PROG (ABS)


fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			
        	.org 	0x100

uno:		.word	0x102A
dos:		.word	0x201A
prod1:      .word   0
prod2:      .word   0
prod3:      .word   0
prod4:	    .word   0
resultado2: .word   0
resultado1: .word   0
        	
		.globl 	programa

; Comienzo del programa
programa:	

		lda     dos+1   ;A=1A
        ldb     uno+1   ;B=2A
        mul             ;D=1A*2A=0x0444
        std     prod1   ;Almacenar prod1 en D

        lda     dos+1   ;A=1A  
        ldb     uno     ;B=10
        mul             ;D=1A*10
        std     prod2   ;Almacenar prod2 en D

        lda     dos     ;A=20
        ldb     uno+1   ;B=2A
        mul             ;D=20*2A
        std     prod3   ;Almacenar prod3 en D

        lda     dos     ;A=20
        ldb     uno     ;B=10
        mul             ;D=20*10
        std     prod4   ;Almacenar prod4 en D

        ldb     prod1+1
        stb     resultado1+1

        ldx     #0

        ldb     prod1
        abx

        ldb     prod2+1
        abx

        ldb     prod3+1
        abx

        tfr     x,d
        std     resultado1 ; Parte baja suma

        ldx     prod4
        tfr     a,b
        abx 
        
        ldb     prod2
        abx

        ldb     prod3
        abx

        stx     resultado2 ; Parte alta suma

        
acabar: 	
		clra
		sta 	fin

			.org 	0xFFFE	; Vector de RESET
			.word 	programa
