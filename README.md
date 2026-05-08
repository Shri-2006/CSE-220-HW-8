114807762
Shriyans Singh


hw8a.asm
test case:
(type,size)
0,4 = triangle size 4 (right angled) works
0,1 = single *, works
1,3= square 3 levels of star, works
1,5 square 5 levels work
1,1 single * works
2,3 = centralized pyramind 3 levels, works
2,1= single star works 
2,7= pyramid 7 levels works


hw8b.asm
test cases:
A={1,2,3,4,5,6,7,8,9,10} B={11,12,13,14,15,16,17,18,19,20} result=11 1|12 2|13 3|14 4|15 5|16 6|17 7|18 8|19 9|20 10|
A={0,0,0,0,0,0,0,0,0,0} B={1,1,1,1,1,1,1,1,1,1} res=1 0|1 0|1 0|1 0|1 0|1 0|1 0|1 0|1 0|1 0|
A={1,1,1,1,1,1,1,1,1,1} B={0,0,0,0,0,0,0,0,0,0} res=0 1|0 1|0 1|0 1|0 1|0 1|0 1|0 1|0 1|0 1|
A={0,0,0,0,0,0,0,0,0,0} B={0,0,0,0,0,0,0,0,0,0} res= 0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|
A={1,1,1,1,1,1,1,1,1,1} B={1,1,1,1,1,1,1,1,1,1} res =1 1|1 1|1 1|1 1|1 1|1 1|1 1|1 1|1 1|1 1|
A={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1} B={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1} res =-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|-1 -1|

hw8c.asm
test cases:
v= 1,2,3,4,5,6,7,8,9,10 n=10 res= 10 9 8 7 6 5 4 3 2 1 
v= 1,2,3,4,5 n=5 res = 5 4 3 2 1 
v= 5,4,3,2,1 n=5 res = 5 4 3 2 1 
v=0,0,0,0,0,0,0,0,0,0 n=10 res= 0 0 0 0 0 0 0 0 0 0 
v= -1,-2,-3,-4,-5,-6,-7,-8,-9,-10 n=10 res =-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 
v= -1,-1,-1,-1,-1,-1,-1,-1,-1,-10    n=10 res =-1 -1 -1 -1 -1 -1 -1 -1 -1 -10 

hw8d.asm
I didn't brute save everything, I actually used all registers so it should be fine based on instructions
test cases:
first test case-
A: .word 1, 0, 0, 0
	.word 0, 1, 0, 0
	.word 0, 0, 1, 0
	.word 0, 0, 0, 1
B: .word 1, 2, 3, 4
	.word 5, 6, 7, 8
	.word 9, 10, 11, 12
	.word 13, 14, 15, 16
res =
1 2 3 4 
5 6 7 8 
9 10 11 12 
13 14 15 16 

second test case:

	A: .word 1, 2, 3, 4
	.word 5, 6, 7, 8
	.word 9, 10, 11, 12
	.word 13, 14, 15, 16
	B: .word 1, 1, 1, 1 
	.word 1, 1, 1, 1
	.word 1, 1 1, 1
	.word 1, 1, 1, 1
res:
10 10 10 10 
26 26 26 26 
42 42 42 42 
58 58 58 58 

third test case:
A: .word 1, 1, 1, 1
	.word 1, 1, 1, 1
	.word 1, 1, 1, 1
	.word 1, 1, 1, 1
	B: .word 1, 1, 1, 1
	.word 1, 1, 1, 1
	.word 1, 1 1, 1
	.word 1, 1, 1, 1

res:
4 4 4 4 
4 4 4 4 
4 4 4 4 
4 4 4 4 

fourth test case:
A: .word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	B: .word 1, 1, 1, 1
	.word 1, 1, 1, 1
	.word 1, 1 1, 1
	.word 1, 1, 1, 1
res:

-4 -4 -4 -4 
-4 -4 -4 -4 
-4 -4 -4 -4 
-4 -4 -4 -4     

fifth test case:
A: .word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	B: .word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1 -1, -1
	.word -1, -1, -1, -1
	
res:

4 4 4 4 
4 4 4 4 
4 4 4 4 
4 4 4 4 

sixth test case:
A: .word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	.word -1, -1, -1, -1
	B: .word -1, -1, -1, -1
	.word 0, 0, 0, 0
	.word 0, 0 0, 0
	.word 0, 1, 1, -1
res:
1 0 0 2 
1 0 0 2 
1 0 0 2 
1 0 0 2 