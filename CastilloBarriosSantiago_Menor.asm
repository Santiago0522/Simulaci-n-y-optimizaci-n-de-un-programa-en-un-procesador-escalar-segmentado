.data
prompt:      .asciiz "Ingrese el n�mero de elementos a comparar (m�nimo 3, m�ximo 5): "
promptNum:   .asciiz "Ingrese el n�mero (entre 0 y 1000): "
minResult:   .asciiz "El menor n�mero es: "
error:       .asciiz "N�mero inv�lido. Ingrese un n�mero entre 0 y 1000: "

.text
.globl main

main:
    # Solicitar el n�mero de elementos
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # N�mero de elementos a comparar

    # Inicializar el menor n�mero con el valor m�ximo posible
    li $t1, 2147483647

    # Loop para ingresar y comparar n�meros
    li $t2, 0  # Contador
loop:
    beq $t2, $t0, endLoop  # Si ya se compararon todos los n�meros, salir

    # Solicitar un n�mero
    li $v0, 4
    la $a0, promptNum
    syscall
    li $v0, 5
    syscall
    move $t3, $v0

    # Verificar si el n�mero est� entre 0 y 1000
    blt $t3, 0, invalidNumber
    bgt $t3, 1000, invalidNumber

    # Comparar con el menor actual y actualizar si es necesario
    # Si el n�mero ingresado es MENOR que el m�nimo actual, actualizar el m�nimo
    ble $t3, $t1, updateMin
    j next

updateMin:
    move $t1, $t3  # Actualizar el m�nimo
    j next

next:
    addi $t2, $t2, 1  # Incrementar contador
    j loop

invalidNumber:
    # Mostrar mensaje de error y volver a pedir el n�mero
    li $v0, 4
    la $a0, error
    syscall
    j loop

endLoop:
    # Mostrar el menor n�mero
    li $v0, 4
    la $a0, minResult
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    # Salir del programa
    li $v0, 10
    syscall