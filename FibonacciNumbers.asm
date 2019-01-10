#int fibonacci( int whichOne)
  #if( whichOne < 1) return( 0);
  #if( whichOne < 3) return( 1);
  #return( fibonacci( whichOne - 1) + fibonacci( whichOne - 2));

.data
topNum: .word 10 #the program prints out the first 10 fibbonacci numbers
N: .word 1 #we start with 1
comma: .asciiz ", "

.text
main:
lw $t0, N
lw $t1, topNum 

loop:
beq $t0, $t1, end
add $a0, $t0, $zero
jal fibb #v0 = fibb(N)

add $a0, $v0, $zero #put v0 into a0
addi $v0, $zero, 1  
syscall

la $a0, comma
addi $v0, $zero, 4
syscall

addi $t0, $t0, 1 #N++
j loop
end:
add $a0, $t0, $zero
jal fibb #v0 = fibb(N)
add $a0, $v0, $zero #put v0 into a0
addi $v0, $zero, 1  
syscall

addi $v0, $zero, 10
syscall


fibb:
addi $sp, $sp, -12
sw $s0, 8($sp) #s0 is N
sw $s1, 4($sp) #s1 is returned value
sw $ra, 0($sp) #return address

add $s0, $a0, $zero

beq $a0, 1, basecase # if N < 3, return 1
beq $a0, 2, basecase
beq $a0, 0, basecase0 #if N < 1, return 0

addi $s0, $s0, -1 #N-1
add $a0, $s0, $zero
jal fibb	 #return fibb(n-1)
add $s1, $v0, $zero

addi $s0, $s0, -1 #N-2
add $a0, $s0, $zero
jal fibb	 #return fibb(n-2)
add $s1, $s1, $v0
add $v0, $s1, $zero
j restoreAndReturn


basecase:
addi $v0, $zero, 1 
j restoreAndReturn

basecase0:
add $v0, $zero, $zero
j restoreAndReturn

restoreAndReturn:
lw $s0, 8($sp)
lw $s1, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12
jr $ra
