			.data
Welcome :	.asciiz "Input integer A"
Welcome1: 	.asciiz "Input integer B"
Welcome2: 	.asciiz "Input integer C"
Exit1 	:   .asciiz "Sum / A Quotient"
Exit2   :   .asciiz "Remainder"
Exit3   :   .asciiz "A*B*C = "





#-- Evan Blough (gotta love jumping back and forth from vhdl to mips to the point where you don't know the correct commment key)
#-- 10/17/18
#-- Multiply Numbers Mips
#-- ebblough
#-- Summary---------------------------
#-- User input three ints, A,B,C
#-- Compute (A+B+C) = S 
#-- S/A has quotient(Lo) and remainder(Hi)


.text



main:

#Print "Input integer A"
la $a0, Welcome
li $v0, 4
syscall

#Capture Int A $t0
li $v0, 5
syscall
add $t0, $v0, $zero

#Print "Input integer B"
la $a0, Welcome1
li $v0, 4
syscall

#Capture Int B $t1
li $v0, 5
syscall
add $t1, $v0, $zero

#Print "Input integer C"
la $a0, Welcome2
li $v0, 4
syscall

#Capture Int C $t2
li $v0, 5
syscall
add $t2, $v0, $zero

#Compute Sum, S $t3
add $t3, $t0, $t1
add $t3, $t3, $t2

#Compute A*B*C
mult $t0, $t1
mflo $t4
mult $t4, $t2
mflo $t4

#Display A*B*C
la $a0, Exit3
li $v0, 4
syscall

addi $a0, $t4, 0
li $v0, 1
syscall



#Perform Division

div $t3, $t0
 



#S/A quotient
la $a0, Exit1
li $v0, 4
syscall

mflo $t1 
addi $a0, $t1, 0
li $v0, 1
syscall

#S/A remainder
la $a0, Exit2
li $v0, 4
syscall
mfhi $t2
addi $a0, $t2, 0
li $v0, 1
syscall
