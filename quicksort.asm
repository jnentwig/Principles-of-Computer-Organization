.data
array1:	.word 5, 1, 2, 3, 4, -49, 6, 473, 56, 0, 71, 2
.text
main:
	
	la $a0, array1
	addi $a1, $a0, 44
	jal quickSort
	li $v0, 10
	syscall




#void quickSort(int* begin /*s0*/ , int* end /*s1*/)
#{
quickSort:
	#HEADER
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)

	#move things out of argument registars to saved ones
	move $s0, $a0	#int* begin
	move $s1, $a1	#int* end
	
	#int* swapPoint;	//s2
	#int* iterator; //s3
	#int* tmp; // s4


	move $s2, $s0		#swapPoint = begin;
	addi $s3, $s0, 4	#iterator = begin + 1;
	
	quickSort_loop0_return:
	ble $s3, $s1, quickSort_loop0	#while(iterator <= end)
	
	
	#swap(swapPoint, begin);
	move $a0, $s2
	move $a1, $s0
	jal swap
	
	addi $s4, $s2, -4		#tmp = swapPoint - 1
	blt $s0, $s4, quickSort_if0	#if(begin < tmp)
	quickSort_if0_return:
	
	addi $s4, $s2, 4		#tmp = swapPoint + 1;
	blt $s4, $s1, quickSort_if1	#if(tmp < end)
	quickSort_if1_return:
	
	
	#FOOTER
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra	#return;


	quickSort_loop0:
		#if(*iterator < *begin){
		lw $t0, ($s3)
		lw $t1, ($s0)
		blt $t0, $t1, quickSort_loop0_if0
		quickSort_loop0_if0_return:
		
		addi $s3, $s3, 4			#iterator++;
		j quickSort_loop0_return

		quickSort_loop0_if0:
			addi $s2, $s2, 4	#swapPoint++;
			
			#swap(swapPoint, iterator);
			move $a0, $s2
			move $a1, $s3
			jal swap
			j quickSort_loop0_if0_return
		
		
	quickSort_if0:
		#quickSort(begin, tmp);
		move $a0, $s0
		move $a1, $s4
		jal quickSort
		j quickSort_if0_return
	
	quickSort_if1:
		#quickSort(tmp, end);
		move $a0, $s4
		move $a1, $s1
		jal quickSort
		j quickSort_if1_return
##################
#END OF QUICKSORT#
##################

swap:	#swap what $a0 and $a1 are pointing to
	lw $t0, ($a0)
	lw $t1, ($a1)
	sw $t0, ($a1)
	sw $t1, ($a0)
	jr $ra
#############
#END OF SWAP#
#############
