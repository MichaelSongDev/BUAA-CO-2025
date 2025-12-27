.text
li $v0, 5
syscall
move $s0, $v0 # s0=n
li $t0, 4
div $s0, $t0
mfhi $t0 # t0 = n % 4
li $t1, 100
div $s0, $t1
mfhi $t1 # t1 = n % 100
li $t2, 400
div $s0, $t2
mfhi $t2 # t2 = n % 400
beq $t2, 0, if
beq $t0, 0, if_1
j else
if_1:
bne $t1, 0, if
j else
if:
li $a0, 1
j end_if
else:
li $a0, 0
j end_if
end_if:
li $v0, 1
syscall



