module mem
(
    //时钟复位
    input wire sys_clk,
    input wire sys_rst,
    //输入输出
    input wire sys_ctr,//状态控制，1有效
    input wire sys_io,//方向控制，0保存、1读取
    output reg sys_done,//操作完成，1有效
    input wire[31:0]sys_data_addr,//操作地址
    output reg[31:0]sys_data_rd,//读取数据
    input wire[31:0]sys_data_sv//保存数据
);

//状态机
parameter[1:0]MOD_STATE_WORK=1;
parameter[1:0]MOD_STATE_DONE=2;
reg[1:0]mod_state;
//寄存器组
reg[31:0]mod_reg[0:31];

//逻辑实现
always@(posedge sys_clk or negedge sys_rst)
begin
    //复位
    if(!sys_rst)
    begin
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
        mod_state<=MOD_STATE_DONE;
        sys_data_rd<=0;
        sys_done<=1;
    end
    //功能
    else
    begin
        case(mod_state)
            //空闲
            MOD_STATE_DONE:
            begin
                mod_state<=MOD_STATE_DONE;
            end
            //读写
            MOD_STATE_WORK:
            begin
                //判断方向
                case(sys_io)
                    //保存
                    0:
                    begin
                        mod_reg[sys_data_addr]<=sys_data_sv;
                    end
                    //读取
                    1:
                    begin
                        sys_data_rd<=mod_reg[sys_data_addr];
                    end
                endcase
                mod_state<=MOD_STATE_DONE;
            end
            //错误
            default:
            begin
                mod_state<=MOD_STATE_DONE;
            end
        endcase
    end
end

//触发
always@(posedge sys_ctr)
begin
    mod_state<=MOD_STATE_WORK;
end

//输出
always@(*)
begin
    if(mod_state==MOD_STATE_DONE)
    begin
        sys_done=1;
    end
    else
    begin
        sys_done=0;
    end
end

endmodule
