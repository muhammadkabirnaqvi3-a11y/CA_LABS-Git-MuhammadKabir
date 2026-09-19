.text
.globl main
 
main:
    addi x10, x0, 12        # set a = 12
    addi x11, x0, 12        # set b = 12
   
    jal x1, sum             # call sum function
    addi x11, x10, 0        # save the result in register x11
    li x10, 1                    
    ecall                   # print the result
    j exit                  # go to exit
 
sum:
    add x10, x10, x11       # add a + b
    jalr x0, 0(x1)          # Return to function
 
exit:
    j exit                  # end program
