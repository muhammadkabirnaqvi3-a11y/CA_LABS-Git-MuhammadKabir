.text
.globl main

main:
    li x10, 4

fact:
    addi sp ,sp ,-8   #adjust stack for 3 items
    sw x1 , 4(sp)        #save return address
    sw x10 , 0(sp)       #save argument n

    addi x5 , x0 , 1     #x5 = acc = 1
    
loop:    
    bgt x10 , x0 , elseloop   #if n < 0, go to elseloop
    addi x11, x5, 0
    li x10, 1
    ecall
    j end

elseloop:
    mul x5 , x10 , x5         # acc  = acc*n
    addi x10, x10 , -1        # n = n-1
    beq x0, x0, loop

end:
    j end
