#Shriyans Singh 114807762
.data
	.align 2
	a: .space 40 #10*4 for a array, same for b
	b: .space 40
	num: .word 10 #TA will start with 10 num, they may change it tho
	q_a: .asciiz "A["
	q_b: .asciiz "B["
	q_end: .asciiz "]="
	nextLine: .asciiz "\n"
	separator: .asciiz "|"
	space: .asciiz " "
	
.text
.globl main

main:
#main func to load addresses for a,b matricies and counter
	la $s0,a #base address of a will be s0, 
	la $s1, b#s1 for b base address
	lw $s2, num#s2= num of elements
	li $s3, 0#s3=loop index starting from 0 
	
get_input:
	bge $s3,$s2,swap_start #if index>=num then gettign input is done and move onto swap
	sll $s4,$s3,2 #multiply s3 by 4 and put into s4 to get the next element address through offeset
	
	#for matrix a
	li $v0,4 #print string
	la $a0,q_a #print the string questions for matrix a
	syscall
	li $v0,1
	addi $a0,$s3,1 #display index for knowing which element of matrix is being inputted
	syscall
	li $v0,4
	la $a0, q_end #print out the end for the question part ]=
	syscall
	li $v0,5 #get the int value from user input for specific element of A
	syscall
	add $t0,$s0,$s4 #store address of A[i] at current i
	sw $v0, 0($t0) #store the value into current A[i]
	
	#for matrix b
	li $v0,4#print string
	la $a0,q_b #print the string questions for matrix b
	syscall
	li $v0,1
	addi $a0,$s3,1 #display index for knowing which element of matrix is being inputted
	syscall
	li $v0,4
	la $a0, q_end #print out the end for the question part ]=
	syscall
	li $v0,5 #get the integer value from user input for specific element of b
	syscall
	add $t0,$s1,$s4 #store address of b[i] at current i
	sw $v0, 0($t0) #store the value into current b[i]
	addi $s3,$s3,1 #increment loop value 
	j get_input #repeat until told to leave from bge at top of get_input
	
swap_start:
	li $s3,0 #the index of loop needs to be reset at this point
swap_loop:
	bge $s3,$s2,print_start #once index (s3) has reached num (s2),it must stop swapping
	sll $s4,$s3,2 #proper addressing based on index *4
	add $t0, $s0,$s4 #address for A[i] = old b[i]
	add $t1, $s1, $s4 #address for B[i]= old A[i]
	
	lw $t2, 0($t0)#creation of t2=A[i], used for temp
	lw $t3, 0($t1)#t3=B[i]
	
	sw $t3, 0($t0) #A[i]=B[i]
	sw $t2,0($t1)#B[i]=temp
	
	addi $s3,$s3,1 #increment index by 1 to go to next element
	j swap_loop
	
	
print_start:
	li $s3,0 #start loop index at 0
	#start with a new line before printing to keep out of the q_a and q_b area
	li $v0,4 #v0=4 means print string
	la $a0, nextLine 
	syscall
	
	
	
print_loop:

	bge $s3,$s2, system_end #if index>= num then there is nothing more to print
	sll $s4,$s3,2 #word=4, index*4 for proper address
	add $t0, $s0,$s4 #address for A[i] = old b[i]
	add $t1, $s1, $s4 #address for B[i]= old A[i]
	
	lw $t2, 0($t0) #load the new A[i]
	lw $t3,0($t1)#load new B[i]
	
	
	#print new A[i], then put a space, then print new B[i]
	li $v0,1 #print A[i]
	move $a0, $t2  #copy into a0 the A[i]
	syscall
	#print space
	li $v0,4 #tells to print string
	la $a0,space #string to print is space
	syscall
	#print B[i]
	li $v0,1 #v0=1 means print int
	move $a0,$t3 #copy into a0 but for B
	syscall
	
	#print a separatar bar as according to instructions
	li $v0,4 #v0=4 mean print string
	la $a0, separator #this string points to | in .data
	syscall
	
	addi $s3,$s3,1#increment the index
	j print_loop #repeat printing until the bge is true and goes to print
	
	
system_end:
	#end system since its done
	li $v0,10 #v0=10 mean system exit
	syscall
		
	
	
	
