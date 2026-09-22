.text
.globl main

main:
    li x10, 0x100
    li x11, 3

bubble:
    beq x10, x0, exit
    beq x11, x0, exit
    li x5, 0                #x5 = i

outerloop:
    bge x5, x11, exit
    addi x6, x5, 0          #x6 = j 

innerloop:
    bge x6, x11, elseouter
    slli x20, x5, 2
    slli x21, x6, 2
    add x20, x20, x10
    add x21, x21, x10
    lw x27, 0(x20)
    lw x28, 0(x21)

    bge x27, x28, elseinner
    sw x28, 0(x20)
    sw x27, 0(x21)

elseinner:
    addi x6, x6, 1
    j innerloop

elseouter:
    addi x5, x5, 1
    j outerloop
    
exit: 
    j exit



