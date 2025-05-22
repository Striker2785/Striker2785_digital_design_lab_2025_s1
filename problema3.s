.text
.global _start

_start:
    LDR     R0, =0x1000       @ Dirección del teclado (simulado)
    LDR     R1, =0x2000       @ Dirección del contador
    
    MOV     R3, #0            @ Inicializar contador a 0
    STR     R3, [R1]

    @ Iteración 1: Flecha arriba (0xE048)
    LDR     R2, =0xE048
    STR     R2, [R0]
    BL      procesar_tecla

    @ Iteración 2: Tecla inválida (0x1234)
    LDR     R2, =0x1234
    STR     R2, [R0]
    BL      procesar_tecla

    @ Iteración 3: Flecha abajo (0xE050)
    LDR     R2, =0xE050
    STR     R2, [R0]
    BL      procesar_tecla

    @ Iteración 4: Flecha arriba (0xE048)
    LDR     R2, =0xE048
    STR     R2, [R0]
    BL      procesar_tecla

    @ Iteración 5: Flecha arriba (0xE048)
    LDR     R2, =0xE048
    STR     R2, [R0]
    BL      procesar_tecla

    B       fin_programa

procesar_tecla:
    PUSH    {R4, LR}          @ Guardar R4 y LR
    LDR     R2, [R0]          @ Leer tecla
    LDR     R3, [R1]          @ Leer contador

    LDR     R4, =0xE048       @ Comparar con flecha arriba
    CMP     R2, R4
    BEQ     up

    LDR     R4, =0xE050       @ Comparar con flecha abajo
    CMP     R2, R4
    BEQ     down

    B       fin_iteracion     @ Tecla inválida

up:
    ADD     R3, R3, #1        @ Incrementar contador
    STR     R3, [R1]
    MOV     R5, #0
    STR     R5, [R0]          @ Limpiar tecla
    B       fin_iteracion

down:
    SUB     R3, R3, #1        @ Decrementar contador
    STR     R3, [R1]
    MOV     R5, #0
    STR     R5, [R0]          @ Limpiar tecla
    B       fin_iteracion

fin_iteracion:
    POP     {R4, LR}          @ Restaurar R4 y LR
    BX      LR

fin_programa:
    B       fin_programa      @ Bucle infinito