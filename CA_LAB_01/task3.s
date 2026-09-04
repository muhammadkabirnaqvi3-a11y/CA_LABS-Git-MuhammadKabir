.text
.globl main

main:
    li x4, 5     #a = x4 = 5
    li x5, 0     #b = x5 = 0

    addi x4, x5, 32  #a = x4
    add x6, x4, x5   #d = x6 
    addi x6, x6, -5  #d = x6
    
    sub x15, x4, x6   
    sub x16, x5, x4
    add x17, x15, x16
    add x7, x17, x6   #e

    add x18, x4, x5
    add x19, x18, x6
    add x7, x19, x7  #e = x7

end:
    j end            
