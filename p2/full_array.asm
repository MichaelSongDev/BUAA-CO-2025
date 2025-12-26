.macro print_int(%src)
move $a0, %src
li $v0, 1
syscall
.end_macro

.macro print_str(%src)
la $a0, %src
li $v0, 4
syscall
.end_macro

.macro scan_int(%dst)
li $v0, 5
syscall
move %dst, $v0
.end_macro

.macro get_offset(%dst, %index)
sll %dst, %index, 2
.end_macro

.macro end
li $v0, 10
syscall
.end_macro

.data
symbol: .space 28
array:  .space 28
n:      .space 4

space:.asciiz " "
enter:.asciiz "\n"

.text
scan_int($s0)
sw $s0, n
move $a0, $zero
jal FullArray
end


FullArray:
lw $s0, n # s0 = n
bge $a0, $s0, FullArrayEnd # if a0 >= s0 end
addi $sp, $sp, -12
sw $ra, ($sp)
sw $a0, 8($sp)

move $t0, $zero
loop:
get_offset($t1, $t0)
lw $t2, symbol($t1) 
bne $t2, 0, plus # symbol[i] != 0 -> plus

get_offset($t1, $a0)
lw $t3, array($t1)
addi $t3, $t0, 1
sw $t3, array($t1) # array[index]=i+1

get_offset($t1, $t0)
lw $t3, symbol($t1)
li $t3, 1 
sw $t3, symbol($t1)# symbol[i]=1

sw $t0, 4($sp) # save i to stack
addi $a0, $a0, 1
jal FullArray
lw $ra, ($sp)
lw $a0, 8($sp) # restore index
lw $t0, 4($sp) # restore i

get_offset($t1, $t0)
lw $t3, symbol($t1)
li $t3, 0
sw $t3, symbol($t1)# symbol[i]=0
j plus

plus:
addi $t0, $t0, 1
bne $t0, $s0, loop
addi $sp, $sp, 12
jr $ra


FullArrayEnd:
move $t0, $zero
print_loop:
get_offset($t1, $t0)
lw $t2, array($t1)
print_int($t2)
print_str(space)
addi $t0, $t0, 1
bne $t0, $s0, print_loop
print_str(enter)
jr $ra





























































