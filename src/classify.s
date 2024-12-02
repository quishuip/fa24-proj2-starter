.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
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
    addi sp sp -4
    sw s4 0(sp)
    
    addi t0 x0 5
    beq a0 t0 ar_c
    li a0 31
    j exit
ar_c:
    addi s1 a1 0    
    addi s2 a2 0
    
    lw a0 4(s1)
    addi a1 sp -4
    addi a2 sp -8
    addi sp sp -8
    jal ra read_matrix    
    addi s0 a0 0
    # Read pretrained m0
    
    lw a0 8(s1)
    addi a1 sp -4
    addi a2 sp -8
    addi sp sp -8    
    jal ra read_matrix    
    addi s3 a0 0
    # Read pretrained m1

    lw a0 12(s1)
    addi a1 sp -4
    addi a2 sp -8
    addi sp sp -8    
    jal ra read_matrix    
    addi s4 a0 0
    # Read input matrix

    lw t0 0(sp)
    lw t1 20(sp)
    mul a0 t0 t1
    slli a0 a0 2
    jal ra malloc
    bne a0 x0 m_s1
    li a0 26
    j exit
m_s1:
    addi sp sp -4
    sw a0 0(sp)
    addi a6 a0 0
    addi a0 s0 0
    lw a1 24(sp)
    lw a2 20(sp)
    addi a3 s4 0
    lw a4 8(sp)
    lw a5 4(sp)
    jal ra matmul
    # Compute h = matmul(m0, input)

    lw a0 0(sp)
    lw t0 4(sp)
    lw t1 24(sp)
    mul a1 t0 t1
    jal ra relu
    # Compute h = relu(h)
    
    lw t0 4(sp)
    lw t1 16(sp)
    mul a0 t0 t1
    slli a0 a0 2
    jal ra malloc
    bne a0 x0 m_s2
    li a0 26
    j exit
m_s2:
    addi sp sp -4
    sw a0 0(sp)
    addi a0 s0 0
    jal ra free    
    lw s0 0(sp)
    addi sp sp 4
    lw a3 0(sp)
    #addi sp sp 4
    addi a0 s3 0
    lw a1 16(sp)
    lw a2 12(sp)
    lw a4 24(sp)
    lw a5 4(sp)
    addi a6 s0 0
    jal ra matmul
    # Compute o = matmul(m1, h)
    
    lw a0 0(sp)
    jal ra free
    addi sp sp 4 ##
    lw a0 16(s1)
    addi a1 s0 0
    lw a2 12(sp)
    lw a3 0(sp)
    jal ra write_matrix
    # Write output matrix o

    lw t0 12(sp)
    lw t1 0(sp)
    mul a1 t0 t1
    addi a0 s0 0
    jal ra argmax 
    addi sp sp -4
    sw a0 0(sp)
    # Compute and return argmax(o)
        
    bne s2 x0 n_p ###
    jal ra print_int 
    li a0 '\n'
    jal ra print_char 
    # If enabled, print argmax(o) and newline
n_p:
    lw s2 0(sp)
    addi sp sp 4
    addi a0 s0 0
    jal ra free
    addi a0 s3 0
    jal ra free
    addi a0 s4 0
    jal ra free
    addi a0 s2 0
    addi sp sp 24 ###
    lw s4 0(sp)
    lw s3 4(sp)
    lw s2 8(sp) ###
    lw s1 12(sp)
    lw s0 16(sp)
    lw ra 20(sp)
    addi sp sp 24
    jr ra
