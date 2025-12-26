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

.macro new_array(%dst, %row, %column)
mult %row, %column
mflo $a0
sll $a0, $a0, 2
li $v0, 9
syscall
move %dst, $v0
.end_macro

.macro cal_addr(%dst, %array_addr, %row, %column, %rank_column)
mult %row, %rank_column
mflo %dst
addu %dst, %dst, %column
sll %dst, %dst, 2
addu %dst, %dst, %array_addr
.end_macro

.macro read_value(%value, %dst)
lw %value, (%dst)
.end_macro

.data
space: .asciiz " "
enter: .asciiz "\n"
.text
scan_int($s2) # s2 = m1 matrix row
scan_int($s3) # s3 = n1 matrix column
scan_int($s4) # s4 = m2 kernal row
scan_int($s5) # s5 = n2 kernal column
new_array($s0, $s2, $s3) # s0 = matrix address
new_array($s1, $s4, $s5) # s1 = kernal address
sub $s6, $s2, $s4
addi $s6, $s6, 1 # s6 = m1-m2+1
sub $s7, $s3, $s5
addi $s7, $s7, 1 # s7 = n1-n2+1
new_array($t2, $s6, $s7) # t2 = output address

move $t0, $zero
move $t1, $zero
loop_scan_matrix:
scan_int($t3)
cal_addr($t4, $s0, $t0, $t1, $s3)
sw $t3, ($t4)
addi $t1, $t1, 1
bne $t1, $s3, loop_scan_matrix
addi $t0, $t0, 1
move $t1, $zero
bne $t0, $s2, loop_scan_matrix

move $t0, $zero
move $t1, $zero
loop_scan_kernal:
scan_int($t3)
cal_addr($t4, $s1, $t0, $t1, $s5)
sw $t3, ($t4)
addi $t1, $t1, 1
bne $t1, $s5, loop_scan_kernal
addi $t0, $t0, 1
move $t1, $zero
bne $t0, $s4, loop_scan_kernal

# t2 = output_address s6 = output_row s7 = output_column
move $t0, $zero # t0 = i
move $t1, $zero # t1 = j
move $t3, $zero # t3 = k
move $t4, $zero # t4 = l
loop:
cal_addr($t5, $t2, $t0, $t1, $s7)
sw $zero, ($t5)
lw $t6, ($t5) # t6 = output[i][j]
loop_cal:
addu $t7, $t0, $t3 # t7 = i + k
addu $t8, $t1, $t4 # t8 = j + l
cal_addr($t5, $s0, $t7, $t8, $s3)
lw $t7, ($t5) # t7 = matrix[i+k][j+l]
cal_addr($t5, $s1, $t3, $t4, $s5)
lw $t8, ($t5) # t8 = kernal[k][l]
mult $t7, $t8
mflo $t9
addu $t6, $t6, $t9
addi $t4, $t4, 1
bne $t4, $s5, loop_cal
move $t4, $zero
addi $t3, $t3, 1
bne $t3, $s4, loop_cal
cal_addr($t5, $t2, $t0, $t1, $s7)
sw $t6, ($t5)
move $t3, $zero
move $t4, $zero
addi $t1, $t1, 1
bne $t1, $s7, loop
move $t1, $zero
addi $t0, $t0, 1
bne $t0, $s6, loop

move $t0, $zero
move $t1, $zero
loop_print:
cal_addr($t3, $t2, $t0, $t1, $s7)
lw $t4, ($t3)
print_int($t4)
print_str(space)
addi $t1, $t1, 1
bne $t1, $s7, loop_print
move $t1, $zero
print_str(enter)
addi $t0, $t0, 1
bne $t0, $s6, loop_print

li $v0, 10
syscall






















