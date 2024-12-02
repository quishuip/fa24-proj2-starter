.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:
    bge x0 a1 c38
    bge x0 a2 c38
    bge x0 a4 c38
    bge x0 a5 c38
    bne a2 a4 c38
    j matms
c38:
    li a0 38
    j exit
    # Error checks


    # Prologue
matms:
    li t0 0
    li t1 0
    addi sp sp -4
    sw ra 0(sp) 

outer_loop_start:
    



inner_loop_start:
    
    addi sp sp -4
    sw a0 0(sp)
    addi sp sp -4
    sw a1 0(sp)
    addi sp sp -4
    sw a2 0(sp)
    addi sp sp -4
    sw a3 0(sp)
    addi sp sp -4
    sw a4 0(sp)
    addi sp sp -4
    sw a5 0(sp)
    addi sp sp -4
    sw t0 0(sp)
    addi sp sp -4
    sw t1 0(sp)
    addi sp sp -4
    sw a6 0(sp)
    
    mul t2 t0 a2
    slli t2 t2 2
    add a0 a0 t2
    slli t1 t1 2
    add a1 a3 t1
    li a3 1
    add a4 x0 a5
    
    jal ra dot
    
    lw a6 0(sp)
    addi sp sp 4
    lw t1 0(sp)
    addi sp sp 4
    lw t0 0(sp)
    addi sp sp 4
    lw a5 0(sp)
    addi sp sp 4
    lw a4 0(sp)
    addi sp sp 4
    lw a3 0(sp)
    addi sp sp 4
    lw a2 0(sp)
    addi sp sp 4
    lw a1 0(sp)
    addi sp sp 4
    
    mul t2 t0 a5 
    add t2 t1 t2
    slli t2 t2 2
    add t2 t2 a6
    sw a0 0(t2)
    lw a0 0(sp)
    addi sp sp 4

    addi t1 t1 1
    bge t1 a5 inner_loop_end
    j inner_loop_start
inner_loop_end:
    addi t0 t0 1
    bge t0 a1 outer_loop_end
    addi t1 x0 0
    j outer_loop_start

outer_loop_end:
    lw ra 0(sp)
    addi sp sp 4
    # Epilogue


    jr ra
