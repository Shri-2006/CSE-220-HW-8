#Shriyans Singh 114807762

# Program: 4x4 Matrix Multiplication
#====================================================
# C = A × B
# Each matrix is 4x4 (integers)
#====================================================
.data
	#-----------------------------------------------
	# Matrices
	#-----------------------------------------------
	A: .word 1, 2, 3, 4
	.word 5, 6, 7, 8
	.word 9, 10, 11, 12
	.word 13, 14, 15, 16
	B: .word 1, 0, 0, 0 # This is a unit matrix
	.word 0, 1, 0, 0
	.word 0, 0, 1, 0
	.word 0, 0, 0, 1
	.align 2
	C: .space 64 # 16 integers * 4 bytes each = 64 bytes
	n: .word 4 # matrix dimension (4x4)
	newline: .asciiz "\n"
	space: .asciiz " "
	#code above was given



.text
.globl main
	main:
	la $s0,A #s0=base address of mat A
	la $s1, B #s1= base adress of mat B
	la $s2, C #s2=base adress of res mat C
	lw $s3,n #dimension size of mat=n=s3
	
	move $a0, $s3 #a0= n, the size of dimension
	move $a1,$s0 #a1=adrress of mat A
	move $a2, $s1#a2=adress of matB
	move $a3, $s2#a3=adress of res C
	
	addi $sp,$sp, -4 #create space on stack for $ra
	sw $ra, 0($sp) #save ra to stack prior to calling the mult label
	jal multiply #call mult matrix label
	
	lw $ra, 0($sp) #bring back ra from stack after calling mat label
	addi $sp,$sp,4 #free the stack
	li $s4,0 #s4= index of row=0 (r)=s4
	
	
print_rows:
	bge $s4,$s3, end_system #if s4>=s3 go to end_system
	li $s5,0 #col index (c)=s5
	
print_column:
	bge $s5,$s3, end_current_row #if c>=n then go to next row or stop, else keep printing this row
	mul $t0,$s4,$s3 # r*n for row r * n elem to get all elements prior to the row
	add $t0,$t0,$s5 #+c to (r*n) to get the specific element after row
	sll $t0,$t0,2 #((r*n)+c)*4 for offsetting
	add $t0, $s2, $t0 #address of t0 is C[r][c]
	lw $t1, 0($t0) #t1 = C[r][c]
	
	li $v0,1 #print int
	move $a0,$t1 #argument to print is C[r][c]
	syscall
	
	li $v0,4 #print string
	la $a0, space #print space between elements
	syscall
	
	addi $s5,$s5,1 #$s5+1=c++
	j print_column #move to next column
	
end_current_row:
	li $v0,4 #print string
	la $a0, newline #print \n to start new row
	syscall
	addi $s4,$s4,1 # s4+1=r++
	j print_rows #start printing new row

end_system:
	li $v0,10 #v0=10 means to system exit
	syscall
	
	
	
multiply:
	addi $sp,$sp, -36 #9 registers needed * 4=36 bytes on stack to allocate
	sw $ra, 32($sp) #save return address to stack
	sw $s0, 28($sp) #save n to stack
	sw $s1,24($sp) #save address to matrix A int the stack
	sw $s2, 20($sp) #save address to matrix B to stack
	sw $s3, 16($sp) #save address to matrix C (the result mat ) inthe stack
	sw $s4,12($sp) #save r for row to stack
	sw $s5, 8($sp) #save c for columm to stack
	sw $s6, 4($sp) #i for inner loop to stack
	sw $s7, 0($sp) #save the sum to stack 
	
	move $s0,$a0 #set n from a0 to s0
	move $s1,$a1 #set s1 to address of A from a1
	move $s2,$a2 #set s2 to address of B from a2
	move $s3,$a3 #set s3 to adress of C from a3
	li $s4,0 #set the r to 0 for the loop
row_loop:
	bge $s4,$s0, mult_done #when r>=n then it should stop loop
	li $s5,0 #set c to 0 in column loop
col_loop:
	bge $s5,$s0, current_row_mult_end #if c>=n no more elements in this row
	li $s6,0#set i=0 for inner loop
	li $s7,0 #set sum to 0
inner_loop:
	bge $s6,$s0, save_sum #if i>=n then save sum and go back to column loop
	mul $t0,$s4,$s0 #t0=r*n
	add $t0,$t0,$s6 #t0=r*n+i
	sll $t0,$t0,2 #t0=(r*n+i)*4
	add $t0,$s1,$t0 #t0 is now address of A[r][i]
	lw $t1, 0($t0) #t1=A[r][i]
	#For bB[i][c] its basically same thing but with the other registers
	mul $t2,$s6,$s0 #t2=i*n
	add $t2,$t2,$s5 #t2=n*i+c
	sll $t2,$t2,2 #(n*i+c)*4
	add $t2,$s2,$t2 #t2=address B[i][c]
	lw $t3,0($t2) #t3=B[i][c]
	mul $t4,$t1,$t3 #t4 = multiplication of specific elements: tr=A[r][i]*B[i][c]
	add $s7,$s7,$t4 #sum+=(A[r][i]*B[i][c])
	addi $s6,$s6,1 #i++
	j inner_loop #start loop again until inner loop is done
save_sum:
	mul $t0,$s4,$s0 #t0=r*n
	add $t0,$t0,$s5 #t0=(r*n)+c
	sll $t0,$t0,2 #t0= ((r*n)+c)*4
	add $t0,$s3,$t0 #t0=C[r][c] address
	sw $s7,0($t0) #Save sum to C[r][c]
	addi $s5,$s5,1 #c++
	j col_loop #repeat per column
current_row_mult_end:
	addi $s4,$s4,1 #r++ to next row
	j row_loop
mult_done:
	lw $s7,0($sp)#restore sum
	lw $s6,4($sp)#bring back i
	lw $s5, 8($sp)#bring back col
	lw $s4, 12($sp) #bring r back
	lw $s3, 16($sp) #bring address of C mat back
	lw $s2, 20($sp)#bring backaddress of B back
	lw $s1,24($sp)#bring back address of A
	lw $s0, 28($sp) #bring back n
	lw $ra, 32($sp)#restore the ra to caller
	addi $sp,$sp,36 #deallocate stack
	jr $ra #return
	
	

	