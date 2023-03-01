.area PROG (ABS)

         			
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			
        	.org 	0x100	
        	.globl 	programa

			
n1:	.byte	0
n2:	.byte	0
op:	.byte	0	
			
programa:	
		lda teclado 	;A=3(ASCII)
		suba #'0			;A=3(HEX)
		lsla
		lsla
		lsla
		lsla
		sta n1
		lda teclado 	;A=7(ASCII)
		suba #'0		;A=7(HEX)
		adda n1			;A=0x37
		
		lda #32
		sta pantalla

		lda teclado 	;A=3(ASCII)
		suba #'0		;A=3(HEX)
		lsla
		lsla
		lsla
		lsla
		sta n2
		lda teclado 	;A=7(ASCII)
		suba #'0		;A=7(HEX)
		adda n2			;A=0x37

		lda n1
		adda n2
		daa
		sta op

		
