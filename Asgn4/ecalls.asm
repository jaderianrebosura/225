# printint
.text
.globl printint
printint:
	li a7, 1
	ecall 
	ret
# printstring
.text
.globl printstring
printstring:
	li a7, 4
	ecall
	ret
# printchar
.text
.globl printchar
printchar:
	li a7, 11
	ecall
	ret
# readchar
.text 
.globl readchar
readchar:
	li a7, 12
	ecall
	ret
# readint
.text
.globl readint
readint:
	li a7, 5
	ecall
	ret
# exit0
.text
.globl exit0
exit0: 
	li a7, 10
	ecall
	ret


















