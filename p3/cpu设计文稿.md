# 设计方案
## IFU：获取下一条指令及PC地址
***input***：clk,rst,GRF,imm26,imm16,IFU_Sel,zero  
***output***:Instr,PC,PC+4  
***Design***：PC与nextPC构成Moore状态机以获取指令地址并传入IM，IM传出指令  
### PC：当前PC地址
***input***：nextPC，clk，rst  
***output***：PC  
***Design***：寄存器存储，双异或设置初值  
### nextPC：下一个PC地址
***input***：GRF，imm26，imm16，select，zero，PC  
***output***：nextPC  
***Design***：根据select信号及zero信号选择下一条指令的地址   
       `select=0`为PC+4  
       `select=1`为寄存器储存地址  
       `select=2`为26位立即数左移2位并高位与PC高4位拼接地址  
       `select=3,zero=0`为PC+4  
       `select=3,zero=1`为16位立即数左移两位并符号拓展+PC+4  
### IM：指令存储器
***input***：PC  
***output***：Instruction  
***Design***：采用ROM存储指令 指令地址为（PC-0x00003000）[2:13]  
## ImmExt:获取16位立即数及32位拓展
***input***:Instruction,ExtOp  
***output***:imm32,imm16  
***Design***:获取指令中的16位立即数，并根据ExtOp选择拓展方式，将16位及32位(Ext模块)立即数输出 `0为0拓展，1为符号拓展`  
### Ext:获取16位立即数的32位拓展
***input***:Instruction，ExtOp  
***output***：imm32  
***Design***:输出指令中16位立即数的32位拓展 `0为0拓展，1为符号拓展`  
## Controller：根据指令输出控制信号
***input***：Opcode，Funct  
***output***：IFU_Sel,type,RegWE,ALUInput2,ExtOp,RegDst,DMWE,MemToReg,PCToReg,Teg_ra,ALUInput1  
***Design***:根据Opcode，Funct获得独热编码，使用译码器将独热编码转换为5位二进制数字，并使用多路选择器输出控制信号  
***输出信号含义***：**IFU_Sel**:IFU选择信号   
            `IFU_Sel 0为PC+4 1为寄存器存储地址(绝对跳转) 2为imm26(相对跳转) 3为imm16+PC+4/PC+4(条件跳转)`  
            **type**:指令编码，传入ALU进行运算  
            **RegWE**:GRF的写使能信号  
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
            **Reg_ra**:选择写入的寄存器   
            `Reg_ra 0为rd寄存器或rt寄存器，1为$ra寄存器`  
            **ALUInput1**：选择ALU第二个输入信号   
            `ALUInput1 0为rs寄存器值，1为shamt`  
## GRF:寄存器堆
***input***:clk,rst,WriteEnable,Addr1,Addr2,Addr3,WriteData  
***output***:ReadData1,ReadData2  
***Design***:ReadData1输出Addr1地址寄存器内的值，ReadData2输出Addr2地址寄存器内的值，写使能信号开启后Addr3地址寄存器读入WriteData的值（时钟上升沿）  
## ALU:运算单元
***input***:in1，in2，type  
***output***:out，zero  
***Design***:根据type选择不同运算结果输出至out，zero表示条件跳转指令中条件是否满足，并将结果传入IFU  
## DM:数据存储器
***input***:Addr，WriteData，WriteEnable，clk，rst  
***output***:Data  
***Design***:使用RAM存储数据，写使能信号开启将WriteData写入Addr处，Data输出Addr处数据，Addr由ALU运算得到（负责实现存取内存指令，如lw，sw）  
# 测试方案
未开发评测机，将机器码转化为mips后逐个比对
# 思考题
1.上面我们介绍了通过 FSM 理解单周期 CPU 的基本方法。请大家指出单周期 CPU 所用到的模块中，哪些发挥状态存储功能，哪些发挥状态转移功能。  
(Splitter上游)状态存储：PC 状态转移：nextPC  
(Splitter下游)状态存储：GRF 状态转移：Controller及其控制的ALU等部件  
   
2.现在我们的模块中 IM 使用 ROM， DM 使用 RAM， GRF 使用 Register，这种做法合理吗？ 请给出分析，若有改进意见也请一并给出。  
合理。IM负责存储指令，存入后不应修改；DM负责存储数据，根据指令可多次修改；GRF负责存储0-31号寄存器  
   
3.在上述提示的模块之外，你是否在实际实现时设计了其他的模块？如果是的话，请给出介绍和设计的思路。  
无其他模块。  
   
4.事实上，实现 nop 空指令，我们并不需要将它加入控制信号真值表，为什么？  
可与未知指令并入一起，将所有控制信号全部输出0即可（事实上，由于实现了sll指令，占用了nop的指令信号，而sll与nop区别仅在于sll开启了GRF写使能端口，且此行为对nop无影响（无法对$0赋值），故将nop指令当作sll处理，仅在输出测试信号中GRF写使能信号端口加以判断）  
   
5.阅读 Pre 的 “MIPS 指令集及汇编语言” 一节中给出的测试样例，评价其强度（可从各个指令的覆盖情况，单一指令各种行为的覆盖情况等方面分析），并指出具体的不足之处。  
指令覆盖情况：按题干要求指令，测试数据未测试nop指令
单一指令行为覆盖：add未测试操作数为0的情况，lw，sw均未测试偏移量为负数的情况，beq未测试操作数为0的情况，各指令写入地址均未测试写入$0的情况