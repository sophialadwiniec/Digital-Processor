main: 
   mov sp, #128
   add sp, sp, sp
   add sp, sp, sp
   sub sp, sp, #24
   mov r0, #16 
   str r0, [sp, #0]
   mov r0, #4
   str r0, [sp, #4]
   mov r0, #32
   str r0, [sp, #8]
   mov r0, #2
   str r0, [sp, #12]
   mov r0, #8
   str r0, [sp, #16] 
   mov r0, sp 
   mov r1, #5
   bl sort_s 
   add r0, r0, #0 

find_max_index_s:
    sub sp, sp, #8
    str r4, [sp, #0]
    mov r2, #1 //i = 1
    mov r4, #0 // index = 0
    ldr r3, [r0] //max = array[0]

find_max_loop:
    cmp r1, r2
    ble find_max_end

    LSL r2, #2
    ldr r12, [r0, r2] 
    LSR r2, #2

    cmp r3, r12
    bge find_max_add
    mov r3, r12
    mov r4, r2

find_max_add:
    add r2, #1
    b find_max_loop

find_max_end:
    mov r0, r4
    ldr r4, [sp, #0]
    add sp, sp, #8
    bx lr 

/*
*r0 - int *array
*r1 - len 
*r2 - i 
*r3 - max_index 
*
*r12 - tmp 
*/

sort_s:
    sub sp, sp, #24
    str lr, [sp]
    str r4, [sp, #16]
    str r5, [sp, #20] 
    mov r2, #0 ///i = 0 

sort_loop:
    cmp r1, r2
    ble sort_s_end
    
    str r0, [sp, #4]
    str r1, [sp, #8]
    str r2, [sp, #12]

    sub r1, r1, r2
    LSL r2, #2
    add r0, r0, r2
    LSR r2, #2

    bl find_max_index_s

    mov r3, r0

    ldr r0, [sp, #4]
    ldr r1, [sp, #8]
    ldr r2, [sp, #12]

    add r3, r2, r3 

    cmp r2, r3
    beq sort_loop_continue

    LSL r2, #2
    ldr r12, [r0, r2]
    LSR r2, #2

    LSL r3, #2
    ldr r4, [r0, r3]
    LSR r3, #2

    LSL r2, #2
    add r5, r2, r0
    str r4, [r5]
    LSR r2, #2

    LSL r3, #2
    add r5, r3, r0
    str r12, [r5] 
    LSR r3, #2

    add r2, #1
    b sort_loop

sort_loop_continue:
    add r2, #1
    b sort_loop

sort_s_end:
    mov r0, r1
    ldr r5, [sp, #20]
    ldr r4, [sp,#16]
    ldr lr, [sp]
    add sp, sp, #24
    bx lr
    

