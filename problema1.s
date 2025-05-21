.data
array:      .word 1,2,3,4,5,6,7,8,9,10
y:          .word 5
n:          .word 10

.text
.global _start

_start:
    LDR     R0, =array       @ Dirección del array
    LDR     R1, =y
    LDR     R2, [R1]         @ y → R2
    MOV     R3, #0           @ i → R3

loop:
    CMP     R3, #10
    BEQ     end

    LDR     R4, [R0, R3, LSL #2]   @ array[i] → R4
    CMP     R4, R2

    MULGE   R5, R4, R2             @ Si >=, R5 = R4 * y
    ADDLT   R5, R4, R2             @ Si <, R5 = R4 + y

    STR     R5, [R0, R3, LSL #2]   @ Guardar array[i]

    ADD     R3, R3, #1
    B       loop

end:
    B       end

	
