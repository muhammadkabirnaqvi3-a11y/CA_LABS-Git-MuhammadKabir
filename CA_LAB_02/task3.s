.text
.globl main

main:
    li x22, 0      # x22 = i
    li x24, 10     # x24 = loop end
    li x23, 0      # x23 = sum
    li x1, 0x200   # x1 = base address

for:
    beq x22, x24, temp
    sw x22, 0(x1)
    addi x22, x22, 1
    addi x1, x1, 4       
    beq x0, x0, for       

temp:
    li x1, 0x200
    li x22, 0
    beq x0, x0, for1

for1:
    beq x22, x24, exit
    lw x26, 0(x1)
    add x23, x23, x26
    addi x22, x22, 1
    addi x1, x1, 4        
    beq x0, x0, for1      

exit:
end: j end


