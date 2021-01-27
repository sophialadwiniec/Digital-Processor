main: 
   mov sp, #128
   add sp, sp, sp
   add sp, sp, sp
   sub sp, sp, #20
   mov r0, #0
   str r0, [sp, #0]
   mov r0, #4
   str r0, [sp, #4]
   mov r0, #8
   str r0, [sp, #8]
   mov r0, #12
   str r0, [sp, #12]
   mov r0, #16
   str r0, [sp, #16]
   mov r0, sp
   mov r1, #0 @starting point 
   mov r2, #5 @length of array 
   mov r3, #12 @number we want 
   bl search_s
   add r0, r0, #0

search_s:
    sub sp, sp, #8
    str lr, [sp, #20]
    str r4, [sp, #24] 
    cmp r1, r2
    
    ble search_rec_s
    mov r0, #-1
    b search_s_end


search_rec_s:  
    sub r12, r2, r1
    LSR r12, #1
    add r12, r12, r1
    LSL r12, #2
    ldr r4, [r0, r12] 
    LSR r12, #2
 
    cmp r3,r4

    bgt search_greater_than
    blt search_less_than

    mov r0, r12
    b search_s_end

search_less_than:
    mov r2, r12
    sub r2, r2, #1
    bx lr
    bl search_s
    b search_s_end

search_greater_than: 
    mov r1, r12
    add r1, #1 
    bl search_s
    b search_s_end

search_s_end:
    ldr r4, [sp, #24] 
    ldr lr, [sp, #20]
    add sp, sp, #8
    bx lr 

