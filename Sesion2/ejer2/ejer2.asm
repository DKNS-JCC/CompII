        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
uno:	.word	0x01A3
dos:	.byte	0xB1
suma1:	.word	0
suma2:	.word	0	
			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:	
			ldx uno	; x = uno
			ldb dos	; b = dos
			abx	; x = x + b
			std suma1	; Guardo el resultado en suma1

			ldb dos	; b = dos
			sex	; d = b
			addd uno ; d = d + 0x01A3
			std suma2	; Guardo el resultado en suma2

acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
