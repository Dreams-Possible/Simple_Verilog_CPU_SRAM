module cpu
(
    //时钟复位
    input wire sys_clk,
    input wire sys_rst,
    //指令
    input wire[31:0]sys_inst_cmd,//指令字节
    input wire sys_inst_up,//指令更新，上升沿有效
    output reg sys_inst_st,//指令状态，1完成
    //输入输出
    output reg sys_io_ctr,//状态控制，1有效
    output reg sys_io_io,//方向控制，0保存、1读取
    input wire sys_io_done,//操作完成，1有效
    output reg[31:0]sys_io_data_addr,//操作地址
    input wire[31:0]sys_io_data_rd,//读取数据
    output reg[31:0]sys_io_data_sv,//保存数据
    //调试输出
    output wire[31:0]sys_cpu_reg0,
    output wire[31:0]sys_cpu_reg1,
    output wire[31:0]sys_cpu_reg2,
    output wire[31:0]sys_cpu_reg3
);

//状态机
reg[3:0]mod_state;
localparam MOD_STATE_WORK=1;//工作
localparam MOD_STATE_WAIT_1=2;//等待阶段1
localparam MOD_STATE_ERROR=3;//错误
localparam MOD_STATE_DONE=4;//完成
//寄存器组
reg[31:0]mod_reg[0:31];

//指令字段
wire[3:0]mod_opcd_0=sys_inst_cmd[31:28];//操作码0
wire[5:0]mod_opcd_1=sys_inst_cmd[27:22];//操作码1
wire[4:0]mod_opreg_0=sys_inst_cmd[21:17];//操作寄存器0
wire[4:0]mod_opreg_1=sys_inst_cmd[16:12];//操作寄存器1
wire[4:0]mod_opreg_2=sys_inst_cmd[11:7];//操作寄存器2
wire[4:0]mod_opreg_3=sys_inst_cmd[6:2];//操作寄存器3
wire[1:0]mod_opext_0=sys_inst_cmd[1:0];//操作扩展0

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

//调试输出连接
assign sys_cpu_reg0=mod_reg[0];
assign sys_cpu_reg1=mod_reg[1];
assign sys_cpu_reg2=mod_reg[2];
assign sys_cpu_reg3=mod_reg[3];

//指令处理
always@(posedge sys_clk or negedge sys_rst)
begin
    //复位
    if(!sys_rst)
    begin
        //初始化寄存器
        mod_reg[0]<=0;
        mod_reg[1]<=0;
        mod_reg[2]<=0;
        mod_reg[3]<=0;
        mod_reg[4]<=0;
        mod_reg[5]<=0;
        mod_reg[6]<=0;
        mod_reg[7]<=0;
        mod_reg[8]<=0;
        mod_reg[9]<=0;
        mod_reg[10]<=0;
        mod_reg[11]<=0;
        mod_reg[12]<=0;
        mod_reg[13]<=0;
        mod_reg[14]<=0;
        mod_reg[15]<=0;
        mod_reg[16]<=0;
        mod_reg[17]<=0;
        mod_reg[18]<=0;
        mod_reg[19]<=0;
        mod_reg[20]<=0;
        mod_reg[21]<=0;
        mod_reg[22]<=0;
        mod_reg[23]<=0;
        mod_reg[24]<=0;
        mod_reg[25]<=0;
        mod_reg[26]<=0;
        mod_reg[27]<=0;
        mod_reg[28]<=0;
        mod_reg[29]<=0;
        mod_reg[30]<=0;
        mod_reg[31]<=0;
        //状态机
        mod_state<=MOD_STATE_DONE;
        //输入输出
        sys_io_ctr<=0;
        sys_io_io<=0;
        sys_io_data_addr<=0;
        sys_io_data_sv<=0;
        //状态
        sys_inst_st<=1;
    end
    //处理
    else
    begin
        //判断状态
        case(mod_state)
            //空闲
            MOD_STATE_DONE:
            begin
                mod_state<=MOD_STATE_DONE;
            end
            //工作
            MOD_STATE_WORK,MOD_STATE_WAIT_1:
            begin
                //操作码0
                case(mod_opcd_0)
                    //基本指令集
                    MOD_INST_BAS:
                    begin
                        //操作码1
                        case(mod_opcd_1)
                            //与
                            MOD_INST_BAS_AND:
                            begin
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]&mod_reg[mod_opreg_2];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //或
                            MOD_INST_BAS_OR:
                            begin
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]|mod_reg[mod_opreg_2];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //非
                            MOD_INST_BAS_NOT:
                            begin
                                mod_reg[mod_opreg_0]<=~mod_reg[mod_opreg_1];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //异或
                            MOD_INST_BAS_XOR:
                            begin
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]^mod_reg[mod_opreg_2];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //复制
                            MOD_INST_BAS_CP:
                            begin
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //左移
                            MOD_INST_BAS_MVL:
                            begin
                                // mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]<<mod_opreg_1;
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]<<mod_reg[mod_opreg_2];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //右移
                            MOD_INST_BAS_MVR:
                            begin
                                // mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]>>mod_opreg_1;
                                mod_reg[mod_opreg_0]<=mod_reg[mod_opreg_1]>>mod_reg[mod_opreg_2];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //加载立即数
                            MOD_INST_BAS_LD:
                            begin
                                mod_reg[mod_opreg_0]<=sys_inst_cmd[16:0];
                                mod_state<=MOD_STATE_DONE;
                            end
                            //未知
                            default:
                            begin
                                mod_state<=MOD_STATE_ERROR;
                            end
                        endcase
                    end
                    //输入输出指令集
                    MOD_INST_IO:
                    begin
                        //操作码1
                        case(mod_opcd_1)
                            //读取
                            MOD_INST_IO_READ:
                            begin
                                case(mod_state)
                                    //发起
                                    MOD_STATE_WORK:
                                    begin
                                        sys_io_data_addr<=mod_reg[mod_opreg_1];
                                        sys_io_io<=1;
                                        sys_io_ctr<=1;
                                        mod_state<=MOD_STATE_WAIT_1;
                                    end
                                    //等待
                                    MOD_STATE_WAIT_1:
                                    begin
                                        if(sys_io_done)
                                        begin
                                            mod_reg[mod_opreg_0]<=sys_io_data_rd;
                                            sys_io_ctr<=0;
                                            mod_state<=MOD_STATE_DONE;
                                        end
                                    end
                                    //未知
                                    default:
                                    begin
                                        mod_state<=MOD_STATE_ERROR;
                                    end                        
                                endcase
                            end
                            //保存
                            MOD_INST_IO_SAVE:
                            begin
                                case(mod_state)
                                    //发起
                                    MOD_STATE_WORK:
                                    begin
                                        sys_io_data_addr<=mod_reg[mod_opreg_1];
                                        sys_io_data_sv<=mod_reg[mod_opreg_0];
                                        sys_io_io<=0;
                                        sys_io_ctr<=1;
                                        mod_state<=MOD_STATE_WAIT_1;
                                    end
                                    //等待
                                    MOD_STATE_WAIT_1:
                                    begin
                                        if(sys_io_done)
                                        begin
                                            sys_io_ctr<=0;
                                            mod_state<=MOD_STATE_DONE;
                                        end
                                    end
                                    //未知
                                    default:
                                    begin
                                        mod_state<=MOD_STATE_ERROR;
                                    end                        
                                endcase
                            end
                            //未知
                            default:
                            begin
                                mod_state<=MOD_STATE_ERROR;
                            end
                        endcase
                    end
                    //未知
                    default:
                    begin
                        mod_state<=MOD_STATE_ERROR;
                    end
                endcase
            end
        endcase
    end
end


//触发
always@(posedge sys_inst_up)
begin
    mod_state<=MOD_STATE_WORK;
end

//输出
always@(*)
begin
    if(mod_state==MOD_STATE_DONE)
    begin
        sys_inst_st=1;
    end
    else
    begin
        sys_inst_st=0;
    end
end


endmodule
