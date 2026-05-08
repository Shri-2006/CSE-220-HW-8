#Shriyans Singh 114807762
.data
	v: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0 #create an array which holds numbers
	n: .word 10 # number of elements
	message: .asciiz "Sorted Array: " #message to be printed
	space: .asciiz " "
	nl: .asciiz "\n"
.text
.globl main #neeeded to have program start

main:

	la $s0,v #store base address of array v
	lw $s1,n #store num of elements into s1
	
	move $a0,$s0 #set a0 to have base address of the array v
	move $a1, $s1 #set a1 to have the num of elements
	
	#saving $ra to stack before going to bubble_sort
	addi $sp, $sp, -4 #make space in stack
	sw $ra, 0($sp) #save $ra to stack
	
	jal bubble_sort #go to bubblesort
	
	lw $ra,0($sp) #return $ra value from stack to $ra
	addi $sp,$sp,4 #free stack
	
	li $v0,4 #print string message
	la $a0, message #load message address to $a0 to print
	syscall
	li $s2,0 #set the print loop index to 0 before starting
	
print_loop:
	bge $s2,$s1,print_done #if the index is no longer less than the number of elements then it must stop printing
	sll $t0,$s2,2 #index*4 for next element
	add $t0,$s0,$t0 #address of v[i] added to $t0
	lw $t1,0($t0) #load v[i] to t1
	li $v0,1 #print int
	move $a0,$t1 #store v[i] in a0
	syscall#print element v[i]
	
	li $v0,4 #print space string to separate numbers 
	la $a0, space #load address of space string to a0
	syscall
	
	addi $s2,$s2,1 #increment i
	j print_loop #jump back to start of print_loop
print_done:
	li $v0,10#exit system once printing is done
	syscall


bubble_sort:
	addi $sp,$sp,-20 #create space on stack for 5 variables
	sw $ra, 16($sp)#save return address
	sw $s0,12($sp)#save outer index
	sw $s1,8($sp) #save inner index
	sw $s2,4($sp)#save s2
	sw $s3, 0($sp) #save s3
	
	move $s0,$a0 #make this the base address of array
	move $s1,$a1 #make it the number of elements
	li $s2,0 #outer loop index starts at 0

out_loop:
	addi $t0,$s1,-1 #n-1 = t0 for loop
	bge $s2,$t0, sorted #if index >=n-1 then it should be sorted by now
	li $s3,0 #start j=0 for inner loop


inner_loop:
	addi $t0,$s1,-1 #n-1= t0 for the inner loop liimit
	sub $t0,$t0,$s2 #n-1-i for the total inner loop max limit
	bge $s3,$t0, sorted_section #if j>=n-i-1 then the inner area should be sorted
	
	sll $t1,$s3,2 #j=j*4  for word offset
	add $t1,$s0,$t1 #address for arr[j] is t1
	addi $t2,$t1,4 #address of arr[j+1] is t2
	lw $t3, 0($t1) #load the value of arr[j] into t3
	lw $t4, 0($t2) #load value of arr[j+1] into t4
	
	bge $t3,$t4,sorted_order #if arr[j]>=arr[j+1] elements already decreasing order
	#else if its not sorted already it needs to swap
	sw $t4, 0($t1) # arr[j] = arr[j+1]
	sw $t3, 0($t2) #arr[j+1]=old arr[j]
	
sorted_order:
	addi $s3,$s3,1 #j++ for loop
	j inner_loop #go back through loop until sorted
	
sorted_section:
	addi $s2,$s2,1 #i++ for outloop
	j out_loop
	
sorted:
	lw $ra,16($sp)#return address brought back from stack
	lw $s0,12($sp)#bring back base address of v
	lw $s1, 8($sp) #bring back num of elements
	lw $s2, 4($sp) #bring back i
	lw $s3, 0($sp) #bring back j
	addi $sp,$sp,20 #free stack
	jr $ra #return to caller
	
