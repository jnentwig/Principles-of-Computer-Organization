.data 
    array1:	.word   5,  6,  23,  -7,  201, 18
    size1:   	.word  6
    text1:	.asciiz "The largest value of the first array is "
    array2:	.word  7, 32, 131, -84, 31, 6, 2, 8, 55, 21
    size2:	.word  10
    text2:	.asciiz "\nThe largest value of the second array is "
.text
main:
la $a0, text1
li $v0, 4
syscall
la $a0, array1
lw $a1, size1
jal largest
add $a0, $v0, $zero
li $v0, 1
syscall

la $a0, text2
li $v0, 4
syscall
la $a0, array2
lw $a1, size2
jal largest
add $a0, $v0, $zero
li $v0, 1
syscall

li $v0, 10
syscall
largest:
addi $sp, $sp, -12
sw $s0, 8($sp) #largest is in s0
sw $s1, 4($sp) #array[index] in s1
sw $ra, 0($sp) #return address	   
lw $s0, 0($a0) #largest = array[0]
loop:
beq $a1, $zero, end
lw $s1, 0($a0) #array[index]
slt $t0, $s0, $s1 #if (largest<array[index])
bne $t0, $zero, conditional
backtoloop:
addi $a1, $a1, -1
addi $a0, $a0, 4
j loop
end:
add $v0, $s0, $zero #return largest
lw $s0, 8($sp)
lw $s1, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12
jr $ra
conditional:
add $s0, $zero, $s1        
j backtoloop                  
