#Multiplication by Addition
#multiply x * y using addition

.data
X: .word 5 #X and Y can be changed to any number
Y: .word 4
answer: .word 0


.text
main:
lw $t1, X
lw $t2, Y #$t2 is the counter
loop:
beq $zero, $t2, end #exits loop if counter is equal to 0
add $t0, $t0, $t1 #t0 = t0 + $t1(X)
addi $t2, $t2, -1
j loop

end:
sw $t0, answer
nop 
nop
