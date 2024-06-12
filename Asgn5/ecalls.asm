#printint
.globl printint
.text
printint:
	li a7, 1 
	ecall
	ret
	
	

#printstring
.globl printstring
.text
printstring:
	addi a7, zero, 4 
	ecall
	ret

#readstring
.globl readstring
.text
readstring:

	sw s0, rchar_address, t6 #save the value of the save register
	mv s0, a0 #moving inputed string's address argument into s0 register
	
	sw s1, charEntered, t5
	li s1,  0x0A
	
	sw ra, rchar_ra, t0 # preserve the return address.
	
	loop: 
		bge s1, a0, endloop #if the char is enter, branch to end loop
		jal readchar #jumping to read char -- now the char is in a0
		bge s1, a0, endloop
		sb a0, 0(s0) #storing char into address at s0
		addi s0, s0, 1 #incrementing address by one byte
		b loop
	endloop:
		sb zero, 0(s0) #store the null character 
		lw ra, rchar_ra # restore the return address
		lw s0, rchar_address
		lw s1, charEntered # restore the return address
		ret
	


# subprogram: printchar
# purpose: To print a char to the console
# input: a0 - The address of the string to print.
# a1 - The value of the char to print
# returns: None
# side effects: The String is printed followed by the integer value.
.globl printchar
.text
printchar:
	li a7, 11 # service call ‘1’ for printint
	ecall
	ret

#readchar
.globl readchar
.text
readchar:
	li a7, 12 # service call ‘12’ for readchar
	ecall
	ret


#readint
.globl readint
.text
readint:
	li a7, 5 # service call ‘5’ for readint
	ecall
	ret
	
	
	
	
#exit0
.globl exit0
.text
exit0:
	li a7, 10
	ecall
	ret


.data 
rchar_ra: .word 0 #restore the return address
rchar_address: .word 0 
charEntered: .word 0
