;COMPARAR DOS LISTAS DE NUMEROS/CARACTERES DEVOLVIENDO UN 1 SI SON IGUALES
;O UN 0 SI SON DISTINTAS



        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
var1:	.asciz	"12345"
var2:	.asciz	"02345"

programa:	

	lda #2

compara:

	ldx #var1
	leax a,x
	ldy #var2

compara_bucle:

	lda 	,x+
	beq 	compara_igual
	cmpa 	,y+
	beq 	compara_bucle

compara_distinto:

	ldb 	#0			
	bra 	compara_fin

compara_igual:

	ldb #1

compara_fin:

	addb #'0
	stb pantalla

acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
