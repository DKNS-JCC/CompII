        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado	.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
var1:	.byte	3
var2:	.word	12
			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:	
			; Instrucciones del programa

			; Terminación e inicio del programa
acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
