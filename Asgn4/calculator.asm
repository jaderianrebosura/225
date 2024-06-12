#Name: Jaderian Rebosura
#Name: Isha Varrier

.text
main:
	li s2,'n' #loading the character 'n' 
	addi s3, s3,0 #used to keep count
	
	# assigning the immediate values that coordinate with specific operations to registers 
	addi t0, t0, 1 #addition
	addi t1, t1, 2 #subtraction
	addi t2, t2, 3 #multiplication
	addi t3, t3, 4 #division
	addi t4, t4, 5 #and
	addi t5, t5, 6 #or
	addi t6, t6, 7 #xor
	addi a5, a5, 8 #lshift
	addi a6, a6, 9 #unsignedrshift

	# printstring ecall so that the welcome message can be printed out
	la a0, welcome
	jal printstring
	
	# JAL to a prinstring ecall so that the list of operations can be printed out
	la a0, operationsList
	jal printstring
	
	
while: 
	# JAL to printstring ecall so that the number of operations message is printed out
	la a0, performedOperations
	jal printstring
	mv a0, s3
	jal printint # JAL so that it prints the integer value of the number of performed operations
	
	# JAL to printstring ecall to print out the first prompt
	la a0, prompt1 
	jal printstring
	jal readint # JAL so that it reads the first integer value inputed by the user
	mv s0, a0
	
	# JAL to printstring ecall to print out the second prompt
	la a0, prompt2
	jal printstring
	jal readint # JAL so that it reads the integer value inputed by the user
	mv s1, a0
	
	# JAl to printstring ecall to print out the third prompt
	la a0, prompt3
	jal printstring
	jal readint # JAL so that it reads the integer value of the operation the user wants performed
	
	# if statement that branches the program to one of the 9 operations if the value of the operation inputed by the user is equal to what is found in the register
	if: 
		beq a0, t0, addition
		beq a0, t1, subtraction
		beq a0, t2, multiplication
		beq a0, t3, division
		beq a0, t4, andoperation
		beq a0, t5, oroperation
		beq a0, t6, xoroperation
		beq a0, a5, lshift
		beq a0, a6, unsignedrshift
		else: 
			la a0, invalidResponse
			jal printstring
	
			la a0, continuePrompt
			jal printstring # JAL so that it prints out the continuePrompt
			jal readchar # JAL so that it reads if the user inputed a char value of 'y' or 'n'

			if_n: 
				beq a0, s2, exit
			addi s3, s3, 1
			b while			
			
		
addition:
	mv a0, s0
	mv a1, s1
	jal addnums
	mv s0, a0
	b overall

subtraction:
	mv a0, s0
	mv a1, s1
	jal subnums
	mv s0, a0
	b overall
	
multiplication:
	mv a0, s0
	mv a1, s1
	jal multnums
	mv s0, a0
	b overall

division:
	mv a0, s0
	mv a1, s1
	jal divnums
	mv s0, a0
	b overall

andoperation:
	mv a0, s0
	mv a1, s1
	jal andnums
	mv s0, a0
	b overall

oroperation:
	mv a0, s0
	mv a1, s1
	jal ornums
	mv s0, a0
	b overall

xoroperation:
	mv a0, s0
	mv a1, s1
	jal xornums
	mv s0, a0
	b overall

lshift:
	mv a0, s0
	mv a1, s1
	jal lshiftnums
	mv s0, a0
	b overall

unsignedrshift:
	mv a0, s0
	mv a1, s1
	jal unsignedrshiftnums
	mv s0, a0
	b overall 
	
overall: 
	la a0, resultResponse
	jal printstring # JAL so that it prints the result response 
	mv a0, s0
	jal printint # JAL so that it prints out the result as an integer value
	
	la a0, continuePrompt
	jal printstring # JAL so that it prints out the continuePrompt
	jal readchar # JAL so that it reads if the user inputed a char value of 'y' or 'n'

	if_not: 
		beq a0, s2, exit
	addi s3, s3, 1
	b while 
	
	
exit: 
	addi s3, s3, 1
	
	la a0, newLine
	jal printstring
	
	# JAL to printstring ecall so that the number of operations message is printed out
	la a0, performedOperations
	jal printstring
	mv a0, s3
	jal printint # JAL so that it prints the integer value of the number of performed operations

	# JAL to printstring ecall so that the exit statement is printed out 
	la a0, exitStatement
	jal printstring
	
	jal exit0 # JAL to exit0 ecall to exit the program 
	

.data
	# messages as string variables 
	welcome: .string "Welcome to the Calculator program.\n"
	operationsList: .string "Operations - 1:add 2:subtract 3: multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift\n"
	newLine: .string "\n"
	performedOperations: .string "\n\nNumber of operations performed: "
	prompt1: .string "\nEnter number: "
	prompt2: .string "Enter second number: "
	prompt3: .string "Select operation: "
	resultResponse: .string "Result: "
	continuePrompt: .string "\nContinue (y/n)?: "
	invalidResponse: .string "Invalid operation"
	exitStatement: .string "\nExiting"
