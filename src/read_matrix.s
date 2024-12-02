.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:
    addi sp sp -4
    sw ra 0(sp)
    addi sp sp -4
    sw s0 0(sp)    
    addi sp sp -4
    sw s1 0(sp)
    addi sp sp -4
    sw s2 0(sp)
    addi sp sp -4
    sw s3 0(sp)
    addi s1 a1 0
    addi s2 a2 0
    # Prologue
    addi a1 x0 0
    
    jal ra fopen
    li t0 -1
    bne a0 t0 fopen_suc
    li a0 27
    j exit
fopen_suc:
    addi s0 a0 0    
    addi a1 s1 0
    li a2 4
    jal ra fread
    
    addi a0 s0 0
    addi a1 s2 0
    li a2 4
    jal ra fread
    
    lw t0 0(s1)
    lw t1 0(s2)
    mul s3 t1 t0
    slli s3 s3 2
    addi a0 s3 0
    
    jal ra malloc
    bne a0 x0 malloc_suc
    li a0 26
    j exit
malloc_suc:    
    addi a2 s3 0
    addi a1 a0 0
    addi s1 a1 0
    addi a0 s0 0
    jal ra fread
    
    beq a0 s3 fr_suc
    li a0 29
    j exit
fr_suc:
    addi a0 s0 0
    jal ra fclose
    beq a0 x0 fc_suc
    li a0 28
    j exit
fc_suc:
    addi a0 s1 0
    # Epilogue
    lw s3 0(sp)
    lw s2 4(sp)
    lw s1 8(sp)
    lw s0 12(sp)
    lw ra 16(sp)
    addi sp sp 20
    jr ra

