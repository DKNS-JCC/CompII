            .area PROG(ABS)

            .org 0x100
cadena:     .ascii  "Hola, mundo"   ; Cadena de caracteres
            .byte   10    ; Salto de línea
            .byte   0     ; Fin de cadena


            .globl programa
    
programa:
        ldx #cadena
bucle:  lda     ,x+
        sta     0FF00   ;Salida pantalla
        beq     acabar  
        bra     bucle


acabar: clra
        sta     0xFF01
        .org    0xFFFE
        .word   programa