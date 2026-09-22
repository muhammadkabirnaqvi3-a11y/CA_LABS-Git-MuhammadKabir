.text
.globl main

main:
    li x10, 3        #x10 = num
    jal x1, ntri
    j end

ntri:
    addi sp , sp , -8     #adjust stack for 2 items
    sw x1 , 4(sp)         #save return address
    sw x10 , 0(sp)        #save argument num

    li x5, 1
    bgt x10 , x5 , L1     #if num > 1, go to L1
    addi x10 , x0 , 1     #return 1
    
    addi sp , sp , 8
    jalr x0 , 0(x1)   


L1:
    addi x10 , x10 , -1   #argument = num - 1
    jal x1 , ntri         #recursive call

    addi x6 , x10 , 0     #save result of fact(n-1)
    lw x10 , 0(sp)        #restore original n
    lw x1 , 4(sp)         #restore return address
    addi sp , sp , 8      #pop stack

    add x10 , x10 , x6    #n + fact(n-1)
    jalr x0 , 0(x1)  

end:
    j end


