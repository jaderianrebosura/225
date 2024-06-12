# Name: Jaderian Rebosura
# Name: Isha Varrier

# subprogram: Printint
.globl printInt
.text
printInt:
	addi sp, sp, -16 # allocates space in the stack
	sw ra, 12(sp) # saves the return address
	
	addi a0, a0, 48 # from int to ascii
	
	jal tpoll
	
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
# subprogram: PrintString
.globl printString
.text
printString:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	
	mv s0, a0 
	lb a0, (s0)
	
printStrLoop:
	jal tpoll
	li t0, '\0'
	addi s0, s0, 1
	lb a0, (s0)
	bne a0, t0, printStrLoop
	
endPrintStr:
	lw s0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
		
# subprogram: ReadString
.globl readString
.text
readString:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	sw s1, 4(sp)
	
	mv s0, a0
	
	readStrloop:
	jal rpoll
	
	li s1, 0x0A
	beq s1, a0, endreadStrPoll
	
	sb a0, 0(s0)
	addi s0, s0, 1
	b readStrloop
	
	endreadStrPoll:
	li t1, '\0'
	sb t1, (s0)
	mv a0, s0
	
	lw s1, 4(sp)
	lw s0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# subprogram: PrintChar
.globl printChar
.text
printChar:
	addi, sp, sp, -16
	sw ra, 12(sp)
	
	jal tpoll
	
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
# subprogram: ReadChar
.globl readChar
.text
readChar:
	addi sp, sp, -16
	sw ra, 12(sp)
	
	jal rpoll
	
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
# subprogram: ReadInt
.globl readInt
.text
readInt:
	addi sp, sp, -16
	sw ra, 12(sp)
	
	jal rpoll
	
	addi a0, a0, -48
	
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
# subprogram: Exit
.globl exitProgram
.text
exitProgram:
	li a7, 10
	ecall
	ret
	
tpoll:
	mv t2, a0 
	lw t1, TCR # address of TCR is loaded
	lw t0, (t1) # loads val at address of TCR
	andi t0, t0, 1 # mask to check if t0 = 0 or 1
	beq t0, zero, tpoll # if 0, loop back to tpoll
	lw t1, TDR 
	sb t2, (t1) # stores at the address in TDR
	
	mv a0, t2
	ret
	
rpoll:
	lw t1, RCR # gets RCR address
	lw t0, (t1) # retrieves RCR val
	andi t0, t0, 1
	beq t0, zero, rpoll # if zero, branch back to rpoll
	lw t1, RDR # get RDR address that holds char
	lbu a0, 0(t1) # reads char
	ret
	
.data
	RCR: .word 0xffff0000
	RDR: .word 0xffff0004
	TCR: .word 0xffff0008
	TDR: .word 0xffff000c
