#main
.text
main:
	li $a0, 7
	jal x
	
	jal halt
	
# subprograma: halt
# Encerra a execução da cpu
# Não recebe parametros
# Nao devolve valor.
.text
halt:
	li $v0, 10
	syscall

# Subprograma: X
# Recebe um valor >0 em $a0.
# Devolve a resposta em $V0.
.text
x:
	li $t0, 0
	li $t1, 1
	li $t2, 1
	li $v0, 0
	
loop:	add $v0, $t0, $t1
	add $t0, $zero, $t1
	add $t1, $zero, $v0
	addi $t2, $t2, 1
	
	slt $t3, $t2, $a0
	bne $t3, $zero, loop
	
	jr $ra