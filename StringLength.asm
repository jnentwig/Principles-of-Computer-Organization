.data
#2 strings
HelloWorld: .asciiz "Hello World"
string: .asciiz "string"
.text
main:
#put things in here
#*string will be put into a1
addi $sp, $sp, -4
sw $ra, 0($sp)

la $a1, HelloWorld
jal strlen
add $a0, $v0, $zero
li $v0, 1
syscall

addi $a0, $zero, 10
li $v0, 11
syscall

la $a1, string
jal strlen
add $a0, $v0, $zero
li $v0, 1
syscall

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

strlen:
#s0 is length
addi $sp, $sp, 16
sw $s0, 12($sp) #length
sw $s1, 8($sp) #address
sw $s2, 4($sp) #byte
sw $ra, 0($sp)

add $s0, $zero, $zero
add $s1, $a1, $zero
loop:
lb $s2, 0($s1)
beq $s2, $zero, end
addi $s0, $s0, 1

lb $s2, 1($s1)
beq $s2, $zero, end
addi $s0, $s0, 1

lb $s2, 2($s1)
beq $s2, $zero, end
addi $s0, $s0, 1

lb $s2, 3($s1)
beq $s2, $zero, end
addi $s0, $s0, 1

addi $s1, $s1, 4
j loop
end:
add $v0, $s0, $zero
#return and clean up registers
lw $s0, 12($sp)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 16
jr $ra
