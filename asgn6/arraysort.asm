# Name: Jaderian Rebosura
# Name: Isha Varrier

.globl swap
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
	addi sp, sp, -24 # allocates space to preserve values into memory by subtracting 24 from the stack pointer
	sw ra, 20(sp) # location of the ra in memory (stack pointer - 4)
	sw s0, 16(sp) # location of the ra in memory (stack pointer - 8)
	sw s1, 12(sp) # location of the ra in memory (stack pointer - 12)
	sw s2, 8(sp) # location of the ra in memory (stack pointer - 16)
	sw s3, 4(sp) # location of the ra in memory (stack pointer - 20)
	sw s4, 0(sp) # location of the ra in memory (stack pointer - 24)
	
	mv s0, a0 # moves the array's address into a save reg
	mv s1, a1 # moves the value of the index (= 0) into a save reg
	mv s2, a2 # moves the value of the array's length into a save reg 
	
#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
    
#    int j;
	mv s3, zero # holds the index of a j variable that will be used throughout each iteration of a loop, gives it an initial value of 0

#    int min = i;
	mv s4, s1 # this holds the index of the minimum value throughout each iteration

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi s3, s1, 1 # increments the i variable by 1 

forloop:
# j < n
	bge s3, s2, endfor

#        /* if `arr[j]` is less, then it is the new minimum */
	slli t0, s3, 2 # shifts left by 2 (stores offset into s4... shifting by 4 due to the integers)
	add t0, t0, s0 # adds it to the original address
	
	lw t1, 0(t0) # loads the value of arr[j]
	
	slli t2, s4, 2 # shifting by 4
	add t2, t2, s0
	lw t3, 0(t2) # loads value of arr[min]

#        if (arr[j] < arr[min]) {
	blt t1, t3, if1
	j endif1
if1:
#            min = j;    /* update the index of minimum element */
	mv s4, s3 # min index now = current index of j 
#        }

endif1:
	addi s3, s3, 1 # increments j's index by 1
	b forloop # branches back to the forloop 


#    }
endfor:
	mv a0, s0
	mv a1, s4 # move min index
	mv a2, s1 # move index i 
	jal swap
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:
	addi s1, s1, 1 # adds 1 to the index "i"
	bgt, s1, s2, endif2 # if the length of the array is greater than the index, endif


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
	mv a0, s0 
	mv a1, s1 # moves onto next index 
	mv a2, s2 # length of the array 
	jal selectionSort # calls to a selectionSort subroutine

#caller teardown for selectionSort goes here (if needed).

#    }
endif2:
	# restores the preserved values within the stack
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	addi sp, sp, 24 # deallocates the space in the stack
	ret # returns

	
# callee teardown goes here


#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here
	addi sp, sp, -24 # allocates space to preserve values into memory by subtracting 24 from the stack pointer
	sw ra, 20(sp) # location of the ra in memory (stack pointer - 4)
	sw s0, 16(sp) # location of the ra in memory (stack pointer - 8)
	sw s1, 12(sp) # location of the ra in memory (stack pointer - 12)
	sw s2, 8(sp) # location of the ra in memory (stack pointer - 16)
	sw s3, 4(sp) # location of the ra in memory (stack pointer - 20)
	sw s4, 0(sp) # location of the ra in memory (stack pointer - 24)
	
	mv s0, a0 # moves the array's address into a save reg
	mv s1, a1 # moves the value of the index (= 0) into a save reg
	mv s2, a2 # moves the value of the array's length into a save reg 

#    int temp = arr[i];
	slli t0, s1, 2 
	add t0, t0, s0 
	lw t1, 0(t0) # t1 holds value of the i
	mv s3, t1 # temp

#    arr[i] = arr[j];
	slli t2, s2, 2
	add t2, t2, s0 
	lw t3, 0(t2) # arr[j]
	slli t0, s1, 2 # retrieving i
	add t0, t0, s0 # i's address
	sw t3, (t0) # arr[i] = arr[j]


#    arr[j] = temp;
	slli t2, s2, 2
	add t2, t2, s0
	sw s3, (t2)


# swap callee teardown goes here
	# restores the preserved values within the stack
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	addi sp, sp, 24 # deallocates the space in the stack
	ret # returns

#}
