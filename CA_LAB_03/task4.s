.text
.globl main

main:
    li x11, 0x100     #source
    li x10, 0x200     #destination
    
    li x8, 10
    sb x8, 0(x11)     #store at source (0x100)
    li x8, 11
    sb x8, 1(x11)
    li x8, 12
    sb x8, 2(x11)
    li x8, 0              #null terminator
    sb x8, 3(x11)
    
    jal x1, strcpy    #calling strcpy
    j exit

strcpy:
    addi sp, sp, -4      #adjust stack
    sw x19, 0(sp)       #save x19
    li x19, 0               #i = 0

loop:
    add x5, x19, x10   #destination[i]
    add x6, x19, x11   #source[i]
    
    lb x7, 0(x6)          #load source[i]
    sb x7, 0(x5)         #store to destination[i]
    
    beq x7, x0, Done   #if '\0', exit
    addi x19, x19, 1    #i += 1
    j loop

Done:
    lw x19, 0(sp)       #restore x19
    addi sp, sp, 4       #restore stack
    jalr x0, 0(x1)       #return

exit:
    j exit
