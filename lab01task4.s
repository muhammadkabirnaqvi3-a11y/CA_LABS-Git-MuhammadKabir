.text
.globl main

main:
    li x10, 0x78786464
    li x11, 0xA8A81919
    li x15, 0x100
    li x16, 0x1F0

    sw x1, x15(x10)
    sw x2, x16(x11)
    lwu x12, x15(x1)
    lw x13, x16(x2)


end:
    j end      

