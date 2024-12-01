.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
addi t2 x0 1
bge a1 t2 loop_start
addi a0 x0 36
j exit

loop_start:
lw t1 0(a0)
bge t1 x0 loop_continue
sw x0 0(a0)

loop_continue:
addi a0 a0 4
bge t2 a1 loop_end
addi t2 t2 1
j loop_start
loop_end:

    # Epilogue


    jr ra
