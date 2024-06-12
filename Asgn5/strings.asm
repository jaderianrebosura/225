#strlen
.globl strlen
.text
strlen:
	    mv t0, a0       # move string address to t0 
	    li t1, 0        # initialize t1 to 0
	
	loop:
	    lb t2, 0(t0)    # load byte from memory at address t0 into t2 
	    beq t2, zero, end    # if byte is zero exit the loop
	    addi t0, t0, 1  # increment pointer to next char
	    addi t1, t1, 1  # increment count
	    j loop          # repeat
	
	end:
	    mv a0, t1       # returns the count in a0
	    ret
	    
#strcmp	    
.globl strcmp
strcmp:
	mv t0, a0 #moves 1st address to t0
	mv t1, a1 #moving 2nd address to t1
	

	compare_loop:
		lb t4, 0(t0) #load char from str 1
		lb t5 0(t1) #load char from str 2
		
		
		SstrCMPloop: 
			bne t4, t5, endFalse #check if chars don't match
			
		
		secondNull:
			beq t5, zero, endTrue #if 2nd is also reached
		
		# incrementing by 1
		addi t0, t0, 1
		addi t1, t1, 1
		j compare_loop # jumps to the compare_loop
			
	
		endFalse:

			la a0, strcmpF
			ret
		
		endTrue:
			la a0, strcmpT
			ret

#strcpy	
.globl strcpy
strcpy:
	mv t0, a0 #moving 1st address to t0
	mv t1, a1 #moving 2nd address to t1
	mv t2, a1
	
	
	copy_loop:
		lb t4, 0(t0) #getting char from str 
		beq t4, zero, end_copy_loop
		
		sb t4, 0(t1) #store char 
		
		addi t0, t0, 1 #goes to next
		addi t1, t1, 1
		
		j copy_loop
	
	end_copy_loop:
		sb zero, 0(t1) #null
		mv a0, t2
		ret 

#strrev	
.globl strrev
strrev:
    mv t0, a0       # t0 = Pointer to input string (start)
    mv t1, a1       # t1 = Pointer to destination (new string)
    mv t4, a1

    find_end:
        lb t2, 0(t0)   # Load byte from input string
        beq t2, zero, rev_loop   # if the end is found, reverses
        addi t0, t0, 1  # moves to the next char
        j find_end      # repeats until all chars have been covered

    rev_loop:
    	addi t0, t0, -1
        lb t2, 0(t0)    # load byte from input string (backwards)
        sb t2, 0(t1)    # stores byte in the new string
        addi t1, t1, 1  # move forward through new string
        beq t0, a0, end_rev  # repeats until it reaches the beginning char
        b rev_loop
        
   end_rev:
    sb zero, 0(t1)       # null-terminate the reversed string
    mv a0, t4            # return pointer to the reversed string
    ret


#strcat
.globl strcat
strcat:
  # save the return address
  mv   t3, a2

  # find the end of the first string
  first_cat:
    lb   t5, 0(a0)
    beq  t5, zero, second_cat  # If null terminator found, jump to 2nd string

    # append character from first string
    sb   t5, 0(a2)
    addi  a0, a0, 1
    addi  a2, a2, 1
    j    first_cat

  #fFind the end of the second string and append remaining characters
  second_cat:
    lb   t5, 0(a1)
    beq  t5, zero, end_cat  # if null terminator found, end concatenation

    # append character from second string
    sb   t5, 0(a2)
    addi  a1, a1, 1
    addi  a2, a2, 1
    j    second_cat

  # terminate the concatenated string
  end_cat:
    sb   zero, 0(a2)  # write null terminator to the destination string

  # restore the return address and return
  mv   a0, t3
  ret


#strmix
.globl strmix
strmix:
	
	mv   t0, a0
  	mv   t1, a1
 	mv   t2, a2
 	mv   t3, a2 #saving the return address
	
	first:
		lb t5, 0(t0)
		beq t5, zero, first_final #null of first
		sb t5, 0(t2) #storing byte into value
		addi t0, t0, 1
		addi t2, t2, 1

	
	check_second:
		lb t5, 0(t1)
		beq t5, zero, second_final
		sb t5, 0(t2)
		addi t1, t1, 1
		addi t2, t2, 1
	j first
	
	first_final:
		lb t5, 0(t1)
		beq t5, zero, end_mix
		sb t5, 0(t2)
		addi t1, t1, 1
		addi t2, t2, 1
		j first_final
	
	second_final:
		lb t5, 0(t0)
		beq t5, zero, end_mix
		sb t5, 0(t2)
		addi t0, t0, 1
		addi t2, t2, 1
		j second_final

	end_mix:
		sb zero, 0(t2)       # Null-terminate the reversed string
    		mv a0, t3            # Return pointer to the reversed string
    		ret

	
.data 
savedra: .word 0 #restore the returna address
strcmpF: .string "\nThe first and second words are NOT the same."
strcmpT: .string "\nThe first and second words are the same."
