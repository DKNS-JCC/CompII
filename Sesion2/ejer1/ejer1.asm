        	.area PROG (ABS)


fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			
        	.org 	0x100
sumando1:	.word	0x2190	;|0x21|0x90|
sumando2:	.word	0x7777	;|0x77|0x77|
suma1:		.word	0
suma2:		.word	0	
        	
		.globl 	programa

; Comienzo del programa
programa:	
		; Resta con registro D
		ldd		sumando1
		subd	sumando2
		std		suma1
para1:
		;Resta con registro A
		lda 	sumando1+1	;0x90
		suba	sumando2+1	;+0x77
		sta		suma2+1		;almacenar en A
		lda		sumando1	;0x21
		sbca 	sumando2	;+0x77
		sta 	suma2		;almacenar en A


acabar: 	
		clra
		sta 	fin

			.org 	0xFFFE	; Vector de RESET
			.word 	programa

