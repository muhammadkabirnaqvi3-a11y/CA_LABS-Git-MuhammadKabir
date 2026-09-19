.text
.globl leaf_example

leaf_example:
    addi sp, sp, -12        #stack point for putting temp registers
    sw x18, 8(sp)
    sw x19, 4(sp)
    sw x20, 0(sp)

    li x10, 1               #g
    li x11, 2               #h
    li x12, 2               #i
    li x13, 3               #j

    add x18, x10, x11       #(i+j) = x18
    add x19, x12, x13       #(g+h) = x19
    sub x20, x18, x19       #f = (g+h)-(i+j) = x20

    addi x11, x20, 0
    li x10, 1
    ecall 

exit:
    J exit

    
