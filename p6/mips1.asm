ori $16, $0, 0x5c1
ori $31, $0, 0x6c63
ori $31, $0, 0xd660
ori $16, $0, 0xfdb9
ori $3, $0, 0x20c6
ori $31, $0, 0x4015
ori $27, $0, 0xa846
ori $29, $0, 0xd865
ori $3, $0, 0x449
ori $4, $0, 0xa2a2
ori $4, $0, 0xa592
ori $3, $0, 0xb529
ori $4, $0, 0x9020
ori $26, $0, 0x4b70
ori $28, $0, 0xc7c
ori $0, $0, 0x61ad
Jarea:
beq $0, $0, JareaEnd
JBackFor20_0:
add $20, $0, $31
jr $20
ori $0, $0, 0x3044
JBackFor20_1:
jr $31
ori $20, $0, 0x3050
JBackFor3_0:
add $3, $0, $31
jr $3
ori $0, $0, 0x3058
JBackFor3_1:
jr $31
ori $3, $0, 0x3064
JBackFor16_0:
add $16, $0, $31
jr $16
ori $0, $0, 0x306c
JBackFor16_1:
jr $31
ori $16, $0, 0x3078
JBackFor2_0:
add $2, $0, $31
jr $2
ori $0, $0, 0x3080
JBackFor2_1:
jr $31
ori $2, $0, 0x308c
JBackFor25_0:
add $25, $0, $31
jr $25
ori $0, $0, 0x3094
JBackFor25_1:
jr $31
ori $25, $0, 0x30a0
JBackFor27_0:
add $27, $0, $31
jr $27
ori $0, $0, 0x30a8
JBackFor27_1:
jr $31
ori $27, $0, 0x30b4
JBackFor29_0:
add $29, $0, $31
jr $29
ori $0, $0, 0x30bc
JBackFor29_1:
jr $31
ori $29, $0, 0x30c8
JBackFor4_0:
add $4, $0, $31
jr $4
ori $0, $0, 0x30d0
JBackFor4_1:
jr $31
ori $4, $0, 0x30dc
JBackFor31_0:
jr $31
JareaEnd:
ori $0, $0, 0x1c
ori $28, $0, 0x1a
ori $21, $0, 0x14
ori $26, $0, 0x17
ori $31, $0, 0x24
ori $20, $0, 0x3050
ori $3, $0, 0x3064
ori $16, $0, 0x3078
ori $2, $0, 0x308c
ori $25, $0, 0x30a0
ori $27, $0, 0x30b4
ori $29, $0, 0x30c8
ori $4, $0, 0x30dc
sw $28, 36($0)
sw $21, 4($0)
sw $4, 24($0)
sw $16, 40($0)
sw $4, 20($0)
sw $0, 24($0)
sw $3, 8($0)
sw $16, 36($0)
sw $16, 20($0)
sw $31, 40($0)
sw $3, 12($0)
sw $16, 20($0)
sw $2, 16($0)
sw $26, 32($0)
sw $26, 40($0)
sw $20, 44($0)
sw $31, 28($0)
sw $26, 36($0)
sw $3, 12($0)
sw $16, 40($0)
Test0Begin:
mtlo $28
nop
sw $31, 69($26)
div $28, $21
sb $31, 29($31)
ori $31, $0, 0x3180
Test0End:
ori $31, $0, 0x6
Test1Begin:
mthi $26
ori $28, $0, 0x85
ori $21, $0, 0x85
divu $26, $28
beq $28, $21, Test1End
ori $31, $0, 0x31a0
lb $28, -107($21)
lui $26, 0x0
ori $31, $0, 0x31a8
Test1End:
ori $28, $0, 0x11
ori $21, $0, 0xe
ori $31, $0, 0x22
Test2Begin:
nop
nop
jal JBackFor31_0
nop
mfhi $26
ori $31, $0, 0x31cc
Test2End:
ori $31, $0, 0xb
Test3Begin:
ori $28, $0, 0x71
ori $31, $0, 0x71
bne $28, $31, Test3End
ori $31, $0, 0x31e4
sub $28, $0, $0
mflo $26
lui $28, 0x0
ori $31, $0, 0x31f0
Test3End:
ori $31, $0, 0x1
Test4Begin:
jal JBackFor31_0
nop
lh $31, 80($26)
ori $31, $21, 0xbd
jr $3
ori $31, $0, 0x3210
ori $31, $0, 0x3210
Test4End:
ori $31, $0, 0x4
Test5Begin:
jal JBackFor3_0
ori $31, $0, 0x3220
mfhi $0
nop
and $21, $28, $28
ori $31, $0, 0x322c
Test5End:
ori $3, $0, 0x3064
ori $31, $0, 0x1e
Test6Begin:
mthi $21
lh $31, 92($26)
ori $0, $21, 0x7c
div $21, $31
lw $28, 68($21)
ori $31, $0, 0x324c
Test6End:
ori $31, $0, 0x17
Test7Begin:
addi $0, $21, 1
lw $28, 56($0)
jal JBackFor31_0
nop
jr $27
ori $31, $0, 0x326c
ori $31, $0, 0x326c
Test7End:
ori $31, $0, 0x20
Test8Begin:
mtlo $31
mtlo $28
lw $21, 32($21)
sw $0, 153($21)
multu $31, $0
multu $28, $0
ori $31, $0, 0x328c
Test8End:
ori $31, $0, 0xa
Test9Begin:
ori $21, $0, 0x25
ori $26, $0, 0x25
mthi $26
jal JBackFor25_0
ori $31, $0, 0x32a8
beq $21, $26, Test9End
ori $31, $0, 0x32b0
jal JBackFor31_0
nop
divu $26, $26
ori $31, $0, 0x32bc
Test9End:
ori $25, $0, 0x30a0
ori $31, $0, 0x2
Test10Begin:
ori $0, $0, 0x3f
ori $21, $0, 0x3f
sb $31, 47($28)
beq $0, $21, Test10End
ori $31, $0, 0x32dc
ori $0, $0, 0x29
mtlo $21
ori $31, $0, 0x32e4
Test10End:
ori $31, $0, 0x7
Test11Begin:
mthi $21
lw $28, 20($28)
add $0, $31, $0
lh $28, 3($31)
ori $31, $0, 0x32fc
Test11End:
ori $31, $0, 0x2f
Test12Begin:
mtlo $26
mthi $28
multu $26, $31
addi $21, $26, 70
or $28, $0, $31
div $28, $21
ori $31, $0, 0x331c
Test12End:
ori $21, $0, 0x2
ori $31, $0, 0x27
Test13Begin:
mfhi $0
mflo $28
lui $31, 0x0
jr $20
ori $31, $0, 0x333c
ori $31, $0, 0x333c
Test13End:
ori $31, $0, 0x4
Test14Begin:
mthi $0
divu $0, $31
lb $28, 10($0)
sw $21, 140($31)
lh $21, 192($21)
ori $31, $0, 0x3358
Test14End:
ori $31, $0, 0x19
Test15Begin:
nop
sw $0, 84($28)
sb $21, -1($26)
jr $16
ori $31, $0, 0x3374
ori $31, $0, 0x3374
Test15End:
ori $31, $0, 0x23
Test16Begin:
sltu $0, $26, $21
jr $2
ori $31, $0, 0x3388
slt $31, $31, $21
ori $31, $0, 0x7
ori $31, $0, 0x3390
Test16End:
ori $31, $0, 0x25
Test17Begin:
mthi $21
mtlo $28
mult $21, $28
jr $27
ori $31, $0, 0x33ac
mtlo $31
ori $31, $0, 0x33b0
Test17End:
ori $31, $0, 0x20
Test18Begin:
mtlo $31
ori $31, $26, 0x2c
sh $28, 106($21)
multu $31, $0
nop
ori $31, $0, 0x33cc
Test18End:
ori $31, $0, 0x11
Test19Begin:
jal JBackFor29_0
ori $31, $0, 0x33dc
addi $21, $26, 140
jr $16
ori $31, $0, 0x33e8
lh $26, -105($21)
ori $31, $0, 0x33ec
Test19End:
ori $29, $0, 0x30c8
ori $21, $0, 0x2a
ori $31, $0, 0x6
Test20Begin:
ori $26, $0, 0x63
ori $21, $0, 0x63
mtlo $0
ori $28, $0, 0x3b
ori $0, $0, 0x3b
bne $26, $21, Test20End
ori $31, $0, 0x3418
mfhi $0
div $0, $21
bne $28, $0, Test20End
ori $31, $0, 0x3428
ori $31, $0, 0x3428
Test20End:
ori $31, $0, 0x16
Test21Begin:
mtlo $26
sh $31, 37($21)
mult $26, $21
lui $28, 0x0
jr $3
ori $31, $0, 0x3448
ori $31, $0, 0x3448
Test21End:
ori $31, $0, 0x11
Test22Begin:
ori $26, $0, 0x97
ori $21, $0, 0x97
sw $26, 111($31)
bne $26, $21, Test22End
ori $31, $0, 0x3464
jal JBackFor3_0
ori $31, $0, 0x346c
addi $26, $28, 60
ori $31, $0, 0x3470
Test22End:
ori $3, $0, 0x3064
ori $21, $0, 0x0
ori $31, $0, 0x0
Test23Begin:
ori $21, $0, 0x91
ori $21, $0, 0x91
bne $21, $21, Test23End
ori $31, $0, 0x3490
mtlo $26
jr $3
ori $31, $0, 0x349c
jr $29
ori $31, $0, 0x34a4
ori $31, $0, 0x34a4
Test23End:
ori $21, $0, 0x23
ori $31, $0, 0x23
Test24Begin:
sw $26, 164($28)
jr $3
ori $31, $0, 0x34bc
lw $0, 152($28)
mtlo $21
ori $31, $0, 0x34c4
Test24End:
ori $31, $0, 0x6
Test25Begin:
mtlo $28
mthi $31
divu $28, $21
jr $20
ori $31, $0, 0x34e0
slt $0, $26, $31
multu $31, $26
ori $31, $0, 0x34e8
Test25End:
ori $31, $0, 0x1a
Test26Begin:
ori $31, $0, 0xad
ori $31, $0, 0xad
mthi $21
beq $31, $31, Test26End
ori $31, $0, 0x3504
lw $26, 156($28)
lh $21, -13502($31)
div $21, $21
ori $31, $0, 0x3510
Test26End:
ori $31, $0, 0x2e
Test27Begin:
ori $31, $0, 0x47
ori $31, $0, 0x47
mtlo $26
mthi $21
bne $31, $31, Test27End
ori $31, $0, 0x3530
mult $26, $26
jal JBackFor20_0
ori $31, $0, 0x353c
ori $31, $0, 0x353c
Test27End:
ori $20, $0, 0x30e4
ori $31, $0, 0xd
Test28Begin:
jr $2
ori $31, $0, 0x3550
jr $25
ori $31, $0, 0x3558
mtlo $31
lui $28, 0x0
ori $31, $0, 0x3560
Test28End:
ori $31, $0, 0x1b
Test29Begin:
lui $28, 0x0
jal JBackFor31_0
nop
andi $21, $21, 0x73
sh $0, 97($21)
ori $31, $0, 0x357c
Test29End:
ori $31, $0, 0x4
Test30Begin:
andi $31, $21, 0x46
jal JBackFor16_0
ori $31, $0, 0x3590
sw $28, 168($0)
jal JBackFor2_0
ori $31, $0, 0x359c
ori $31, $0, 0x359c
Test30End:
ori $16, $0, 0x3078
ori $2, $0, 0x308c
ori $31, $0, 0x2d
Test31Begin:
mthi $28
div $28, $21
ori $31, $0, 0x40
sw $31, 92($0)
mfhi $0
ori $31, $0, 0x35c0
Test31End:
ori $31, $0, 0x5
Test32Begin:
ori $31, $0, 0x58
ori $0, $0, 0x58
or $31, $21, $31
nop
beq $31, $0, Test32End
ori $31, $0, 0x35e0
andi $21, $28, 0x9b
ori $31, $0, 0x35e4
Test32End:
ori $31, $0, 0xb
Test33Begin:
or $31, $28, $28
sub $26, $0, $0
mthi $31
mfhi $26
ori $31, $0, 0x35fc
Test33End:
ori $31, $0, 0x1
Test34Begin:
ori $21, $0, 0xc0
ori $21, $0, 0xc0
mflo $26
nop
beq $21, $21, Test34End
ori $31, $0, 0x361c
jal JBackFor27_0
ori $31, $0, 0x3624
ori $31, $0, 0x3624
Test34End:
ori $27, $0, 0x30b4
ori $21, $0, 0x27
ori $31, $0, 0x0
Test35Begin:
ori $31, $0, 0x9
ori $26, $0, 0x9
mtlo $28
mtlo $26
bne $31, $26, Test35End
ori $31, $0, 0x364c
div $28, $31
mtlo $31
ori $31, $0, 0x3654
Test35End:
ori $31, $0, 0x2b
Test36Begin:
nop
jr $4
ori $31, $0, 0x3668
sw $0, 76($28)
lb $21, -13825($31)
ori $31, $0, 0x3670
Test36End:
ori $31, $0, 0x24
Test37Begin:
jal JBackFor20_0
ori $31, $0, 0x3680
mtlo $28
lw $28, -13872($31)
nop
ori $31, $0, 0x368c
Test37End:
ori $20, $0, 0x30e4
ori $31, $0, 0xa
Test38Begin:
or $21, $26, $21
lui $26, 0x0
jr $3
ori $31, $0, 0x36a8
mthi $21
ori $31, $0, 0x36ac
Test38End:
ori $31, $0, 0x12
Test39Begin:
jr $16
ori $31, $0, 0x36bc
lb $26, 149($21)
jr $29
ori $31, $0, 0x36c8
mflo $0
ori $31, $0, 0x36cc
Test39End:
ori $31, $0, 0x15
Test40Begin:
jal JBackFor20_0
ori $31, $0, 0x36dc
lui $21, 0x0
andi $28, $21, 0xa7
mtlo $31
ori $31, $0, 0x36e8
Test40End:
ori $20, $0, 0x30e4
ori $31, $0, 0x2d
Test41Begin:
nop
jal JBackFor3_0
ori $31, $0, 0x3700
mfhi $28
mtlo $28
ori $31, $0, 0x3708
Test41End:
ori $3, $0, 0x3064
ori $31, $0, 0x25
Test42Begin:
mtlo $28
lb $31, 198($21)
divu $28, $28
mfhi $28
mthi $28
ori $31, $0, 0x3728
Test42End:
ori $31, $0, 0xe
Test43Begin:
ori $26, $0, 0x84
ori $31, $0, 0x84
lui $28, 0x0
beq $26, $31, Test43End
ori $31, $0, 0x3744
ori $26, $21, 0x71
mflo $26
ori $31, $0, 0x374c
Test43End:
ori $26, $0, 0xe
ori $31, $0, 0x1b
Test44Begin:
mthi $21
addi $21, $26, 197
mult $21, $28
andi $31, $0, 0x5f
lw $31, 164($28)
ori $31, $0, 0x376c
Test44End:
ori $21, $0, 0x15
ori $31, $0, 0xd
Test45Begin:
ori $28, $0, 0xa2
ori $21, $0, 0xa2
mflo $31
nop
beq $28, $21, Test45End
ori $31, $0, 0x3790
jal JBackFor27_0
ori $31, $0, 0x3798
ori $31, $0, 0x3798
Test45End:
ori $27, $0, 0x30e4
ori $28, $0, 0xd
ori $21, $0, 0x1c
ori $31, $0, 0x2e
Test46Begin:
lh $28, 55($28)
jr $20
ori $31, $0, 0x37b8
jr $3
ori $31, $0, 0x37c0
sh $26, -14120($31)
ori $31, $0, 0x37c4
Test46End:
ori $31, $0, 0x5
Test47Begin:
jr $20
ori $31, $0, 0x37d4
mtlo $21
lb $28, -14181($31)
jr $3
ori $31, $0, 0x37e4
ori $31, $0, 0x37e4
Test47End:
ori $31, $0, 0x14
Test48Begin:
sb $28, 81($28)
lui $28, 0x0
jr $2
ori $31, $0, 0x37fc
mthi $21
ori $31, $0, 0x3800
Test48End:
ori $31, $0, 0x18
Test49Begin:
andi $21, $28, 0x67
sb $28, 130($28)
mthi $28
lb $28, 51($21)
ori $31, $0, 0x3818
Test49End:
ori $31, $0, 0xe
Test50Begin:
mthi $28
mtlo $21
div $28, $31
divu $21, $26
sub $21, $31, $26
slt $31, $21, $26
ori $31, $0, 0x3838
Test50End:
ori $31, $0, 0x30
Test51Begin:
mfhi $0
mtlo $0
jr $16
ori $31, $0, 0x3850
mfhi $26
ori $31, $0, 0x3854
Test51End:
ori $31, $0, 0x20
Test52Begin:
mthi $28
mtlo $21
add $21, $28, $0
mflo $28
multu $28, $28
multu $21, $31
ori $31, $0, 0x3874
Test52End:
ori $31, $0, 0x13
Test53Begin:
lui $31, 0x0
addi $21, $26, 75
lui $0, 0x0
lui $0, 0x0
ori $31, $0, 0x388c
Test53End:
ori $31, $0, 0x29
Test54Begin:
nop
addi $0, $26, 11
addi $31, $26, 167
mfhi $28
ori $31, $0, 0x38a4
Test54End:
ori $31, $0, 0x31
Test55Begin:
ori $21, $0, 0x91
ori $28, $0, 0x91
ori $31, $0, 0xbd
ori $31, $0, 0xbd
mthi $21
bne $21, $28, Test55End
ori $31, $0, 0x38c8
bne $31, $31, Test55End
ori $31, $0, 0x38d0
mflo $31
ori $31, $0, 0x38d4
Test55End:
ori $28, $0, 0x25
ori $21, $0, 0xc
ori $31, $0, 0x28
Test56Begin:
mfhi $0
mfhi $0
jr $25
ori $31, $0, 0x38f4
sb $0, 145($0)
ori $31, $0, 0x38f8
Test56End:
ori $31, $0, 0x2c
Test57Begin:
mflo $31
mtlo $31
jr $20
ori $31, $0, 0x3910
slt $0, $21, $28
ori $31, $0, 0x3914
Test57End:
ori $31, $0, 0x1a
Test58Begin:
mtlo $28
jr $27
ori $31, $0, 0x3928
lw $21, 35($28)
div $28, $31
sw $21, 164($21)
ori $31, $0, 0x3934
Test58End:
ori $31, $0, 0x2f
Test59Begin:
mthi $28
mtlo $21
jr $16
ori $31, $0, 0x394c
sb $31, 157($0)
ori $31, $0, 0x3950
Test59End:
ori $31, $0, 0x1c
Test60Begin:
andi $0, $21, 0x1a
mtlo $21
mtlo $31
ori $28, $28, 0x0
ori $31, $0, 0x3968
Test60End:
ori $31, $0, 0x14
Test61Begin:
mtlo $0
mthi $26
andi $28, $31, 0x9f
sb $31, 135($21)
multu $0, $0
ori $31, $0, 0x3984
Test61End:
ori $31, $0, 0x20
Test62Begin:
mthi $31
lw $0, 76($21)
multu $31, $31
lui $26, 0x0
add $0, $26, $21
ori $31, $0, 0x39a0
Test62End:
ori $31, $0, 0x17
Test63Begin:
sh $28, 148($28)
jal JBackFor29_0
ori $31, $0, 0x39b4
jal JBackFor31_0
nop
mtlo $26
ori $31, $0, 0x39c0
Test63End:
ori $29, $0, 0x30e4
ori $31, $0, 0x16
Test64Begin:
ori $21, $0, 0x4
ori $26, $0, 0x4
lui $0, 0x0
jr $16
ori $31, $0, 0x39e0
beq $21, $26, Test64End
ori $31, $0, 0x39e8
lui $21, 0x0
ori $31, $0, 0x39ec
Test64End:
ori $31, $0, 0x18
Test65Begin:
mtlo $0
div $0, $21
lw $31, 68($31)
sh $26, 88($0)
lui $26, 0x0
ori $31, $0, 0x3a08
Test65End:
ori $31, $0, 0x17
Test66Begin:
ori $0, $0, 0x36
ori $31, $0, 0x36
ori $21, $0, 0x6d
ori $31, $0, 0x6d
lui $28, 0x0
or $31, $31, $31
bne $0, $31, Test66End
ori $31, $0, 0x3a30
beq $21, $31, Test66End
ori $31, $0, 0x3a38
ori $31, $0, 0x3a38
Test66End:
ori $21, $0, 0x21
ori $31, $0, 0x2e
Test67Begin:
sub $0, $28, $21
jr $4
ori $31, $0, 0x3a50
lui $28, 0x0
and $26, $21, $21
ori $31, $0, 0x3a58
Test67End:
ori $31, $0, 0x9
Test68Begin:
mfhi $26
or $31, $26, $31
nop
jr $27
ori $31, $0, 0x3a74
ori $31, $0, 0x3a74
Test68End:
ori $31, $0, 0x6
Test69Begin:
slt $21, $28, $31
lui $26, 0x0
andi $31, $28, 0x17
jal JBackFor31_0
nop
ori $31, $0, 0x3a90
Test69End:
ori $31, $0, 0x13
Test70Begin:
lui $26, 0x0
nop
sh $31, 72($28)
mtlo $31
ori $31, $0, 0x3aa8
Test70End:
ori $31, $0, 0x1c
Test71Begin:
mtlo $21
lui $21, 0x0
multu $21, $0
add $21, $31, $21
sh $0, -24($21)
ori $31, $0, 0x3ac4
Test71End:
ori $31, $0, 0x17
Test72Begin:
jal JBackFor31_0
nop
mtlo $21
jr $3
ori $31, $0, 0x3ae0
andi $28, $0, 0x5a
ori $31, $0, 0x3ae4
Test72End:
ori $31, $0, 0x5
Test73Begin:
mthi $31
jr $16
ori $31, $0, 0x3af8
andi $0, $21, 0x7a
andi $28, $21, 0x29
div $31, $31
ori $31, $0, 0x3b04
Test73End:
ori $31, $0, 0x29
Test74Begin:
ori $28, $0, 0x3f
ori $28, $0, 0x3f
jal JBackFor16_0
ori $31, $0, 0x3b1c
lw $0, 36($26)
bne $28, $28, Test74End
ori $31, $0, 0x3b28
jr $20
ori $31, $0, 0x3b30
ori $31, $0, 0x3b30
Test74End:
ori $16, $0, 0x3078
ori $31, $0, 0x1d
Test75Begin:
mtlo $28
mflo $28
multu $28, $26
jal JBackFor31_0
nop
nop
ori $31, $0, 0x3b54
Test75End:
ori $31, $0, 0x22
Test76Begin:
mtlo $28
mthi $31
multu $28, $21
lh $0, 12($31)
mtlo $21
ori $31, $0, 0x3b70
Test76End:
ori $31, $0, 0x18
Test77Begin:
or $0, $21, $0
nop
slt $21, $21, $26
sb $31, 11($21)
ori $31, $0, 0x3b88
Test77End:
ori $31, $0, 0x22
Test78Begin:
mflo $28
lw $21, 112($28)
jal JBackFor27_0
ori $31, $0, 0x3ba0
sb $31, -15183($31)
ori $31, $0, 0x3ba4
Test78End:
ori $27, $0, 0x30e4
ori $31, $0, 0x1f
Test79Begin:
ori $28, $0, 0x6c
ori $26, $0, 0x6c
mtlo $0
beq $28, $26, Test79End
ori $31, $0, 0x3bc4
sh $21, 8($28)
mult $0, $26
nop
ori $31, $0, 0x3bd0
Test79End:
ori $28, $0, 0xc
ori $26, $0, 0x1a
ori $31, $0, 0x30
Test80Begin:
jr $4
ori $31, $0, 0x3be8
mthi $0
lui $26, 0x0
nop
ori $31, $0, 0x3bf4
Test80End:
ori $31, $0, 0x28
Test81Begin:
lui $31, 0x0
sw $31, 192($0)
mthi $26
lh $0, 198($26)
ori $31, $0, 0x3c0c
Test81End:
ori $31, $0, 0x12
Test82Begin:
mtlo $26
lb $31, 192($21)
mtlo $0
divu $26, $28
lh $0, 96($28)
ori $31, $0, 0x3c28
Test82End:
ori $31, $0, 0x4
Test83Begin:
ori $0, $0, 0x52
ori $0, $0, 0x52
mthi $31
jal JBackFor2_0
ori $31, $0, 0x3c44
bne $0, $0, Test83End
ori $31, $0, 0x3c4c
lw $31, 36($21)
multu $31, $26
ori $31, $0, 0x3c54
Test83End:
ori $2, $0, 0x30e4
ori $31, $0, 0x4
Test84Begin:
nop
lb $28, 27($21)
mtlo $28
sb $26, 196($28)
ori $31, $0, 0x3c70
Test84End:
ori $31, $0, 0x2a
Test85Begin:
mtlo $26
multu $26, $26
jal JBackFor31_0
nop
lui $0, 0x0
jal JBackFor29_0
ori $31, $0, 0x3c94
ori $31, $0, 0x3c94
Test85End:
ori $29, $0, 0x30c8
ori $31, $0, 0x21
Test86Begin:
ori $28, $0, 0xc1
ori $26, $0, 0xc1
addi $0, $28, 76
nop
beq $28, $26, Test86End
ori $31, $0, 0x3cb8
sw $0, -113($28)
ori $31, $0, 0x3cbc
Test86End:
ori $28, $0, 0x4
ori $26, $0, 0x1b
ori $31, $0, 0x5
