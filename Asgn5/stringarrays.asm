# Name: Jaderian Rebosura
# Name: Isha Varrier

#runtest using 123456789 as the text input for readstring.
.text
.globl main
main:

#init saved registers.
li s0, -1
li s1, -1
li s2, -1
li s3, -1
li s4, -1
li s5, -1
li s6, -1
li s7, -1
li s8, -1
li s9, -1
li s10, -1
li s11, -1

#init temp registers.
li t0, -1
li t1, -1
li t2, -1
li t3, -1
li t4, -1
li t5, -1
li t6, -1


#init arg registers.
li a0, -1
li a1, -1
li a2, -1
li a3, -1
li a4, -1
li a5, -1
li a6, -1
li a7, -1

li a4, 110

enter_and_print:
	la a0, enterFirst #asking for Enter first word:
	jal printstring
	
	la a0, mystr
	jal readstring
	
	la a0, enterSecond
	jal printstring

	la a0, mystr2
	jal readstring
	
	la a0, result1
	jal printstring
	
	la a0, mystr
	jal printstring
	
	la a0, result2
	jal printstring

	la a0, mystr2
	jal printstring
	
checkinglen:
	la a0, lenOne  #checking len 1
	jal printstring

	la a0, mystr #going to function for len 1
	jal strlen
	
	jal printint # printing len 1
	
	la a0, lenTwo
	jal printstring
	
	la a0, mystr2
	jal strlen

	jal printint
	
comparing_str:
	la a0, mystr
	la a1, mystr2
	jal strcmp
	jal printstring
	
copying_str:
	la, a0, copyMessage
	jal printstring

	la a0, mystr2
	la a1, new_dest
	
	jal strcpy
	jal printstring
	
reverse_str:
	la a0, reverseMessage
	jal printstring
	la a0, mystr
	la a1, new_dest
	
	jal strrev
	jal printstring

str_concatenation:
	la a0, concatenation
	jal printstring
	
	la a0, mystr
	la a1, mystr2
	la a2, new_dest
	
	jal strcat
	jal printstring

str_mixing:
	la a0, blended
	jal printstring
	
	la a0, mystr
	la a1, mystr2
	la a2, new_dest
	
	jal strmix
	jal printstring

 finalPrint:
	la a0, enterFirstFin #asking for Enter first word:
	jal printstring
	
	la a0, mystr
	jal readstring
	
	la a0, enterSecondFin
	jal printstring

	la a0, mystr2
	jal readstring

 	la a0, continue
 	jal printstring
 	jal readchar
 	
 	if_no:
 		beq a0, a4, exit
 	b enter_and_print	

exit:
	la a0, exiting
	jal printstring
	jal exit0
	
	jal calleesavecheck
	
	beqz a0, calleepass
	la a0, calleefailmsg
	jal printstring
	sw zero, flagval, t6

calleepass:

strlenpass:

strcheck:
	la t0, myrslt
	la t1, mystr
	li t2, 0
	
strchkloop:
	lb t3, 0(t0)
	lb t4, 0(t1)
	bne t3, t4, strchkfail
	addi t0, t0, 1
	addi t1, t1, 1
	addi t2, t2, 1
	li t5, 20
	blt t2, t5, strchkloop
	la a0, strchkpassmsg
	jal printstring
	b strchkpass
	
strchkfail:
	la a0, strchkfailmsg
	jal printstring
	
strchkpass:

regusechk:
	lw, t0, flagval
	beqz t0, exit1
	
	la a0, testpassmsg
	jal printstring
	
	li a7, 10
	ecall

exit1:
	li a0, -1
	li a7, 93
	ecall
	
.data
	flagval: .word -1
	enterFirst: .string "Enter first word: "
	enterSecond: .string "Enter second word: "
	enterFirstFin: .string "\nEnter first word: "
	enterSecondFin: .string "Enter second word: "
	lenOne: .string "\nLength of the first word: "
	lenTwo: .string "\nLength of the second word: "
	copyMessage: .string "\nThe new copied word is: "
	reverseMessage: .string "\nThe reversed word is: "
	concatenation: .string "\nThe concatenated word is: "
	blended: .string "\nThe blended word is: "
	myrslt: .string "123456789"
	.byte -1 -1 -1 -1 -1 -1 -1 -1 -1
	result1: .string "First word: "
	result2: .string "\nSecond word: "
	continue: .string "Continue (y/n)?: "
	exiting: .string "\nExiting"
	testpassmsg: .string "\n Readstring register usage test passed."
	calleefailmsg: .string "\nFail: Callee/Caller register usage problems"
	strchkpassmsg: .string "\nFail: string not stored correctly. either chars not stored in correct locaiton, newline detected,or nullchar not stored"
	strchkfailmsg: .string "\nString read and stored correctly"
	strlenfailmsg: .string "\nFail: String too long, or chars not stored as bytes"
	mystr: .space 21
	mystr2: .space 20
	mystr1Fin: .space 21
	mystr2Fin: .space 20
	new_dest: .space 20
	reverse_dest: .space 20
	
.text
calleesavecheck:
	li t1, -1
	bne s0, t1, calleesavecheckfail
	bne s1, t1, calleesavecheckfail
	bne s2, t1, calleesavecheckfail
	bne s3, t1, calleesavecheckfail
	bne s4, t1, calleesavecheckfail
	bne s5, t1, calleesavecheckfail
	bne s6, t1, calleesavecheckfail
	bne s7, t1, calleesavecheckfail
	bne s8, t1, calleesavecheckfail
	bne s9, t1, calleesavecheckfail
	bne s10, t1, calleesavecheckfail
	bne s11, t1, calleesavecheckfail
	
	li t1, -1
	bne s0, t1, calleesavecheckfail
	bne s1, t1, calleesavecheckfail
	bne s2, t1, calleesavecheckfail
	bne s3, t1, calleesavecheckfail
	bne s4, t1, calleesavecheckfail
	bne s5, t1, calleesavecheckfail
	bne s6, t1, calleesavecheckfail
	bne s7, t1, calleesavecheckfail
	bne s8, t1, calleesavecheckfail
	bne s9, t1, calleesavecheckfail
	bne s10, t1, calleesavecheckfail
	bne s11, t1, calleesavecheckfail
	
	li a0, 0
	ret
	
calleesavecheckfail:
	li a0, 1
	ret
