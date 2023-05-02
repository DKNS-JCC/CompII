        	.area PROG (ABS)

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
cadena      .equ    0xE000
         			; Fin definicion de constantes
        	.org 	0x100	
        	.globl 	programa

			; Inicio declaración de variables
cadenaf:	.asciz	"111111111"
			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:	
			; Instrucciones del programa
        lds #0xFF00
        lda #9
        ldx #cadena
        jsr lee_cadena
        ldx #cadena
        jsr imprime_cadena
			; Terminación e inicio del programa
acabar: 	clra
	sta 	fin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;lee_cadena:
;Lee cadena hasta que se pulsa enter
;Entrada X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lee_cadena:
    pshs a         ;Guarda el valor de A en la pila

lc_lectura:
    lda teclado     ;Lee el teclado
    sta ,x+         ;Guarda el caracter en la cadena
    cmpa #'\n       ;Compara con el caracter de fin de cadena
    bne lc_lectura  ;Si no es el caracter de fin de cadena, vuelve a leer
    clr ,-x         ;Si es el caracter de fin de cadena, lo sustituye por 0
    puls a          ;Recupera el valor de A
    rts             ;Sale de la subrutina equivalente a puls pc (return)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;lee_cadena_n
;Entrada X (inicio) A (tamaño)
;reg_afectados  A, X, B, CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lcn_max: .byte 0         ;Variable para guardar el tamaño de la cadena

lee_cadena_n:
    tsta                ;Comprueba si el tamaño es 0
    beq lcn_retorno     ;Si es 0, sale de la subrutina
    deca                ;Decrementa el tamaño de a en 1 (descarta el final de cadena)
    sta lcn_max         ;Guarda el tamaño en la variable lcn_max
    clra

lcn_lectura:
    cmpa lcn_max            ;Compara el tamaño con el tamaño de la cadena
    bhs  lcn_fin_lectura_n  ;Si el tamaño es mayor o igual que el tamaño de la cadena, sale de la subrutina
    ldb  teclado            ;Lee el teclado
    stb ,x+                 ;Guarda el caracter en la cadena
    cmpb #'\n               ;Compara con el caracter de fin de cadena
    beq lcn_fin_lectura_n   ;Si es el caracter de fin de cadena, sale de la subrutina
    inca                    ;Incrementa el tamaño de a en 1
    bra lcn_lectura         ;Vuelve a leer

lcn_fin_lectura_n:
    clr ,-x                 ;Si es el caracter de fin de cadena, lo sustituye por 0
    bra lcn_retorno         ;Sale de la subrutina

lcn_retorno:
    puls b                   ;Recupera el valor de A
    rts                     ;Sale de la subrutina equivalente a puls pc (return)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cadena                                                   ;
; saca por la pantalla la cadena acabada en '\0 apuntada por X     ;
;                                                                  ;       
; Entrada: X-direcciOn de comienzo de la cadena                    ;
; Salida: ninguna                                                  ;   
; Registros afectados: X, CC.                                      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cadena:
        pshs    a               ; Guarda el valor de A en la pila
sgte:              
        lda     ,x+             ; Carga el primer caracter de la cadena
        beq ret_imprime_cadena  ; Si es 0, sale a ret_imprime_cadena
        sta     pantalla        ; Si no, lo imprime en pantalla
        bra     sgte            ; y vuelve a sgte
ret_imprime_cadena:
        puls    a               ; Recupera el valor de A
        rts                     ; y sale de la subrutina equivalente a puls pc (return)



	.org 	0xFFFE	; Vector de RESET
	.word 	programa