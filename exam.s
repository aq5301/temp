    .global main
    .func main
   
   
   .data
   
main:
BL prompt


readarray:
  
minimum:
  
maximum:
  
sum:
  
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
prompt_str:     .ascii      "Enter 10 integers.\n"
