	.area PROG (ABS)

        ; definimos un par de constantes
fin     .equ 0xFF01
pantalla .equ 0xFF00

	.org 0x100
	.globl programa

prefijo:.asciz "0x" ; prefijo

programa:
        lds #0xF000 ; usaremos la pila.  Le damos un valor seguro
	lda #28 ; pongamos este nUmero como prueba

        ; imprimamos 0x
        ldx #prefijo
        bsr imprime_cadena

        ; primero imprimamos la primera cifra hexadecimal
        tsta
        beq segunda_cifra
        tfr a,b
        lsrb
        lsrb
        lsrb
        lsrb ; en B estA la primera cifra, de 0 a 15
        bsr imprime_cifra_hexa

        ; ahora imprimimos la segunda cifra hexadecimal
segunda_cifra:
        tfr a,b
        andb #0b1111 ; en B estA la segunda cifra, de 0 a 15
        bsr imprime_cifra_hexa

        ; imprimamos un salto de lInea al final
        ldb #'\n
        stb pantalla

        ; el programa acaba
        clra
	sta fin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cifra_hexa                                               ;
;     saca por la pantalla la cifra hexadecimal contenida en B     ;
;                                                                  ;
;   Entrada: B-cifra hexadecimal, del 0 al 15                      ;
;   Salida:  ninguna                                               ;
;   Registros afectados: B, CC.                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cifra_hexa:
        cmpb #10
        blo decimal
        addb #'A-'9-1
decimal:addb #'0
        stb pantalla
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cadena                                                   ;
;     saca por la pantalla la cadena acabada en '\0 apuntada por X ;
;                                                                  ;
;   Entrada: X-direcciOn de comienzo de la cadena                  ;
;   Salida:  ninguna                                               ;
;   Registros afectados: X, CC.                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
imprime_cadena:
        pshs a
sgte:   lda ,x+
        beq ret_imprime_cadena
        sta pantalla
        bra sgte
ret_imprime_cadena:
        puls a
        rts

	.org 0xFFFE	; vector de RESET
	.word programa