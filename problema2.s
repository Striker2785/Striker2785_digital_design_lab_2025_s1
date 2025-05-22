.data
x:      .word 5           @ Puedes cambiar a 3, 5 o 6
res:    .word 0

.text
.global _start

_start:
    LDR     R0, =x
    LDR     R1, [R0]      @ x → R1
    MOV     R2, #1        @ factorial acumulado → R2

    CMP     R1, #0
    BEQ     end

loop:
    MOV     R3, R2       
    MUL     R2, R3, R1   
    SUB     R1, R1, #1
    CMP     R1, #0
    BGT     loop

    LDR     R0, =res
    STR     R2, [R0]

end:
    B       end
