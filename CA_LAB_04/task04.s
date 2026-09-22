.text
.globl main

main:
    li x10, 5               #input of the user
    jal x1, isprime         #calling isprime procedure
    j exit

isprime:
    addi sp, sp, -8         #making stack pointer to store arg and ret
    sw x1, 4(sp)
    sw x10, 0(sp)

    lw x7, 0(sp)            #x7 = n

    li x5, 1                #for comparing with 1
    ble x7, x5, return0
    li x5, 2                #for comparing with 2
    beq x7, x5, return1

    srli x6, x7, 1          #x6 = n/2
    li x5, 2                #i = 2

loop:
    bgt x5, x6, return1     #if i > n/2 → done

    mv x10, x7               #put n in x10
    mv x11, x5               #put i in x11
    jal x1, isdivisible      #call nested function

    beq x10, x0, return0     #remainder == 0 → divisible → not prime
    addi x5, x5, 1
    j loop

return1:
    li x10, 1
    j isprimeend

return0:
    li x10, 0

isprimeend:
    lw x1, 4(sp)
    addi sp, sp, 8
    ret

isdivisible:
    rem x10, x10, x11        #x10 = n % i, returned directly
    ret

exit:
    j exit
