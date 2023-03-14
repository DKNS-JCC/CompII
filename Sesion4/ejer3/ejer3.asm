        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

	        	

programa:	
            lda #1
            lda teclado
            cmpa #'0
            blo minuscula
            cmpa #'9
            bhi minuscula
            lda #1
            bra acabar
minuscula:
            cmpa #'a
            blo mayuscula
            cmpa #'z
            bhi mayuscula
            lda #2
            bra acabar
mayuscula:
            cmpa #'A
            blo no
            cmpa #'Z
            bhi no
            lda #3
            bra acabar
no:
    clra
acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa