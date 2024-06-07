# Estudante: Douglas Souza de Lima
# Matrícula: UC23200709

.data
mensagem1: .asciiz "Informe o primeiro numero: "
mensagem2: .asciiz "Informe o segundo numero: "
mensagem3: .asciiz "Informe o terceiro numero: "
resultado: .asciiz "MMC = "

.text
.globl main

# --- LEITURA DOS NUMEROS ----

main:
	# "Informe o primeiro número:"
	li $v0, 4
	la $a0, mensagem1
	syscall
	# le o primeiro numero (N1)
	li $v0, 5
	syscall
	move $s0, $v0
	# "Informe o segundo número: "
	li $v0, 4
	la $a0, mensagem2
	syscall
	# le o segundo numero (N2)
	li $v0, 5
	syscall
	move $s1, $v0
	# "Informe o terceiro número: "
	li $v0, 4
	la $a0, mensagem3
	syscall
	# le o terceiro numero (N3)
	li $v0, 5
	syscall
	move $s2, $v0
	# armazena o valor do numero primo (i)
	li $s3, 2
	# armazena o resultado (mmc)
	li $t8, 1
	# while (n1 > 1 || n2 > 1 || n3 > 1)
	bgt $s0, 1, LOOP
	bgt $s1, 1, LOOP
	bgt $s2, 1, LOOP
	# pula para a label
	j imprimirResultado
	
# --- LACO DE REPETICAO ---

LOOP:
	# $t0 = N1 % i
	div $s0, $s3
	mfhi $t0
	# $t1 = N2 % i
	div $s1, $s3
	mfhi $t1
	# $t2 = N3 % i
	div $s2, $s3
	mfhi $t2
	# pula para a label
	b seNumero1ForMultiplo

# se o primeiro numero for multiplo, entao divide
seNumero1ForMultiplo:
	# if (md1 == 0)
	beq $t0, 0, dividirNumero1
	# ou pula para a proxima condicao
	b seNumero2ForMultiplo
# se o segundo numero for multiplo, entao divide
seNumero2ForMultiplo:
	# if (md2 == 0)
	beq $t1, 0, dividirNumero2
	# ou pula para a proxima condicao
	b seNumero3ForMultiplo
# se o terceiro numero for multiplo, entao divide
seNumero3ForMultiplo:
	# if (md3 == 0)
	beq $t2, 0, dividirNumero3
	# ou pula para a proxima condicao
	b seNumero1NaoForMultiplo

# divide o primeiro numero
dividirNumero1:
	# N1 = N1 / i
	div $s0, $s3
	mflo $s0
	b seNumero2ForMultiplo
# divide o segundo numero
dividirNumero2:
	# N2 = N2 / i
	div $s1, $s3
	mflo $s1
	b seNumero3ForMultiplo
# divide o terceiro numero
dividirNumero3:
	# N3 = N3 / i
	div $s2, $s3
	mflo $s2
	b seNumero1NaoForMultiplo

# se nenhum dos tres numeros forem multiplos, incrementa o divisor
# caso contrario, calcula o mmc
# if (md1 != 0 && md2 != 0 && md3 != 0)
seNumero1NaoForMultiplo:
	# md1 != 0
	bne $t0, 0, seNumero2NaoForMultiplo
	# ou pula para o calculo do mmc
	b calcularMMC
seNumero2NaoForMultiplo:
	# md2 != 0
	bne $t1, 0, seNumero3NaoForMultiplo
	# ou pula para o calculo do mmc
	b calcularMMC
seNumero3NaoForMultiplo:
	# md3 != 0
	bne $t2, 0, incrementarNumeroPrimo
	# ou pula para o calculo do mmc
	b calcularMMC
	
# incrementa o divisor
# e antes de repetir o loop, verifica se os numeros ainda sao maiores que 1
incrementarNumeroPrimo:
	# i = i + 1
	add $s3, $s3, 1
	# pula para a condicao
	b seNumero1ForIgualUm

# calcula o mmc multiplicando os divisores da formula do mmc
# e antes de repetir o loop, verifica se os numeros ainda sao maiores que 1
calcularMMC:
	# mmc = mmc * i
	mul $t8, $t8, $s3
	# pula para a condicao
	b seNumero1ForIgualUm

# se os tres numeros forem iguais a 1, encerra o laco de repeticao
# if (n1 == 1 && n2 == 1 && n3 == 1)
seNumero1ForIgualUm:
	# n1 == 1
	beq $s0, 1, seNumero2ForIgualUm
	j LOOP
seNumero2ForIgualUm:
	# n2 == 1
	beq $s1, 1, seNumero3ForIgualUm
	j LOOP
seNumero3ForIgualUm:
	# n3 == 1
	beq $s2, 1, imprimirResultado
	j LOOP
	

# --- FINALIZA O PROGRAMA ---

imprimirResultado:
	# "MMC = "
	li $v0, 4
	la $a0, resultado
	syscall
	# imprime o valor do mmc
	li $v0, 1
	move $a0, $t8
	syscall
	j finalizar

finalizar:
	# termina a execucao
	li $v0, 10
	syscall
