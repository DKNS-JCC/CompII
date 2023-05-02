        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
pilaS       .equ    0xFF0
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa


programa:	
    lds #pilaS
    ldd #23468
    jsr imprime_decimal

    lda #'\n
    sta pantalla

acabar: 	clra
	sta 	fin



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;imprime_decimal
;ENTRADA: D
;Registros Afectados: D,X,CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_decimal:
    pshs x
    ldx    #0                       ;inicializa el contador a 0
id_primera_cifra:
    cmpd #10000                     ;compara el valor de D con 10000
    blo  id_imprime_primera_cifra   ;si D es menor que 10000, imprime la primera cifra
    subd #10000                     ;si no, resta 10000 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_primera_cifra           ;vuelve a la etiqueta id_primera_cifra

id_imprime_primera_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_segunda_cifra:
    cmpd #1000                      ;compara el valor de D con 1000
    blo  id_imprime_segunda_cifra   ;si D es menor que 1000, imprime la primera cifra
    subd #1000                      ;si no, resta 1000 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_segunda_cifra           ;vuelve a la etiqueta id_segunda_cifra

id_imprime_segunda_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_tercera_cifra:
    cmpd #100                       ;compara el valor de D con 100
    blo  id_imprime_tercera_cifra   ;si D es menor que 100, imprime la primera cifra
    subd #100                       ;si no, resta 100 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_tercera_cifra           ;vuelve a la etiqueta id_tercera_cifra

id_imprime_tercera_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_cuarta_cifra:
    cmpd #10                        ;compara el valor de D con 10
    blo  id_imprime_cuarta_cifra    ;si D es menor que 10, imprime la primera cifra
    subd #10                        ;si no, resta 10 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_cuarta_cifra            ;vuelve a la etiqueta id_cuarta_cifra

id_imprime_cuarta_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_quinta_cifra:
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    puls x
    rts

	.org 	0xFFFE	; Vector de RESET siempre al final
	.word 	programa

