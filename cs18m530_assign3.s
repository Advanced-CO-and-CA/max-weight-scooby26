.data
data_start: .word 0x205A15E3, 0x256C8700, 0x295468F2, 0x0		
NUM: .word 0x0
WEIGHT : .word 0x0

LDR R1, =data_start
LDR R2, [R1]
MOV R3, #0
data_load: LDR R8, [R1], #4
MOV R4, R8
CMP R4, #0
BEQ done
MOV R7, #32 // Loop 32bits
MOV R6, #0
weights: ANDS R5, R4, #0x1 // AND LSB with 1
BEQ shift 
ADD R6, R6, #0x1 // If the result is 1 after AND, then increment 
shift: LSR R4, R4, #1 // Shift by 1 to the right
SUB R7, #1
CMP R7, #0 // Check if the word is exhausted
BNE weights 
CMP R6, R3 
BLE data_load
MOV R2, R8
MOV R3, R6
B data_load
done: LDR R1, =NUM
STR R2, [R1]
LDR R1, =WEIGHT
STR R3, [R1]