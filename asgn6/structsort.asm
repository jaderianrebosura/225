# Name: Jaderian Rebosura
# Name: Isha Varrier

.globl swap
.globl selectionSort
.globl printArray

#struct def'n for reference
#struct studentNode {
#   char name[6];
#   int studentid;
#   int coursenum;
#};

 
#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
#callee setup goes here
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp)
	sw s1, 12(sp)
	sw s2, 8(sp)
	sw s3, 4(sp)
	sw s4, 0(sp)
	
	mv s0, a0 # array address
	mv s1, a1 # (i) index = zero
	mv s2, a2 # length of the array
    
#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
#    int j;
	mv s3, zero
#    int min = i;
	mv s4, s1

#    for (j = i + 1; j < n; j++)    {
for1:
	addi s3, s1, 1

forloop1:
	bge s3, s2, endfor1 # if j is greater than n
	
#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
	slli t0, s4, 4 # shifts left 4 in order to access the value @ by 8
	add t0, t0, s0 # adds it to the original address
	addi t0, t0, 8 # adding 8 in order to reach the end of the 16 byte value and onto the next 
	
	lw t1, 0(t0) # loading the value
	
	slli t0, s3, 4 # shifting by 4
	add t0, t0, s0
	addi t0, t0, 8
	lw t2, 0(t0) # loads value of arr[min]
	
	ble t2, t1, if1
	addi s3, s3, 1
	b forloop1

if1:
#            min = j;    /* update the index of minimum element */
	mv s4, s3
	mv t1, t2
#        }
endif1:
	addi s3, s3, 1
	b forloop1


endfor1:
	mv a0, s0
	mv a1, s4 # move min index
	mv a2, s1 # move index i 
	jal swap


if2:
	addi s1, s1, 1
	bge s1, s2, endif2
	
	mv a0, s0
	mv a1, s1
	mv a2, s2
	jal selectionSort

#    }
endif2:
#callee teardown goes here (if needed)
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	addi sp, sp 24
	ret

#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here
	addi sp, sp, -20
	sw ra, 16(sp)
	sw s0, 12(sp)
	sw s1, 8(sp)
	sw s2, 4(sp)
	
	li s0, -1 # setting i = -1
	mv s1, a0 # this saves start of the array


#    int i;

#    for (i = 0; i < n; i++) {

for2:
	addi s0, s0,1 


forloop2:
	bge s0, a1, endfor2
	slli t0, s0, 4
	add t1, t0, s1 # adds t0 to the start of the array s1 in order to find the "block" of the struct
	
	lw a0, 8(t1) # this prints the student id first
	li a7, 1
	ecall
	
	li a0, ' ' # prints a space between the id and name
	li a7, 11
	ecall
	
	addi a0, t1, 0 # prints the student's name
	li a7, 4
	ecall
	
	li a0, ' ' # prints a space between the student's name and the course number
	li a7, 11
	ecall
	
	lw a0, 12(t1) # this prints the course number
	li a7, 1
	ecall
	
	li a0, '\n' # prints a new line
	li a7, 11
	ecall
	
	b for2

#use ecalls to implement printf
#        printf("%d ", arr[i].studentid);


#        printf("%s ", arr[i].name);


#        printf("%d\n", arr[i].coursenum);


#    }
endfor2:
	lw s2, 4(sp)
	lw s1, 8(sp)
	lw s0, 12(sp)
	lw ra, 16(sp)
	addi sp, sp, 20
	ret

#caller teardown goes here

#}
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp)
	sw s1, 12(sp)
	sw s2, 8(sp)
	sw s3, 4(sp)
	sw s4, 0(sp)	
	

	# address calculation of struct[i] 
	slli t0, a1, 4 # i * 16 (struct size)
	add t0, t0, a0 # base address + offset
	
	# address calculation of struct[j]
	slli t1, a2, 4 # i * 16
	add t1, t1, a0 # base address + offset
	
	# stores struct[i] temporarily in the stack
	lw s0, 0(t0) 
	lw s1, 4(t0)
	lw s2, 8(t0)
	lw s3, 12(t0)
	
	#arr[i] = arr[j];
	lw t2, 0(t1)
	sw t2, 0(t0)
	lw t2, 4(t1)
	sw t2, 4(t0)
	lw t2, 8(t1)
	sw t2, 8(t0)
	lw t2, 12(t1)
	sw t2, 12(t0)
	
	#arr[j] = temp;
	sw s0, 0(t1)
	sw s1, 4(t1)
	sw s2, 8(t1)
	sw s3, 12(t1)

#caller teardown goes here
	lw s4, 0(sp)
	lw s3, 4(sp)
	lw s2, 8(sp)
	lw s1, 12(sp)
	lw s0, 16(sp)
	lw ra, 20(sp)
	addi sp, sp 24 # restores sp
	ret

#}
