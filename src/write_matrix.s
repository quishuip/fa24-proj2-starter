.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:
    addi sp sp -4
    sw ra 0(sp)
    addi sp sp -4
    sw s0 0(sp)    
    addi sp sp -4
    sw s1 0(sp)
    addi sp sp -4
    sw s2 0(sp)
    
    addi sp sp -4
    sw a3 0(sp)
    addi sp sp -4
    sw a2 0(sp)
    
    # Prologue
    addi s1 a1 0
    li a1 1
    jal ra fopen
    li t0 -1
    bne a0 t0 fopen_suc
    li a0 27
    j exit
fopen_suc:
    addi s0 a0 0
    addi a1 sp 0
    li a2 2
    li a3 4
    jal ra fwrite
    
    lw t1 0(sp)
    lw t2 4(sp)
    addi sp sp 8 
    
    addi a0 s0 0
    addi a1 s1 0
    mul s2 t1 t2
    addi a2 s2 0
    li a3 4
    jal ra fwrite
    
    beq a0 s2 fw_suc
    li a0 30
    j exit
fw_suc:
    addi a0 s0 0
    jal ra fclose
    beq a0 x0 fcl_suc
    li a0 28
    j exit
fcl_suc:
    # Epilogue
    lw s2 0(sp)
    lw s1 4(sp)
    lw s0 8(sp)
    lw ra 12(sp)
    addi sp sp 16

    jr ra
