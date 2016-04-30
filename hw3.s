    .global main
    .func main
   
   
   
main:
    BL prompt
    BL scanint 
    MOV R5, R0
    MOV R0, #0
             
generate:
    CMP R0, #20 
    BEQ next
    LDR R1, =a
    LSL R2, R0, #2
    ADD R2, R1, R2
    LDR R6, =temp
    LSL R7, R0, #2
    ADD R7, R6, R7


    ADD R3, R5, R0
    STR R3, [R2] 
    STR R3, [R7]
    ADD R4, R3, #1
    NEG R3, R4

    ADD R4, R0, #1
    LSL R2, R4, #2
    ADD R2, R1, R2
    STR R3, [R2]
    STR R3, [R7]
    
    ADD R0, R0, #2
    B generate
    
next:
    MOV R6, #0
    MOV R7, #0
    LDR R1, =temp
    LDR R3, =b

sort_ascending:
    CMP R6, #20
    BEQ next3

    LSL R2, R6, #2 @ for array temp
    ADD R2, R1, R2
    LSL R4, R6, #2 @ for array b
    ADD R4, R3, R4
    
    ADD R7, R7, #1
    BL moveToSort
    MOV R7, #0
    
    ADD R6, R6, #1
    B sort_ascending

moveToSort:
    MOV R7, #0
    
sort_ascendingInner:
    CMP R7, #20
    MOVEQ PC, LR
    LSL R8, R7, #2 @ temp
    ADD R8, R1, R8
    
    LDR R11, [R2] @ this is index
    LDR R10, [R8] @ this is index + 1

    CMP R11, R10
    MOVLT R12, R10
    MOVLT R10, R11
    MOVLT R11, R12
    
    STR R11, [R2]
    STR R10, [R8]

    ADD R7, R7, #1
    B sort_ascendingInner


    
next3:
    MOV R0, #0

read_arrays:

    CMP R0, #20 @R0 is index
    BEQ exit

    LDR R1, =a
    LSL R2, R0, #2 @a
    ADD R2, R1, R2

    LDR R3, =b
    LSL R4, R0, #2 @b
    ADD R4, R3, R4
    
    LDR R1, [R2] @ a value
    LDR R3, [R4] @ b value
    
    PUSH {R0}
    PUSH {R1}
    PUSH {R2}
    PUSH {R3}
    
    MOV R2, R1
    MOV R1, R0
    
    BL print
    
    POP {R3}
    POP {R2}
    POP {R1}
    POP {R0}
    
    ADD R0, R0, #1
    
    B read_arrays
    
    
exit:   
    MOV R7, #1         
    SWI 0 
print:
    PUSH {LR}
    LDR R0, =print_str
    BL printf
    POP {PC}

prompt:
    MOV R7, #4
    MOV R0, #1
    MOV R2, #18
    LDR R1, =prompt_str
    SWI 0
    MOV PC, LR

scanint:
    MOV R4, LR              
    SUB SP, SP, #4          
    LDR R0, =num_str     
    MOV R1, SP              
    BL scanf                
    LDR R0, [SP]            
    ADD SP, SP, #4          
    MOV PC, R4  



.data


.balign 4
a:              .skip       80
temp:           .skip       80
b:              .skip       80
num_str:        .asciz      "%d"
print_str:      .asciz      "array_a[%d] = %d, array_b = %d\n"
prompt_str:     .ascii      "Enter an integer.\n"
