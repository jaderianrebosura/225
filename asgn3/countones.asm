.text
main:
		la a0, welcome
		li a7, 4
		ecall #prints the welcome message 

while_loop:
		la a0, prompt1
		li a7, 4
		ecall # prints out prompt1
		
		li a7, 5
		ecall # reads the integer input for prompt1
		mv t0, a0 # preserves the number 
		
		li t1, 'n'
		beq t0, t1, exit
		
		mv t0, t0
		
		li t1, 0 # should set count to zero
		li t2, 0 # count for loops should be set to zero 
		
		bltz t0, negative_int
		j continue_while
negative_int:
		not t0, t0
		addi t0, t0, 1
		
continue_while:
		while: 
			beqz t0, endwhile # exit the loop when t0 is equal to zero
			andi t3, t0, 1
			beqz t3, right_shift
			addi t1, t1, 1
			
		right_shift:
			srai t0, t0, 1
			addi t2, t2, 1 
			j while
			
		endwhile:
		la a0, response
		li a7, 4
		ecall # prints out the response statement
		
		mv a0, t1
		li a7, 1
		ecall
		
		la a0, prompt2
		li a7, 4 
		ecall # prints out prompt2	
		
		li a7, 8
		ecall
		mv t3, a0
		li t4, 'n'
		beq t3, t4, exit
		
		j while_loop
																
	
exit:
		la a0, exit_statement
		li a7, 4
		ecall # prints the exit statement when user inputs "n" in response to prompt2

		li a7, 10
		ecall # return 0 to exit the program


.data
	userNum: .word 0
	count: .word 0x0
	userInput: .byte 'y'
	welcome: .string "Welcome to the CountOnes program.\n"
	prompt1: .string "\n\nPlease enter a number: "
	response: .string "The number of bits set is: "
	prompt2: .string "\n Continue (y/n)?:  " 
	exit_statement: .string "Exiting"
	



