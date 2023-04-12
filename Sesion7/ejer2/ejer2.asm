	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
cadena	    .equ	0xE000
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

menor:		.byte	255
			; Comienzo del programa
programa:	
			
    ldx     #cadena

lectura:

    lda     teclado     ;carga caracter de teclado
    sta     ,x+         ;pasa a la siguiente direccion
    cmpa    #'\n        ;compara con el caracter de fin de linea
    bne     lectura     ;si no es fin de linea, vuelve a leer
    clr     -1,x        ;si es fin de linea, borra el caracter

busca_menor:
    
    lda     #255
    sta     menor
    ldx     #cadena

sigue_buscando:

    lda     ,x+         
    beq     fin_busqueda    ;si es cero, termina
    bita    #0b10000000     
    bne     sigue_buscando  
    cmpa    #32             ;compara con el espacio
    beq     sigue_buscando  ;si es espacio, sigue buscando
    cmpa    menor           ;compara a con el menor
    bhs     sigue_buscando  ;si es mayor o igual, sigue buscando
    sta     menor           ;si es menor, lo guarda en menor
    bra     sigue_buscando  ;vuelve a buscar

fin_busqueda:
    
    lda     menor       ;carga el menor
    cmpa    #255        ;compara con el valor de fin
    beq     acabar      ;si es igual, acaba
    sta     pantalla    ;si no, lo pasa a pantalla
    ldx     #cadena     ;cargar cadena

marcar:

    lda     ,x+     
    beq     busca_menor     
    cmpa    menor
    bne     marcar
    ora     #0b10000000
    sta     -1,x
    bra     marcar


acabar: 	clra
	sta 	fin

	.org 	0xFFFE	; Vector de RESET
	.word 	programa
