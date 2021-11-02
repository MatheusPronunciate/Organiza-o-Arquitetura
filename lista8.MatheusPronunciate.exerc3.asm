#main
.text
main:
	li $a0, 6
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
	li $v0, 1
	li $t0, 2
	
loop:	slt $t1, $a0, $t0
	bne $t1, $zero, fim
	mul $v0, $v0, $t0
	addi $t0, $t0, 1
	j loop 
fim:
	jr $ra