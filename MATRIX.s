
		.data

Mat1 : 	.double 1.25, 1.5, 1.25, 2.0
		.double 1.5, 1.75, 1.75, 1.5
		.double 1.5, 1.75, 1.75, 1.5
		.double 2.5, 2.0, 2.0, 2.5
		
Mat2 : 	.double 20.0, 10.0, 10.0, 1.0
		.double 10.0, 2.0, 10.0, 10.0
		.double 20.0, 10.0, 10.0, 1.0
		.double 10.0, 2.0, 10.0, 10.0
MatResult: 	
		.space 32
		.space 32
		.space 32
		.space 32
		
		.text
		
main:
#C Pseudo-Code Equivalent Algorithm I made for reference#########
#Why did it have to be in column major get the same result??????? 
# for( int j = 0; j < 4; j++){									|
#		for(int i = 0; i<4; i++){								|
#			double sum = 0;										|
#			for( int k = 0; k<4; k++){							|
#					double sum = sum + X[i, k] * Y[k, j]		|
#				}												|
#			Z[i, j] = sum;										|
#			}													|
#		}														|
#################################################################

	li $t1, 0 #i = 0
	la $s0, Mat1 # Base Adress Mat1
	la $s1, Mat2 # Base Adress Mat2
	la $s2, MatResult # Base Adress MatResult
	li $s3, 96 # Vertical/Row/i index boundary 
	li $s4, 24 # Horizontal/Column/j index boundary

L1: 
	li $t0, 0 #i = 0
L2:
	li $t2, 0 #ky = 0
	li $t7, 0 #kx = 0
	
	mtc1 $zero, $f1 # Sum = 0
L3:
	
	
	
	
	add $t3, $t0, $t2 	#Offset i + offset ky
	add $t4, $t7, $t1 	#Offset kx + offset #Offset whoo whoo whoo  
	add $t5, $t3, $s0 	#Base Adress + Offset Xd
	add $t6, $t4, $s1 	#Base Adress + Offset Yd
	
	l.d $f4, ($t5) 		#x <= value in array1 
	l.d $f2, ($t6)	 	#y <= Value in array2
	mul.d $f6, $f2, $f4 # Sum 
	add.d $f0, $f0, $f6 # Sum = X[i, k] + Y[k, i]
	
	addi $t2, $t2, 8	#++ky
	addi $t7, $t7, 32 	#++kx
	
	ble $t2, $s4, L3 	#if k < 4 continue loop

	
	add $t3, $t0, $t1 	#Offset i + Offset j
	add $t3, $t3, $s2 	#Offset(Base Result Matrix)
	sdc1 $f0, ($t3) 			#Z[i,j] = Sum
	
	
	addi $t0, $t0, 32 	#i++
	ble $t0, $s3, L2	#if i < 4 continue loop
	
	addi $t1, $t1, 8
	ble $t1, $s4, L1 	#if j < 4 continue loop
	
	#ldc1 $f12, 48($s2)
	#li $v0, 3
	#syscall
	
	addi $t0, $s2, 0
	li $s0, 32
	addi $s1, $s2 120
	##Output Matrix
OutputLoop:
	##Output Pseudo-Code
	##While ( i =< 120)
	##print dub[i] = MatResult 
	##i++
	##if i % 32 = 0 
	##newline
	##else 
	##tab
	##Matthew Kelly
	##Matthew Kelly
	##Sunday Oct 14 at 4:13pm
	##You are welcome to statically assign your matrix,
	
	
	ldc1 $f12, ($t0) 	#load dub[i]
	li $v0, 3 			#print dub[i]
	syscall
	addi $t0, $t0, 8	#i++
	sub $t2, $t0, $s2
	beq $t2, $zero, space
	
	div $t2, $s0
	mfhi $t1
	beq $t1, $zero, newline
space:	
	addi $a0, $0, 9 	#tab character
    addi $v0, $0, 0xB 	#print newline
    syscall
	
	ble $t0,$s1, OutputLoop
	
newline:
	addi $a0, $0, 0xA 	#newline character
    addi $v0, $0, 0xB 	#print newline
    syscall
	 
	ble $t0,$s1, OutputLoop

	
	
	
	
	
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	