.text
.global _start

_start:
    LDR     R0, =0x1000       @ Dirección del teclado
    LDR     R1, =0x2000       @ Dirección del contador
    
    @ Inicializar contador a 0
    MOV     R3, #0
    STR     R3, [R1]

    @ --- Simulación de 5 iteraciones ---
    
    @ Iteración 1: Flecha arriba (0xE048)
    LDR     R2, =0xE048
    STR     R2, [R0]
    BL      procesar_tecla
    
    @ Iteración 2: Tecla inválida (0x1234)
    LDR     R2, =0xE048
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

@ --- Subrutina que procesa la tecla (ahora preserva R4) ---
procesar_tecla:
    PUSH    {R4, LR}          @ Guardar R4 y LR (LR = registro de retorno)
    
    LDR     R2, [R0]          @ Leer tecla
    LDR     R3, [R1]          @ Leer contador

    LDR     R4, =0xE048       @ Código flecha arriba
    CMP     R2, R4
    BEQ     up

    LDR     R4, =0xE050       @ Código flecha abajo
    CMP     R2, R4
    BEQ     down

    B       fin_iteracion     @ Tecla inválida → ignorar

up:
    ADD     R3, R3, #1
    STR     R3, [R1]
    MOV     R5, #0
    STR     R5, [R0]
    B       fin_iteracion

down:
    SUB     R3, R3, #1
    STR     R3, [R1]
    MOV     R5, #0
    STR     R5, [R0]
    B       fin_iteracion

fin_iteracion:
    POP     {R4, LR}          @ Restaurar R4 y LR
    BX      LR                @ Retornar

fin_programa:
    B       fin_programa      @ Bucle infinito
	