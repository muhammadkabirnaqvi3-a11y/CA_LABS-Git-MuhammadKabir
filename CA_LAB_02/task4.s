.text
.globl main

main:
    li x10, 0x200   #taking base add as 0x200 in x10 reg
    li x5, 2    #x5 = a
    li x6, 3    #x6 = b
    li x7, 0    #x7 = i
for:
    beq x7, x5, end
    li x29, 0   #x29 = j

for1:
    beq x29, x6, temp
    add x30, x7, x29       #x30 = i + j
    slli x31, x29, 2      
    add x31, x31, x10
    sw x30, 0(x31)
    addi x29, x29, 1
    j for1

temp:
    addi x7, x7, 1
    j for
end:
    j end


