.text
.globl main

main:
    li x10, 0x200  #base address
    li x11, 3

    li x28, 10         
    li x29, 20        
    sw x28, 12(x10)    # store 10 at address 0x200 + 12 (v[3])
    sw x29, 16(x10)    # store 20 at address 0x200 + 16 (v[4])


swap:   
    slli x11, x11, 2   # i*4
    add x27, x10, x11  # getting memory address
    lw x28, 0(x27)     # loading value of v[k]
    lw x29 , 4(x27)    # loading value of v[k+1]

    sw x29 , 0(x27)    # storing v[k+1] to v[k]
    sw x28 , 4(x27)    # storing v[k] to v[k+1]

exit: 
    j exit



