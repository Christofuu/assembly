#include <xc.h>

.data  

// String values to sort.
sortString: .asciz "Life is what happens when you're busy making other plans."

.align
// Thus is the vector to sort.
sortVector: .space (0x50 * 4)
            
.text
.align

 

/********************************************************************
R0 Value to be written / read.
R1 Base pointer value.
R2 Offset pointer.
    R1 + R2 == the effective address.
R3 Base pointer value.
R4 Offset pointer.
    R3 + R4 == the effective address.
     
additional vars:
R5 counter variable     
R6 length of vector
R7 stores value1
R8 stores value2
********************************************************************/    
.global asmFunction
asmFunction:    
    ldr R1, = #sortVector
    mov R2, #0
    ldr R3, = #sortString
    mov R4, #0

// Copy the string to a vector of words.
moveChars:            
    ldrb R0, [R3, R4]
    str R0, [R1, R2]
    add R2,R2, #4
    add R4,R4, #1
    cmp R0, #0
    bne moveChars
 // End of setup.  
 
//  Your sorting code goes here. 
    mov R2, #4              // Offset of the vector to sort.
    bubblesort:
    ldr R1, = #sortVector   // Address of the vector to sort.
    mov r0, #0
    bal swap
    /* counts how many swaps occured */
    swap:
    /* load R6 with first value in string */
    ldr R6, [R1]
    /* load R7 with next value in string */
    ldr R7, [R1, R2]
    
    cmp R7, #0
    beq exitcode
    /* compare R6 and R7 */
    cmp R6, R7
    blt swapVal
    
    add R1, R1, #4
    bal swap
    
    swapVal:
    mov R5, R6
    mov R6, R7
    mov R7, R5
    str R6, [R1]
    str R7, [R1, R2]
    /* indicates if a swap occurred */
    add R0, R0, #1
    add R1, R1, #4
    
    
    
    bne swap
    
    exitcode:
    cmp R0, #0
    bne bubblesort
    mov PC,LR  // Return to calling routine.
    

// Return to calling routine.            
   mov pc, lr	  
   
.end asmFunction
   
/**********************************************************************/   
.end 




