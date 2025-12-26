# ===============================================
# Verilog 仿真自动化 Makefile 模板 (iVerilog + GTKwave)
# ===============================================

# --- 配置区 ---
# 1. 你的所有设计文件 (VHDL/Verilog 源码，用空格分隔)
DESIGN_FILES = pc.v nextPC.v IFU.v F_D.v Controller.v Ext.v ImmExt.v zero.v GRF.v D_E.v MDU.v ALU.v E_M.v DMSave.v DMLoad.v M_W.v chooseRegWE.v CP0.v TC.v Bridge.v cpu.v mips.v

# 2. 你的测试平台文件 (通常只有一个)
TESTBENCH = mips_tb.v

# 3. 编译与输出配置
OUTPUT_FILE = wave
VCD_FILE = wave.vcd               
IVERILOG_ARGS = -Wall   # 编译参数：打开所有警告，支持 SystemVerilog 2012

# 4. 输出重定向
LOG_FILE = output.txt

# ---------------------------------------------
# --- 1. 核心自动化目标 ---

# 默认目标：清理 -> 编译 -> 运行 -> 查看波形
all: clean compile run view

# 目标：编译
compile: $(FILE_LIST)
	@echo "--- 2. 编译 Verilog 文件 ---"
	# 使用 -f 传递文件列表，确保所有模块都被包含
	iverilog $(IVERILOG_ARGS) -o $(OUTPUT_FILE) $(DESIGN_FILES) $(TESTBENCH)

# 目标：运行仿真
run:
	@echo "--- 3. 运行仿真 ---"
	vvp $(OUTPUT_FILE) | tee $(LOG_FILE)

# 目标：查看波形
view:
	@echo "--- 4. 打开波形图 (GTKwave) ---"
	# 使用 open -a 确保在 macOS 下能正确启动 GTKwave
	gtkwave $(VCD_FILE)

# 目标：清理生成文件
clean:
	@echo "--- 清理生成文件 ---"
	rm -f $(OUTPUT_FILE) $(VCD_FILE) vcd.log $(LOG_FILE)

# 阻止 make 尝试查找同名文件作为依赖
.PHONY: all compile run view clean