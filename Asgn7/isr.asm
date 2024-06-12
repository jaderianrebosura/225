.globl initialization
initialization:
	addi sp, sp, -16 # allocating space on the stack 
	sw ra, 12(sp) # saving and storing the return address
	
	la t0, handler # handler address is loaded into t0 
	csrrw zero, utvec, t0 # sets handler's address
	
	li t2, 0x100
	csrrs zero, uie, t2 # sets uie in order to enable receiving of device interrupts
	
	la t3, RCR # RCR register's address loaded into t3
	lw t4, (t3) # loads the value from that address into t4
	li t5, 0 # loads zero into t5
	addi t5, t5, 2 # t5's value increased by 2
	sw t5, (t4) # essentially enables device to send interrupts
	
	csrrsi zero, ustatus, 1 # enabling global interrupts
	
	la a0, initializemsg
	jal printString # jumps and links to printString to print out initializemsg
	
	#restoring the return address, sp, and returns
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
handler: 
	addi sp, sp, -32 # allocating space on the stack
	sw t1, 28(sp) # preserving t1
	sw ra, 24(sp) # preserving ra
	sw t0, 20(sp) # preserving t0
	sw t2, 16(sp) # preserving t2
	sw t5, 12(sp) # preserving t5
	
	la a0, keyPressmsg
	jal printString # prints out the key that was pressed
	
	lw t0, RDR
	lbu t1, 0(t0) # loading the character that was pressed into t1
	
	mv a0, t1 # moves that character into a0
	sw a0, 8(sp) # saving character into the stack for later use
	jal printChar # prints out character
	li a0, '\n' 
	jal printChar # prints out a newline char
	lw a0, 8(sp) # loads the char pressed into a0
	
	la t0, interruptCount # loading the address of interruptCount 
	lw t2, (t0) # loads the value of the interruptCount into t2
	addi t2, t2, 1 # increments the count by 1
	li t5, 5 # loading '5' into t5
	beq t2, t5, returnMain # if the interruptCount is equal to 5, it branches to returnMain
	sw t2, (t0) # stores that value

	# restoring the registers backed to preserved state
	lw t5, 12(sp)
	lw t2, 16(sp)
	lw t0, 20(sp)
	lw ra, 24(sp)
	lw t1, 28(sp)
	addi sp, sp, 32 # stack pointer is restored
	uret
	
returnMain:
	la t1, mainAddress # loading address of mainAdress into t1
	lw t1, 0(t1) 
	
	csrrw zero, uepc, t1
	
	#sw t1, 24(sp) # sets return address to the start of main
	la t0, interruptCount
	sw zero, (t0)

	# restoring registers
	lw t5, 12(sp)
	lw t2, 16(sp)
	lw t0, 20(sp)
	lw ra, 24(sp)
	lw t1, 28(sp)
	addi sp, sp, 32
	uret
.data
	RCR: .word 0xffff0000 
	RDR: .word 0xffff0004 
	TCR: .word 0xffff0008 
	TDR: .word 0xffff000c
	interruptCount: .word 0
	mainAddress: .word main
	initializemsg: .string "Initializing Interrupts\n"
	keyPressmsg: .string "\nKey Pressed is: "
	
	
