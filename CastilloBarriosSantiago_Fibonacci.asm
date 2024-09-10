.data
prompt:      .asciiz "Ingrese cu�ntos n�meros de la serie Fibonacci desea generar: "
fibResult:   .asciiz "Los n�meros de la serie Fibonacci son: "
sumResult:   .asciiz "La suma de la serie es: "

.text
.globl main

main:
    # Mostrar el mensaje y leer cu�ntos n�meros generar
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cu�ntos n�meros

    # Inicializar la serie Fibonacci
    li $t1, 0  # Primer n�mero
    li $t2, 1  # Segundo n�mero
    li $t3, 0  # Suma de la serie

    # Mostrar mensaje con la serie
    li $v0, 4
    la $a0, fibResult
    syscall

    # Loop para generar y mostrar la serie
    li $t4, 0  # Contador
fibLoop:
    beq $t4, $t0, endFib  # Si ya hemos generado todos los n�meros, salir del loop

    # Mostrar el n�mero actual
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir un espacio (la correcci�n est� aqu�)
    li $v0, 11
    li $a0, ' '
    syscall

    # Sumar el n�mero a la suma total
    add $t3, $t3, $t1

    # Calcular el siguiente n�mero de la serie
    add $t5, $t1, $t2  # t5 = t1 + t2
    move $t1, $t2
    move $t2, $t5

    addi $t4, $t4, 1  # Incrementar contador
    j fibLoop

endFib:
    # Mostrar la suma total
    li $v0, 4
    la $a0, sumResult
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    # Salir del programa
    li $v0, 10
    syscall