.data
prompt:      .asciiz "Ingrese el número de elementos a comparar (mínimo 3, máximo 5): "
promptNum:   .asciiz "Ingrese el número (entre 0 y 1000): "
minResult:   .asciiz "El menor número es: "
error:       .asciiz "Número inválido. Ingrese un número entre 0 y 1000: "

.text
.globl main

main:
    # Solicitar el número de elementos
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Número de elementos a comparar

    # Inicializar el menor número con el valor máximo posible
    li $t1, 2147483647

    # Loop para ingresar y comparar números
    li $t2, 0  # Contador
loop:
    beq $t2, $t0, endLoop  # Si ya se compararon todos los números, salir

    # Solicitar un número
    li $v0, 4
    la $a0, promptNum
    syscall
    li $v0, 5
    syscall
    move $t3, $v0

    # Verificar si el número está entre 0 y 1000
    blt $t3, 0, invalidNumber
    bgt $t3, 1000, invalidNumber

    # Comparar con el menor actual y actualizar si es necesario
    # Si el número ingresado es MENOR que el mínimo actual, actualizar el mínimo
    ble $t3, $t1, updateMin
    j next

updateMin:
    move $t1, $t3  # Actualizar el mínimo
    j next

next:
    addi $t2, $t2, 1  # Incrementar contador
    j loop

invalidNumber:
    # Mostrar mensaje de error y volver a pedir el número
    li $v0, 4
    la $a0, error
    syscall
    j loop

endLoop:
    # Mostrar el menor número
    li $v0, 4
    la $a0, minResult
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    # Salir del programa
    li $v0, 10
    syscall