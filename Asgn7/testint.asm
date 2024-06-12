.text
.globl main
main: 
	jal initialization
	
	li a0, 42
	printLoop:
		jal printChar
		j printLoop 