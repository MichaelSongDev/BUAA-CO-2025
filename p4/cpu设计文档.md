# 设计方案
## IFU.v：获取下一条指令及PC地址
***input***：GRF,imm26,imm16,select,zero,clk,reset   
***output***:Instr,PC,PCplus4  
***Design***：PC与nextPC构成Moore状态机以获取指令地址并传入IM，IM传出指令  
### pc.v：当前PC地址
***input***：clk,reset,nextPC  
***output***：PC  
***Design***：寄存器存储，同步复位为0x00003000
### nextPC.v：下一个PC地址
***input***：PC,GRF,imm26,imm16,zero,nextPC_Sel   
***output***：nextPC  
***Design***：根据select信号及zero信号选择下一条指令的地址   
       `select=0`为PC+4  
       `select=1`为寄存器储存地址  
       `select=2`为26位立即数左移2位并高位与PC高4位拼接地址  
       `select=3,zero=0`为PC+4  
       `select=3,zero=1`为16位立即数左移两位并符号拓展+PC+4  
### IM.v：指令存储器
***input***：PC  
***output***：Instr   
***Design***：采用ROM(reg [31:0] ROM [0:4095])存储指令 指令地址为（PC-0x00003000）[2:13]  
## ImmExt.v:获取16位立即数及32位拓展
***input***:Instr,Op  
***output***:imm32,imm16  
***Design***:获取指令中的16位立即数，并根据ExtOp选择拓展方式，将16位及32位(Ext模块)立即数输出 `0为0拓展，1为符号拓展`  
### Ext.v:获取16位立即数的32位拓展
***input***:imm16, Op  
***output***：imm32  
***Design***:输出指令中16位立即数的32位拓展 `0为0拓展，1为符号拓展`  
## Controller.v：根据指令输出控制信号
***input***：Opcode，Funct  
***output***：type,nextPC_Sel,RegWE,ALUInput1,ALUInput2,ExtOp,RegDst,DMWE,MemToReg,PCToReg,RegRa   
***Design***:根据Opcode，Funct获得独热编码，使用译码器将独热编码转换为5位二进制数字，并使用多路选择器输出控制信号  
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
                
## GRF.v:寄存器堆
***input***:A1,A2,A3,WD,clk,reset,WE,PC  
***output***:RD1,RD2 
***Design***:RD1输出A1地址寄存器内的值，RD2输出A2地址寄存器内的值，写使能信号开启后A3地址寄存器读入WriteData的值（时钟上升沿）并使用display语句输出相关信息（PC、A3，WD），同步复位为0x00000000  
## ALU.v:运算单元
***input***:in1，in2，type  
***output***:out，zero  
***Design***:根据type选择不同运算结果输出至out，zero表示条件跳转指令中条件是否满足，并将结果传入IFU  
## DM.v:数据存储器
***input***:Addr,WD,clk,reset,WE,PC  
***output***:Data  
***Design***:使用RAM(reg [31:0] RAM [0:3071])存储数据，写使能信号开启将WD写入Addr处并使用display语句输出相关信息（PC、Addr、WD)，Data输出Addr处数据，Addr由ALU运算得到（负责实现存取内存指令，如lw，sw）  
# chooseRegWE.v:寄存器堆写使能信号
***input***:Controller_RegWE,Rs,Rt,Rd,Shamt,type  
***output***:WE  
***Design***:根据Controller及具体指令对寄存器的写使能进行特判
# 测试方案
未开发评测机，将机器码转化为mips后逐个比对
# 思考题
1. addr信号来自ALU运算结果 忽略最低两位，即除以4，用于根据字节地址计算RAM的地址
2. 方案一
    ```verilog
    always @(*) begin
        case(code) begin
            ADD: begin
                nextPC_Sel = 2'b00;
            end
        endcase
    end
    ```
    方案二
    ```verilog
    assign nextPC_Sel = (jr | jalr) ? 2'b01 : 
                            (j | jal) ? 2'b10 :
                            (beq | bne) ? 2'b11 : 2'b00;
    ```
    方案一：便于扩展但可能存在无意义赋值，不便于调试  
    方案二：扩展可能不方便但简洁清晰，不会存在无意义赋值
3. 同步复位要等到时钟上升沿进行复位，clk优先级高；异步复位无论时钟状态均进行复位，reset优先级高
4. ADDI与ADDIU区别仅为ADDI将运算结果存入temp[32:0]，若temp[32] != temp[31]即溢出，否则将temp[31:0]存入Rt寄存器，而ADDIU没有判断溢出这一过程；就结果而言，Rt寄存器存储的均为0-31位，故在忽略溢出的前提下而这没有区别；ADD与ADDU同理