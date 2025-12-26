# BUAA-CO-2025
## 项目介绍
北京航空航天大学6系2025年计算机组成实验部分课下代码，核心目标为开发一个支持中断异常的五级流水线CPU。
## 项目结构
1. Pre：预习，Logisim、Verilog、Mips各一道题。
2. P0: Logisim，重点在于FSM（有限状态机）。
3. P1: Verilog，重点同上。
4. P2: Mips，使用汇编语言编写程序。
5. P3: 正式进入CPU搭建。P3使用Logisim搭建单周期CPU。
6. P4: 使用Verilog搭建单周期CPU，即将P3的CPU翻译成Verilog版本。
7. P5: 使用Verilog搭建流水线CPU。
8. P6: 对流水线CPU进行改造，增加乘除法支持，Instruction/Data Memory外置，并增加更多的运算指令。
9. P7: 中断异常。同时引入外设，使我们的CPU能够处理多种内部/外部异常。
## 上机相关
1. Pre-P2:使用Logisim/Verilog/Mips做题目，每次三道题，通过两题算通过。
2. P3-P6:为课下的CPU新增指令（通常不是Mips指令集中的指令），每次三道题，通过两题算通过。
3. P7:共五道题，前四题为课下强测，第五题为新增异常处理支持，通过四题算通过。
## 注意
1. 自P5开始，抛弃了ISE，使用iVerilog+GTKWave，因此你会看到`Makefile` `wave.vcd` `wave`三个文件，详情配置方法请[点击这里](https://michsong.com/posts/co/verilog环境搭建-iverilog+gtkwave/)
2. 在后面的代码中存在部分测试代码，但不能保证所有的测试代码均为合法的测试代码；以及，这一版本我不能百分百确认是最终提交的正确代码，如有问题，欢迎issue。
3. 另外，请不要原封不动提交我的代码，谨防查重。
## 最后
向大家介绍我的个人博客[michsong.com](michsong.com),不定期更新，欢迎来看！