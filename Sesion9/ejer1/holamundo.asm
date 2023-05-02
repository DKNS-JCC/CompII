       	.area PROG (ABS)
		.module holamundo

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	

			; Inicio declaración de variables
cadena:		.asciz	"Hola mundo\n"
			.globl programa
			.globl imprime_cadena

			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:	
			; Instrucciones del programa
		lds 	#0xFF00
		ldx 	#cadena
		jsr 	imprime_cadena
			; Terminación e inicio del programa
acabar: 	clra
	sta 	fin
	.org 	0xFFFE	; Vector de RESET
	.word 	programa