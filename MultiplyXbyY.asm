.data
X: .word 4
Y: .word 5
Answer: .word 0
times: .asciiz " times "
is: .asciiz " is "

.text 

main:

lw $a0, X 	
lw $a1, Y 	

jal myFunction		

sw $v0, Answer 		

li $v0, 1 	
lw $a0, X	
syscall 		

li $v0, 4 	
la $a0, times 		
syscall 		

li $v0, 1 	
lw $a0, Y	
syscall 		

addi $v0, $zero, 4 	
la $a0, is 		
syscall 		

li $v0, 1 	
lw $a0, Answer	 	
syscall 		

li $v0, 10	
syscall			

myFunction:
addi $sp, $sp, -16 	
sw $s0, 0($sp) 		#X
sw $s1, 4($sp)		#Y
sw $s2, 8($sp)		#answer
sw $ra, 12($sp)		#return address


#copy arguments from argument registers into save temporary registers
addi $s0, $a0, 0
addi $s1, $a1, 0
addi $s2, $zero, 0


loop:
beq $zero, $s0, end #exits loop if counter is equal to 0
add $s2, $s2, $s1 
addi $s0, $s0, -1
j loop
end:

addi $v0, $s2, 0		

lw $s0, 0($sp) 		
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 16 	
jr $ra
