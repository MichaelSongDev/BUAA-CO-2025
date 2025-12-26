.macro cal_addr(%dst, %row, %column, %rank)
mult %row, %rank
mflo %dst
addu %dst, %dst, %column
sll %dst, %dst, 2
.end_macro 

.macro scan_int(%dst)
li $v0, 5
syscall
move %dst, $v0
.end_macro

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

.data
n:.space 4
enter:.asciiz "\n"
space:.asciiz " "
.text
la $s0, n
scan_int($s0) #$s0 = n

li $t0, 4
mult $s0, $s0
mflo $a0
mult $a0, $t0
mflo $a0
li $v0, 9
syscall
move $s1, $v0 #$s1 = matrix1 address
li $v0, 9
syscall
move $s2, $v0 #s2 = matrix2 address

#scan martix 1
move $t0, $zero #t0 = row
move $t1, $zero #t1 = column
loop_1:
cal_addr($t2, $t0, $t1,$s0) # t2 = offset_addr
addu $t2, $t2, $s1
scan_int($t3) #t3 = scan_value
sw $t3, ($t2)
addi $t1, $t1, 1
bne $t1, $s0, loop_1
move $t1, $zero
addi $t0, $t0, 1
bne $t0, $s0, loop_1

#scan matrix 2
move $t0, $zero #t0 = row
move $t1, $zero #t1 = column
loop_2:
cal_addr($t2, $t0, $t1, $s0) # t2 = offset_addr
addu $t2, $t2, $s2
scan_int($t3) #t3 = scan_value
sw $t3, ($t2)
addi $t1, $t1, 1
bne $t1, $s0, loop_2
move $t1, $zero
addi $t0, $t0, 1
bne $t0, $s0, loop_2

#cal res
move $t0, $zero #matrix1 row
move $t1, $zero #matrix1 column
move $t2, $zero #martix2 row
move $t3, $zero #matrix2 column
move $t4, $zero #addr
move $t5, $zero #temp
move $t6, $zero #temp
move $s3, $zero #s3 = res

loop_3:
cal_addr($t4, $t0, $t1, $s0)
addu $t4, $t4, $s1
lw $t5, ($t4)
cal_addr($t4, $t2, $t3, $s0)
addu $t4, $t4, $s2
lw $t6, ($t4)
mult $t5, $t6
mflo $t5
addu $s3, $s3, $t5

addi $t1, $t1, 1
addi $t2, $t2, 1
bne $t1, $s0, loop_3
print_int($s3)
print_str(space)
addi $t3, $t3, 1
move $s3, $zero
move $t1, $zero
move $t2, $zero
bne $t3, $s0, loop_3
print_str(enter)
move $t3, $zero
addi $t0, $t0, 1
bne $t0, $s0, loop_3

li $v0, 10
syscall

