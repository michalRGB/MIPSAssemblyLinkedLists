.data
	message1: .asciiz "Podaj rozmiar wektorow: "
	message2: .asciiz "Podaj kolejny element wektora 1: "
	message3: .asciiz "podaj kolejny element wektora 2: "
	.align 4
	wektor1: .space 12 # wartosc pozycja nastepny chyba ze jest zero
	wektor2: .space 12
.text
	la $a0 message1
	jal printMessage
	li $v0 5
	syscall
	move $s0 $v0 # rozmiar
	
	li $s1 0 # licznik
	li $s2 0 # rzeczywisty rozmiar wektora 1
	
	la $s3 wektor1
	
	wczytywanie1:
		beq $s1 $s0 wektor2wczytywanie
		la $a0 message2
		jal printMessage
		
		li $v0 5
		syscall
		
		beqz $v0 continue1
		
		sw $v0 0($s3)
		addi $s3 $s3 4
		addi $s2 $s2 1
		sw $s1 0($s3)
		addi $s3 $s3 4
		
		li $v0 9
		li $a0 12
		syscall
		
		sw $v0 0($s3)
		lw $s3 0($s3)
		
		continue1:
			addi $s1 $s1 1
			j wczytywanie1
	wektor2wczytywanie:
	li $s1 0 # licznik
	li $s4 0 # rzeczywisty rozmiar wektora 2
	
	la $s3 wektor2
	wczytywanie2:
		beq $s1 $s0 scalarProduct
		la $a0 message3
		jal printMessage
		
		li $v0 5
		syscall
		
		beqz $v0 continue2
		
		sw $v0 0($s3)
		addi $s3 $s3 4
		addi $s4 $s4 1
		sw $s1 0($s3)
		addi $s3 $s3 4
		
		li $v0 9
		li $a0 12
		syscall
		
		sw $v0 0($s3)
		lw $s3 0($s3)
		
		continue2:
			addi $s1 $s1 1
			j wczytywanie2
	
	scalarProduct:
	li $s1 0 # indeksator wektora 1
	la $s3 wektor1
	li $s5 0 # indeksator wektora 2
	la $s6 wektor2
	li $s7 0
	while:
		beq $s1 $s2 end
		beq $s5 $s4 end
		lw $t0 4($s3)
		lw $t1 4($s6)
		bne $t0 $t1 pierwsze
		lw $t0 0($s3)
		lw $t1 0($s6)
		mul $t3 $t0 $t1 
		add $s7 $s7 $t3
		add $s1 $s1 1
		add $s5 $s5 1
		lw $s3 8($s3)
		lw $s6 8($s6)
		j while
		pierwsze:
			bgt $t0 $t1 drugie 
			lw $s3 8($s3)
			add $s1 $s1 1	
			j while
		drugie:
			lw $s6 8($s6)
			add $s5 $s5 1
			j while
	
	
	end:
		li $v0 1
		move $a0 $s7
		syscall
		li $v0 10
		syscall
	
	printMessage:
		li $v0 4
		syscall
		jr $ra
