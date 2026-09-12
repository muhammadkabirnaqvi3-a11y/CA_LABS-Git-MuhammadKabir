.text
.globl main

main:
    li x20, 0x00000231
    li x21, 0x00000210
    li x22, 0x00000011
    li x23, 0x00000010

    bne x22, x23, Else
    add x19, x20, x21
    beq x0, x0, Exit   

Else: 
    sub x19, x20, x21

Exit: 

end:
    j end


    
