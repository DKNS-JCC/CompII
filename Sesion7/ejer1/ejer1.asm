; HOLA MUNDO MOD
            .area PROG(ABS)

            .org 0x100
cadena:     .asciz  "Hola\n"    ; Cadena de caracteres
            .globl programa
    
programa:
        ldx #cadena
bucle:  lda     ,x+     ;Incrementa el puntero x
        beq     acabar  ;Si es 0, acaba
        sta     0xFF00   ;Salida pantalla
        bra     bucle   


acabar: clra
        sta     0xFF01
        .org    0xFFFE
        .word   programa