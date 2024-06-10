# Estudante: Douglas Souza de Lima
# Matricula: UC23200709

.data
mensagem1: .asciiz "Informe o primeiro numero: "
mensagem2: .asciiz "Informe o segundo numero: "
mensagem3: .asciiz "Informe o terceiro numero: "
resultado: .asciiz "MMC = "

.text
.globl main

main:
    	# "Informe o primeiro numero:"
	li $v0, 4
	la $a0, mensagem1
	syscall
	# le o primeiro numero (N1)
	li $v0, 5
	syscall
	move $s0, $v0
	# "Informe o segundo numero: "
	li $v0, 4
	la $a0, mensagem2
	syscall
	# le o segundo numero (N2)
	li $v0, 5
	syscall
    	move $s1, $v0
	# "Informe o terceiro numero: "
	li $v0, 4
	la $a0, mensagem3
	syscall
	# le o terceiro numero (N3)
	li $v0, 5
	syscall
    	move $s2, $v0
   	# armazena o valor do divisor (i)
	li $s3, 2
	# armazena o resultado (mmc)
	li $t8, 1

    WHILE:
        # while (N1 > 1 || N2 > 1 || N3 > 1)
        bgt $s0, 1, BEGIN
        bgt $s1, 1, BEGIN
        bgt $s2, 1, BEGIN
        # caso contrário, imprime o resultado
        j imprimirResultado

        BEGIN:
            # armazena o resto da divisão de N1 por i
            div $s0, $s3
            mfhi $t0
            # armazena o resto da divisão de N2 por i
            div $s1, $s3
            mfhi $t1
            # armazena o resto da divisão de N3 por i
            div $s2, $s3
            mfhi $t2

            # se o primeiro numero for multiplo do divisor, entao divide
            seNumero1ForMultiplo:
                # if ($t0 == 0)
                beq $t0, 0, dividirNumero1
	       	# caso contrario, pula para a proxima condicao
                b seNumero2ForMultiplo
                dividirNumero1:
                	# $s0 = $s0 / $s3
               		div $s0, $s3
                        mflo $s0
            # se o segundo numero for multiplo do divisor, entao divide
            seNumero2ForMultiplo:
                # if ($t1 == 0)
                beq $t1, 0, dividirNumero2
	        # caso contrario, pula para a proxima condicao
                b seNumero3ForMultiplo
               	dividirNumero2:
                        # $s1 = $s1 / $s3
                        div $s1, $s3
                        mflo $s1
            # se o terceiro numero for multiplo do divisor, entao divide
            seNumero3ForMultiplo:
                # if ($t2 == 0)
                beq $t2, 0, dividirNumero3
                # caso contrario, pula para a proxima condicao
                b seQualquerNumeroForMultiplo
               	dividirNumero3:
                        # $s2 = $s2 / $s3
                        div $s2, $s3
                        mflo $s2
            
            # se qualquer um dos 3 numeros for multiplo do divisor, então calcula o mmc
            # e pula para a proxima iteração com o valor atual do divisor
            seQualquerNumeroForMultiplo:
                beq $t0, 0, calcularMMC
                beq $t1, 0, calcularMMC
                beq $t2, 0, calcularMMC
                # caso contrario, incrementa o divisor
                b incrementarDivisor

            # incrementa o divisor
            incrementarDivisor:
                # i = i + 1
                add $s3, $s3, 1
                j WHILE
            
            # calcula o mmc multiplicando os divisores da formula do mmc
            calcularMMC:
                # mmc = mmc * i
                mul $t8, $t8, $s3
                j WHILE

    imprimirResultado:
        # "MMC = "
        li $v0, 4
        la $a0, resultado
        syscall
        # imprime o valor do mmc
        li $v0, 1
        move $a0, $t8
        syscall
        j FIM
        
FIM:
	# finaliza a execucao do programa
	li $v0, 10
	syscall
