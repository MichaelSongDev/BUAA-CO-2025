.macro new_array(%dst, %size)
move $a0, %size
sll $a0, $a0, 2
li $v0, 9
syscall
move %dst, $v0
.end_macro

.macro scan_int(%dst)
li $v0, 5
syscall
move %dst, $v0
.end_macro

.macro scan_char(%dst)
li $v0, 12
syscall
move %dst, $v0
.end_macro

.text
scan_int($s0) # s0=n
new_array($s1, $s0) # s1=string_address

move $t0, $zero
move $t1, $zero
li $t2, 4
loop_scan:
mult $t0, $t2
mflo $t3
addu $t1, $s1, $t3
scan_char($t3)
sw $t3, ($t1)
addi $t0, $t0, 1
bne $t0, $s0, loop_scan

move $t0, $zero #t0 = i
loop:
sll $t1, $t0, 2
addu $t1, $t1, $s1 # t1=string[i] address
lw $s2, ($t1) # s1 = string[i]
sub $t2, $s0, $t0 
addi $t2, $t2, -1# t2 = n-i-1
sll $t1, $t2, 2
addu $t1, $t1, $s1 # t1 = string[n-i-1] address
lw $s3, ($t1) # s2 = string[n-i-1]

bne $s2, $s3, not_equal
addi $t0, $t0, 1
bne $t0, $s0, loop
j equal

equal:
li $a0, 1
li $v0, 1
syscall
j end

not_equal:
li $a0, 0
li $v0, 1
syscall
j end

end:
li $v0, 10
syscall
