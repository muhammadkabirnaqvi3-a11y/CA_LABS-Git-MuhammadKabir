.text
.globl main

main:
    li x22, 5     #b
    li x23, 6     #c
    li x20, 3     #putting x as 3 for getting some output 

    li x1, 1
    li x2, 2
    li x3, 3
    li x4, 4

    bne x20, x1, else1
    add x21, x22, x23
    beq x0, x0, exit

else1:
    bne x20, x2, else2
    sub x21, x22, x23
    beq x0, x0, exit

else2:
    bne x20, x3, else3
    slli x21, x22, 1
    beq x0, x0, exit

else3:
    bne x20, x4, default
    srli x21, x22, 1
    beq x0, x0, exit

default:
    li x21, 0

exit:
    
end:
    j end


