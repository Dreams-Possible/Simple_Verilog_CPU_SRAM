//指令字段
wire[3:0]opcd_0=inst_cmd[31:28];//操作码0
wire[5:0]opcd_1=inst_cmd[27:22];//操作码1
wire[4:0]opreg_0=inst_cmd[21:17];//操作寄存器0
wire[4:0]opreg_1=inst_cmd[16:12];//操作寄存器1
wire[4:0]opreg_2=inst_cmd[11:7];//操作寄存器2
wire[4:0]opreg_3=inst_cmd[6:2];//操作寄存器3
wire[1:0]opext_0=inst_cmd[1:0];//操作扩展0

//基本指令集
localparam MOD_INST_BAS=1;
localparam MOD_INST_BAS_AND=1;//与
localparam MOD_INST_BAS_OR=2;//或
localparam MOD_INST_BAS_NOT=3;//非
localparam MOD_INST_BAS_XOR=4;//异或
localparam MOD_INST_BAS_CP=5;//复制
localparam MOD_INST_BAS_MVL=6;//左移
localparam MOD_INST_BAS_MVR=7;//右移
localparam MOD_INST_BAS_LD=8;//加载立即数
//输入输出指令集
localparam MOD_INST_IO=2;
localparam MOD_INST_IO_READ=1;//读取
localparam MOD_INST_IO_SAVE=2;//保存
//数学运算指令集
localparam MOD_INST_MC=3;
localparam MOD_INST_MC_ADD=1;//加
localparam MOD_INST_MC_SUB=2;//减
localparam MOD_INST_MC_BGT=3;//大于
localparam MOD_INST_MC_EQ=4;//等于
localparam MOD_INST_MC_LST=5;//小于

//指令集架构
4               6           5           5           5           5           2
opcd_0          opcd_1      opreg_0     opreg_1     opreg_2     opreg_3     opext_0
基本指令集       与          目标寄存器   源寄存器1    源寄存器2
基本指令集       或          目标寄存器   源寄存器1    源寄存器2
基本指令集       非          目标寄存器   源寄存器
基本指令集       异或        目标寄存器   源寄存器1     源寄存器2
基本指令集       复制        目标寄存器   源寄存器
基本指令集       左移        目标寄存器   源寄存器      位数寄存器
基本指令集       右移        目标寄存器   源寄存器      位数寄存器
基本指令集       加载        目标寄存器   17位立即数
输入输出指令集    加载        目标寄存器   内存寄存器
输入输出指令集    保存        目标寄存器   内存寄存器
数学运算指令集    加          目标寄存器   源寄存器1    源寄存器2
数学运算指令集    减          目标寄存器   源寄存器1    源寄存器2
数学运算指令集    小于        目标寄存器   源寄存器1    源寄存器2
数学运算指令集    等于        目标寄存器   源寄存器1    源寄存器2


// //指令集架构（寄存器均为地址）
// 3               3           3           5           5           5           5
// opcd_0          opcd_1      opcd_2      opreg_0     opreg_1     opreg_2     opreg_3
// 基本指令集       与                      目标寄存器   源寄存器1    源寄存器2
// 基本指令集       或                      目标寄存器   源寄存器1    源寄存器2
// 基本指令集       非                      目标寄存器   源寄存器
// 基本指令集       异或                    目标寄存器   源寄存器1    源寄存器2
// 基本指令集       复制                    目标寄存器   源寄存器
// 基本指令集       左移                    目标寄存器   源寄存器
// 基本指令集       右移                    目标寄存器   源寄存器
// 基本指令集       加载低位                目标寄存器    15位立即数

// 输入输出指令集    加载                    目标寄存器   内存寄存器
// 输入输出指令集    保存                    目标寄存器   内存寄存器
