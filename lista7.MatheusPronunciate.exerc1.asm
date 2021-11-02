# no final do código, uma versão em c comentada estará disponível (fiz em c e depois em asm)

.data

arrV:	.word 0 : 10

msg1:	.asciiz "você vai inserir números inteiros agora\n" 
msg2:	.asciiz "insira um número: \n"

pos:	.asciiz " é um número positivo\n"
neg:	.asciiz " é um número negativo\n"

nenneg:	.asciiz "nenhum número negativo foi inserido\n"
nenpos:	.asciiz "nenhum número positivo foi inserido\n"

quantneg:	.asciiz " números negativos foram inseridos\n"
quantpos:	.asciiz " números positivos foram inseridos\n"

.text
.globl main

main:
	li $s0, 0	#totalpos = 0
	li $s1, 0	#totalneg = 0
	li $s2, 0	# i = 0
	li $s3, 10	# n = 10 (numero do tamanho do vetor)
	#li $s4, 0	# x = 0
	la $t1, arrV	#vetor com 10 indices iniciados com 0
	li $s5, 0	# i = 0
	
	li $v0, 4	# impressão da string
	la $a0, msg1	# endereço da string
	syscall
	
inicioleitura:
	slt $t0, $s2, $s3	# i < n
	beq $t0, $zero, comparações
	
	# bloco do loop
	sll $t2, $s2, 2
	add $t2, $t1, $t2
	
	#lw $t3, 0($t2)	#t3 = arrV[i]
	
	li $v0, 4	# impressão da string
	la $a0, msg2	# endereço da string
	syscall
	
	li $v0, 5	# entrada de dados
	syscall
	
	sw $v0, 0($t2)

	# incremento e salto para o inicio
	addi $s2, $s2, 1	# i = i + 1
	j inicioleitura		#volta para o começo do loop

comparações:
	slt $t0, $s5, $s3
	beq $t0, $zero, quantidades 
	
	#bloco do loop
	sll $t2, $s5, 2
	add $t2, $t1, $t2
	
	lw $t3, 0($t2)	#t3 = arrV[i]
if1:
	slt $t0, $t3, $zero	#se o numero for menor que 0
	beq $t0, $zero, else
then1:
	lw $t3, 0($t2)
	li $v0, 1	#imprimrir o numero e informando que ele é negativo
	la $a0, ($t3)
	syscall
	
	li $v0, 4
	la $a0, neg
	syscall
	
	addi $s1, $s1, 1	#total de negativos + 1
	j fimcompa
else:
	lw $t3, 0($t2)
	li $v0, 1	#imprimrir o numero e informando que ele é positivo
	la $a0, ($t3)
	syscall
	
	li $v0, 4
	la $a0, pos
	syscall
	
	addi $s0, $s0, 1	#total de positivos + 1
	
	
	#incremento e salto para o inicio
fimcompa:
	addi $s5, $s5, 1	# i = i + 1
	j comparações		#volta para o começo do loop
quantidades:
#serão analisadas as quantidades de positivos e negativos
ifpos:
	bne $s0, $zero, elsepos
	
	li $v0, 4
	la $a0, nenpos
	syscall
	
	j ifneg
elsepos:
	li $v0, 1	#imprimrir a quantidade de numeros positivos
	la $a0, ($s0)
	syscall
	
	li $v0, 4
	la $a0, quantpos
	syscall
	
ifneg:
	bne $s1, $zero, elseneg
	
	li $v0, 4
	la $a0, nenneg
	syscall
	
	j fim
elseneg:
	li $v0, 1	#imprimrir a quantidade de numeros negativos
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, quantneg
	syscall
fim:
#include <stdio.h>


#int main(){
#    int numero[10];
#    int i;
#    int totalpos = 0;
#    int totalneg = 0;
#
#    printf("Você vai inserir numeros inteiros agora");
#
#    for (i=0; i<10; i++){
#        printf("\nInsira o numero %d: ", i+1);
#        scanf("%d", &numero[i]);
#    }
#
#    for (i=0; i<10; i++){
#        if (numero[i] >= 0){
#            printf("\no numero %d eh positivo", numero[i]);
#            totalpos = totalpos + 1;
#        } 
#        else {
#            printf("\no numero %d eh negativo", numero[i]);
#            totalneg = totalneg + 1;
#        }
#    }
#    
#    if (totalpos == 0){
#        printf("\nNao foi inserido nenhum numero positivo");
#    }
#    else {
#        printf("\nforam inseridos %d numeros positivos", totalpos);
#    }
#    if (totalneg == 0){
#        printf("\nNao foi inserido nenhum numero negativo");
#    }
#    else {
#        printf("\nforam inseridos %d numeros negativos", totalneg);
#    }
#}
