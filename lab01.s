.text
.globl main

main:
    li x4, 5  #a
    li x1, 5   #  5
    li x0, 0     # b = 0

    addi x4, x0, 32  #x4 = a
    add x6, x4, x0   #x6 = secondary
    sub x7, x6, x1   #x7 = d
    
    sub x10, x4, x7
    sub x11, x0, x4
    add x12, x10, x11
    add x8, x12, x7  

    add x13, x0, x4
    add x14, x13, x7
    add x8, x14, x8  #x15 = e

end:
    j end            


# int a = 5;
# int b = 0 + 0;
# a = b + 32;
# int d = (a + b) - 5;
# int e = (((a - d) + (b - a)) + d);
# e = a + b + d + e;