.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
    addi t0 x0 1
    addi t2 x0 4
    addi t1 x0 0 
    addi t3 x0 0
    addi t4 x0 0 
    blt a2 t0 c36
    blt a3 t0 c37
    blt a4 t0 c37
    j loop_start
c36:
    addi a0 x0 36
    j exit
c37:
    addi a0 x0 37
    j exit

loop_start:
    lw t3 0(a0)
    lw t4 0(a1)
    mul t3 t3 t4
    add t1 t1 t3
    bge t0 a2 loop_end
    addi t0 t0 1
    mul t3 t2 a3
    add a0 a0 t3
    mul t4 t2 a4
    add a1 a1 t4
    j loop_start
loop_end:


    # Epilogue
    add a0 t1 x0
    jr ra
