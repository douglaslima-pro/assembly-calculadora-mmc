# CALCULADORA DE MMC - MIPS32
Escreva código-fonte em **assembler/MIPS** para calcular o MMC entre 3 (três) números inteiros informados pelo teclado.

Na avaliação do código-fonte, será avaliado:
1. o uso de funções;
2. a organização do código-fonte;
3. o correto funcionamento do algoritmo desenvolvido.

#### Observação:
No final da execução, o valor do MMC deve estar armazenado no registrador `$t8`.

## Registradores
### Números
- **$s0**: armazena o número 1
- **$s1**: armazena o número 2
- **$s2**: armazena o número 3
- **$s3**: armazena o número primo **divisor**
### Restos da divisão
- **$t0**: armazena o resto de `div $s0, $s3`
- **$t1**: armazena o resto de `div $s1, $s3`
- **$t2**: armazena o resto de `div $s2, $s3`
### Resultado
- **$t8**: armazena o resultado do mmc

## Solução na linguagem C
```c
#include <stdio.h>

int main(){
    int n1;
    int n2;
    int n3;
    int i = 2;
    int mmc = 1;
    
    printf("Informe o primeiro numero: ");
    scanf("%d",&n1);
    printf("Informe o segundo numero: ");
    scanf("%d",&n2);
    printf("Informe o terceiro numero: ");
    scanf("%d",&n3);

    while(n1>1 || n2>1 || n3>1){
        int md1 = n1 % i;
        int md2 = n2 % i;
        int md3 = n3 % i;
        
        if(md1 == 0){n1 /= i;}
        if(md2 == 0){n2 /= i;}
        if(md3 == 0){n3 /= i;}
 
        if(md1 && md2 && md3){
            i += 1;
        }else{
            mmc *= i;
        }
    }
    printf("MMC = %d", mmc);
    return 0;
} 
```
> [!NOTE]
> Fonte: [https://www.clubedohardware.com.br/forums/topic/1532426-faça-um-programa-que-calcule-o-mmc-de-3-números-em-c-e-sem-usar-função/](https://www.clubedohardware.com.br/forums/topic/1532426-faça-um-programa-que-calcule-o-mmc-de-3-números-em-c-e-sem-usar-função/)

## Outras informações
- **Curso**: Análise e Desenvolvimento de Sistemas
- **Disciplina**: Arquitetura de Computadores
- **Professor(a)**: Marcelo Eustaquio Soares de Lima Junior