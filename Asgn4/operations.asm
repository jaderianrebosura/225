.text
.globl addnums 
addnums: 
	add a0, a0, a1
	ret

.text
.globl subnums 
subnums: 
	sub a0, a0, a1
	ret

.text
.globl multnums 
multnums:
	mul a0, a0, a1
	ret

.text
.globl divnums 
divnums:
	div a0, a0, a1
	ret
	
.text
.globl andnums 
andnums:
	and a0, a0, a1
	ret


.text
.globl ornums 	
ornums:
	or a0, a0, a1
	ret


.text
.globl xornums 
xornums:
	xor a0, a0, a1
	ret

	
.text
.globl lshiftnums 
lshiftnums:
	sll a0, a0, a1
	ret
	

.text
.globl unsignedrshiftnums 
unsignedrshiftnums:
	srl a0, a0, a1
	ret

	
	
