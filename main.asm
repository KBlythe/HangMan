.data
picture: .asciiz 	"_______\n|   |  \\|\n        |\n        |\n        |\n        |\n        |\n        |\n       ---\n",
					"_______\n|   |  \\|\n    O   |\n        |\n        |\n        |\n        |\n        |\n       ---\n",
					"_______\n|   |  \\|\n    O   |\n    |   |\n    |   |\n        |\n        |\n        |\n       ---\n",
					"_______\n|   |  \\|\n    O   |\n   \\|   |\n    |   |\n        |\n        |\n        |\n       ---\n",
					"_______\n|   |  \\|\n    O   |\n   \\|/  |\n    |   |\n        |\n        |\n        |\n       ---\n",
					"_______\n|   |  \\|\n    O   |\n   \\|/  |\n    |   |\n   / \\  |\n        |\n        |\n       ---\n",

clearScreen: .asciiz "[2J"
.text

main:
	jal init
	jal runGame

runGame:
	# get input
	# test for correctness
	# if incorrect:
	jal drawMan
	beq $s0, 5, outOfGuesses
	addiu $s0, $s0, 1
	li $v0, 32 		#sleep
	li $a0, 500 	#for 500 ms
	syscall
	j runGame
	
init:
	li $s0, 0		# $s0 will hold the number of turns taken.
	jr $ra

drawMan:			# Expects $s0 to hold the number of turns taken.
	
	li $v0, 11 		# Print a character
	li $a0, 0x1b  	# Ascii excape
	syscall

	li $v0, 4 				# Print a string
	la $a0, clearScreen 	# Ascii escape sequence to clear screen
	syscall

	li $t1, 90 				# Each hangman guy is exactly 90 characters long
	mul $t0, $s0, $t1 		# Multiply it by the current number of moved used
	li $v0, 4 				# Print a string
	la $a0, picture 		# current hangman picture
	addu $a0, $a0, $t0
	syscall
	jr $ra

outOfGuesses:
	#:(