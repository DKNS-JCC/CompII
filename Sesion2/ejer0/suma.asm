        	.area PROG (ABS)


fin     	.equ 	0xFF01
teclado		.equ		0xFF02
pantalla 	.equ 	0xFF00
         			
        	.org 	0x100
sumando1:	.word	0x2190	;|0x21|0x90|
sumando2:	.word	0x7777	;|0x77|0x77|
suma1:		.word	0
suma2:		.word	0	
        	.globl 	programa

			; Comienzo del programa
programa:	
		; Suma con registro D
		ldd		sumando1
		addd	sumando2
		std		suma1

		;Suma con registro A
		lda 	sumando1+1	;90 ya que es la posicion de memoria donde esta el 90 para el tamaño del registro A
		adda	sumando2+1	;90+77
		sta		suma2+1		;almacenar en A
		lda		sumando1	;21
		adca 	sumando2	;+77
		sta 	suma2		;almacenar en A
