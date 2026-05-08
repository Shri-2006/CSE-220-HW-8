#Shriyans Singh 114807762

.data
	type: .asciiz "If you want Triangle press '0', or if you want Square '1' or if you want pyramid '2', must be an integer tho "
	size_q: .asciiz "How many levels should be implemented?"
	nL: .asciiz "\n"
	space : .asciiz " "
	stars: .asciiz "*"
	
.text
.globl main #textbook recommends making it gloabl
#main function will ask for type of shape then how long then print 
main:
	#ask for type of shape 
	li $v0,4 #4=print string
	la $a0, type #ask type
	syscall
	#read and save user type
	li $v0,5 #5=read int
	syscall
	move $s0,$v0 #save type of shape into s0 for a temp variable
	#start a new line before getting the amount of levels
	li $v0,4 #print string
	la $a0, nL #print \n 
	syscall
	
	#ask for size
	li $v0,4 #print string
	la $a0, size_q #ask size
	syscall
	#read size and store in a local variable (s1)
	li $v0,5 #readint
	syscall
	move $s1, $v0 #store in temp
	#separate with 2 new line to make it easier to see
	li $v0,4
	la $a0,nL #print new line
	syscall
	li $v0,4
	la $a0,nL#print second new line 
	syscall
	
	#if else statements 
	beqz $s0, triangle #if 0 draw triangle 
	li $t0,1 #variable to compare to
	beq $s0,$t0,square #call sqaure if 1
	li $t0,2 #compare against var
	beq $s0,$t0, pyramid#call pyramid if s0 is 2
	
	
done:
	li $v0,10 #exit system to end, prevents running through anything it should not do
	syscall
	
triangle:
	#copy size to a0 then draw triangle before going to done
	move $a0,$s1 
	jal d_triangle
	j done 

square:
	 	#copy size to a0 then draw squre before going to done
	move $a0,$s1 
	jal d_square
	j done 
	
pyramid:
	#copy size to a0 then draw pyramid before going to done
	move $a0,$s1 
	jal d_pyramid
	j done
	

# * counter
count_star:
	move $t0,$a0 #t0 is counter of stars remaining
#start printing
print_star_loop:
	beqz $t0, done_print #if reaches 0 jump to star_done 
	li $v0,4 #print star
	la $a0,stars #load address of * stringss
	syscall
	addi $t0,$t0,-1 #decrement the count of starsremaining
	j print_star_loop #repeat until told to skip in beqz
	
done_print:
	li $v0,4 #print string
	la $a0,nL#after each row is done start new row
	syscall
	jr $ra #return
	
d_triangle:
	#save registers for the loops
	addi $sp,$sp,-12 #3 variables to save = 3*4=12
	sw $ra,8($sp)#ra saved
	sw $s0,4($sp)#save row amount
	sw $s1, 0($sp) #savecurrent row
	move $s0,$a0 #push to s0 the row (a0)
	li $s1,1 #start rows at 1
	
triangle_loop:
	bgt $s1,$s0,triangle_finish#oncerow is more than total stop printing
	move $a0,$s1 #print *based on row number
	jal count_star
	addi $s1,$s1,1 #increment row number and repeat
	j triangle_loop
	
triangle_finish:
	lw $ra,8($sp)#get the return address
	lw $s0, 4($sp) #bring backtotal rows
	lw $s1,0($sp) #rownum
	addi $sp,$sp, 12 #free the stack
	jr $ra#return to caller 
	
d_square:
	#save registers for the loops-copied from triangle since its the exact same thing, i just want to keep it separate for each
	addi $sp,$sp,-12 #3 variables to save = 3*4=12
	sw $ra,8($sp)#ra saved
	sw $s0,4($sp)#save row amount
	sw $s1, 0($sp) #savecurrent row
	move $s0,$a0 #push to a0 the total row
	li $s1,1 #start rows at 1
	
square_loop:
	bgt $s1,$s0,square_finish #it requires row count >= length of sides to go to done properly
	move $a0,$s0 #get ready to print a row of stars
	jal count_star #start printing
	addi $s1,$s1,1 #increment count
	j square_loop#repeat
square_finish:
	lw $ra,8($sp)#get the return address
	lw $s0, 4($sp) #bring backtotal rows
	lw $s1,0($sp) #rownum
	addi $sp,$sp, 12 #free the stack
	jr $ra#return to caller 
	
d_pyramid:
	#save registers for the loops
	addi $sp,$sp,-16 #4 variables to save = 4*4=16
	sw $ra,12($sp)#ra saved
	sw $s0,8($sp)#save row amount
	sw $s1, 4($sp) #savecurrent row
	sw $s2,0($sp)#save space amount
	move $s0,$a0 #push to a0 the total row
	li $s1,1 #start rows at 1


pyramid_row_loop:
	blt $s0,$s1,pyramid_finish #if h<row, finsh
	#print the starting spaces
	sub $s2,$s0,$s1 #s2 is leading space #
pyramid_space_loop:
	beqz $s2,pyra_stars#once space are done start *
	li $v0,4 #print space
	la $a0,space 
	syscall
	addi $s2,$s2,-1 #decrement count of space each time
	j pyramid_space_loop
pyra_stars:
	move $s2,$s1 #change s2 to star count for individual rows
pyra_star_loop:
	beqz $s2, pyr_newline #once * finish start new line
	li $v0,4 #print once a *
	la $a0, stars
	syscall
	
	addi $s2,$s2,-1 #decrease count of star
	beqz $s2, pyr_newline #if last star, finihs
	li $v0,4#print space between stars to separte
	la $a0, space
	syscall
	
	j pyra_star_loop#repeat for next star
pyr_newline:
	li $v0,4 
	la $a0, nL #start new line
	syscall
	addi $s1,$s1,1 #start next row
	j pyramid_row_loop


pyramid_finish:
	lw $ra,12($sp)#get the return address
	lw $s0, 8($sp) #bring backtotal rows
	lw $s1,4($sp) #rownum
	lw $s2,0($sp)#space #
	addi $sp,$sp, 16 #free the stack
	jr $ra#return to caller 
