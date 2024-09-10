    .data
prompt:    .asciiz "Ingrese el número de elementos a comparar (mínimo 3, máximo 5): "
promptNum: .asciiz "Ingrese el número: "
maxResult: .asciiz "El mayor número es: "

    .text
    .globl main

main:
    # Mostrar el mensaje y leer la cantidad de números a comparar
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar el número de elementos
    
    # Inicializar el mayor número
    li $t1, -2147483648  # El menor valor posible de un entero
    
    # Loop para pedir y comparar números
    li $t2, 0  # Contador
loop:
    beq $t2, $t0, endLoop  # Si ya hemos comparado todos los números, salimos del loop
    
    # Solicitar un número
    li $v0, 4
    la $a0, promptNum
    syscall
    
    li $v0, 5
    syscall
    move $t3, $v0  # Guardar el número ingresado
    
    # Comparar con el mayor actual
    bge $t3, $t1, updateMax
    j next
    
updateMax:
    move $t1, $t3  # Actualizar el mayor número
    
next:
    addi $t2, $t2, 1  # Incrementar contador
    j loop
    
endLoop:
    # Mostrar el mayor número
    li $v0, 4
    la $a0, maxResult
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Salir del programa
    li $v0, 10
    syscall