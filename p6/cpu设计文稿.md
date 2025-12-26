# 设计方案
## 流水线结构
### Fetch Zone
包含`IFU` `F/D`模块，`IFU`中`nPC`的计算方式如下：
```
if D级为非跳转指令/相对跳转指令但不满足跳转条件 then 
    nPC = F_PC+4
if D级是相对跳转指令且满足跳转条件 then
    nPC = D_PC + 4 + sign_entend(imm16 << 2)
    //即F_PC + sign_entend(offset << 2) (延迟槽，无论是否是跳转指令，下一条指令一定是PC+4，即无论D级指令是什么，当前的F_PC一定是D_PC+4)
if D级是绝对跳转指令
    nPC = F_PC[31:28] || (imm26 << 2)
    //同样地，在绝对跳转指令中，跳转地址的最高四位来自延迟槽中的指令，若跳转指令为0xfffffffc，则延迟槽中的指令前四位一定为0001，即跳转地址只能在跳转指令之后
if D级是jr/jalr
    nPC = GRF
```
需要在F/D中流水的数据为`Instr` `PC` `PCplus8`
### Decode Zone
包含`Controller` `GRF` `ImmExt ``zero` `D/E`模块，其中`GRF`在D级负责读取寄存器数据并进行流水，而写相关信号来自W级，`zero`模块负责向F级提供计算`nPC`所需变量  
流水数据为`Instr` `PC` `PCplus8` `fixedRD1` `fixedRD2` `A3` `Imm32`,注意所有使用RD1/2的模块(zero，D/E)均需使用由转发得到的的fixedRD1/2
### Execute Zone
包含`Controller` `ALU` `DMU` `E/M`模块，其中`ALU`输入数据`ALUIn1/2`由控制信号`ALUInput1/2`决定，使用的RD1/2均为转发得到的fixedRD1/2  
流水数据为`Instr` `PC` `PCplus8` `ALUOut` `RD2` `A3`，同样地，RD2为转发得到的fixedRD2
### Memory Zone
包含`Controller` `DMLoad` `DMSave` `M/W`模块，其中`DM`输入地址来自流水的ALUOut，输入数据来自转发得到的fixedRD2  
流水数据为`Instr` `PC` `PCplus8` `A3` `ALUOut` `DMData`
### WriteBack Zone
包含`Controller` `choooseRegWE`模块，其中chooseRegWE根据Controller输出信号与指令共同决定是否写入GRF，根据题目要求可增设选项（可能增加流水的数据），写回GRF的数据根据控制信号选择`PCplus8` `DMData`(代码中为`W_data`)或`ALUOut`
## 阻塞与转发
### 转发
#### 触发条件
令：级次为：`D-0 E-1 M-2 W-3`一条指令需要用到rs/rt寄存器的级次为`t_rs/t_rt`，产生写入寄存器值的级次为`t`,前一条指令到D的距离为`t1`，后一条指令到D的距离为`t2`，记`t_rs_use = t_rs - t2   t_rt_use = t_rt - t2 t_new = t - t1`，则转发的触发条件为：
$$t_{rsuse} >= t_{new}$$
$$t_{rtuse} >= t_{new}$$
另外，若t_use/t_new<0，则记为0
#### 数据通路
为保证不会出现在一个周期中间发生转发，转发终点处数据来不及计算完毕便到了下一个周期，而使得数据赶不上流水，故保证转发的起点需在每一个级次的起点  
起点：M级ALUOut（E级的计算结果） W级RegWriteData E/M的PCplus8（W级与RegWriteData汇合，D级因F级不需要，无需转发）
终点：zero模块的两个输入 ALU模块的两个输入 DM模块的数据输入
除去起点终点在同一级的情况，共有15种数据通路
### 判断条件
1. 是否为 isPCplus8
2. 寄存器编号是否为 0
 . 转发起点和终点寄存器是否相同
4. t_use 值是否存在
5. t_new 值是否存在
6. t_use 是否大于等于 t_new
### 阻塞
#### 触发条件
不满足转发条件时，需要进行阻塞  
可以证明，若不满足触发条件，指令在任意一级均不满足触发条件，故只需使后一指令在D级时对E/M/W的指令进行判断即可，任一不满足均需进行阻塞
#### 实现细节
下一时钟上升沿严禁写入PC，关闭F/D写使能保证D级数据不变，清空D/E数据即为E级加入nop，M/W正常流水
#### 判断条
1. 寄存器编号是否为 0
2. 转发起点和终点寄存器是否相同
3. t_use 值是否存在
4. t_new 值是否存在
5. t_use 是否小于 t_new
## Controller
该模块大体与单周期相同，只是加入了`t—_rs` `t_rt` `t`的计算  
***输出信号含义***：**type**:指令编码，传入ALU进行运算  
                  **nextPC_Sel**:IFU选择信号   
                  `next_Sel 0为PC+4 1为寄存器存储地址(绝对跳转) 2为imm26(相对跳转) 3为imm16+PC+4/PC+4(条件跳转)`   
                  **RegWE**:GRF的写使能信号  
                  **ALUInput1**：选择ALU第一个输入信号   
                  `ALUInput1 0为rs寄存器值，1为shamt`  
                  **ALUInput2**:选择ALU第二个输入信号   
                  `ALUInput2 0为rt寄存器值，1为32位立即数`  
                  **ExtOp**:将指令中的16为立即数拓展为32位立即数的拓展方式   
                  `ExtOp 0为0拓展，1为符号拓展`  
                  **RegDst**:选择写入的寄存器   
                  `RegDst 0为rd寄存器，1为rt寄存器`  
                  **DMWE**:DM的写使能信号  
                  **MemToReg**:选择写入GRF的值   
                  `MemToReg 0为ALU运算结果，1为DM存储的值`  
                  **PCToReg**:选择写入GRF的值   
                  `PCToReg 0为ALU运算结果或DM存储的值，1为PC+4的值（用于jal/jalr）`  
                  **RegRa**:选择写入的寄存器   
                  `RegRa 0为rd寄存器或rt寄存器，1为$ra寄存器`
                  **isMFHILO**:判断是否是mfhi/mflo指令
                  `isMFHILO 0为其他指令 1为mfhi/mflo指令`
                  **start**:乘除运算开始
                  `start 0为其他指令 1为乘除指令`
# 测试方案
未开发评测机，将机器码转化为mips后逐个比对
# 思考题
1. 乘除法计算很慢，整合进ALU很可能拉低整体的主频。单独处理可以不影响后续不需要用到乘除法指令的流水。  
乘除法结果需要两个寄存器保存，使用GRF中的寄存器会对寄存器造成浪费，且需要对同时写入两个寄存器进行额外的适配，以及带来的冒险的解决，带来不必要的设计。
2. 乘法通过移位和累加实现，用一个乘数对另外一个乘数的每一位做乘法（x1即原数，x0即全0）后移位并累加。  
除法通过移位和累减实现，对其被除数和除数后，二者相减，若大于等于0则商1，否则商0，之后将相减结果与除数移位对其并将商左移后，重复上述操作，直到除数回到原位，最后剩余的相减结果即为余数
3. 阻塞信号判断中加入如果是乘除法相关指令且当前start/busy为1则阻塞
4. 清晰性：使能信号直接对应读写内存的对应部分 统一性：无需对h/b信号进行单独处理，只需为其分配不同的使能信号
5. 实际不是一个字节。只需要读写一个字节时，支持按字节读写的cpu的效率会比按字读写高。
6. 定义指令的parameter、统一的Controller、统一的t_rs/rt等。译码时可以直接根据parameter进行控制器的输出、冲突处理也统一转换为t_rs/tr等值的条件判断。
7. 乘除法可能产生的冲突为：
```mips
mult $t0, $t1
mfhi $t2
```
解决方式只能为根据start/busy信号进行阻塞。其他新增指令与P5中指令可能产生的冲突一致，无需额外处理冲突。
8. 完全随机生成：可能产生非法指令（如跳转后紧跟跳转），需对指令进行一定的限制。