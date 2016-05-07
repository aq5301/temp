    .global main
    .func main
   
   
   .data
   
main:
BL prompt
MOV R5, #0

readarray:
CMP R5, 10
BEQ next1
LDR R1, =a
LSL R2, R5, #2
ADD R2, R1, R2

BL scanf
STR R0, [R2]

ADD R5, R5, #1

B readarray

next1:
MOV R5, #0
LDR R1, =a
LSL R2, R5, #2
ADD R2, R1, R2
LDR R6, [R2] @R6 holds minimum


minimum:
CMP R5, #10
BEQ next2

ADD R5, R5, #1
LDR R7, [R2] @ next
CMP R6, R7
MOVGE R6, R7

B minimum
  
next2:
MOV R5, #0
LDR R1, =a
LSL R2, R5, #2
ADD R2, R1, R2
LDR R8, [R2] @R8 holds max


maximum:
CMP R5, #10
BEQ next3

ADD R5, R5, #1
LDR R7, [R2] @ next
CMP R8, R7
MOVGE R8, R7

B maximum
 
next3:
MOV R5, #0
LDR R1, =a
LSL R2, R5, #2
ADD R2, R1, R2

MOV R9, #0

sum: 
CMP R5, #10
BEQ next4

LDR R3, [R2] 
ADD R9, R9, R3 @R9 holds sum

ADD R5, R5, #1

B sum

next4:
MOV R5, #0

readarray:
CMP R5, #10
BEQ printother

LDR R1, =a
LSL R2, R0, #2 @a
ADD R2, R1, R2
    
LDR R1, [R2]
    
PUSH {R0}
PUSH {R1}
PUSH {R2}
    
MOV R2, R1
MOV R1, R5
    
BL print
    
POP {R2}
POP {R1}
POP {R0}

ADD R5, R5, #1
B readarray


printother:
MOV R1, R6
MOV R2, R8
MOV R3, R9
BL print2

B exit


prompt:
MOV R7, #4
MOV R0, #1
MOV R2, #20
LDR R1, =prompt_str
SWI 0
MOV PC, LR


exit:
MOV R7, #1         
SWI 0 

print:
PUSH {LR}
LDR R0, =print_str
BL printf
POP {PC}

print2:
PUSH {LR}
LDR R0, =print_str2
BL printf
POP {PC}

scanf:
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
a:              .skip       40
num_str:        .asciz      "%d"
print_str:      .asciz      "array_a[%d] = %d\n"
print_str2:     .asciz      "minimum = %d\nmaximum = %d\nsum = %d\n"
prompt_str:     .ascii      "Enter 10 integers.\n"
