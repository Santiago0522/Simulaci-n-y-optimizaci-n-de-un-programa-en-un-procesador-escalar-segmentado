.data
prompt:      .asciiz "Ingrese cuántos números de la serie Fibonacci desea generar: "
fibResult:   .asciiz "Los números de la serie Fibonacci son: "
sumResult:   .asciiz "La suma de la serie es: "

.text
.globl main

main:
    # Mostrar el mensaje y leer cuántos números generar
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cuántos números

    # Inicializar la serie Fibonacci
    li $t1, 0  # Primer número
    li $t2, 1  # Segundo número
    li $t3, 0  # Suma de la serie

    # Mostrar mensaje con la serie
    li $v0, 4
    la $a0, fibResult
    syscall

    # Loop para generar y mostrar la serie
    li $t4, 0  # Contador
fibLoop:
    beq $t4, $t0, endFib  # Si ya hemos generado todos los números, salir del loop

    # Mostrar el número actual
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir un espacio (la corrección está aquí)
    li $v0, 11
    li $a0, ' '
    syscall

    # Sumar el número a la suma total
    add $t3, $t3, $t1

    # Calcular el siguiente número de la serie
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