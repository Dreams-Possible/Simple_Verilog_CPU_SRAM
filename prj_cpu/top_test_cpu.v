
`timescale 1ns/1ps
module top_test_cpu();
    //计数器
    reg[31:0]sys_count;
    //端口
    reg sys_clk;
    reg sys_rst;
    //实例化CPU
    reg[31:0]cpu_inst_cmd;
    reg cpu_inst_up;
    wire cpu_inst_st;
    wire cpu_io_ctr;
    wire cpu_io_io;
    reg cpu_io_done;
    wire[31:0]cpu_io_data_addr;
    reg[31:0]cpu_io_data_rd;
    wire[31:0]cpu_io_data_sv;
    wire[31:0]cpu_cpu_reg0;
    wire[31:0]cpu_cpu_reg1;
    wire[31:0]cpu_cpu_reg2;
    wire[31:0]cpu_cpu_reg3;
    cpu
    u_cpu(
        .sys_clk          	(sys_clk           ),
        .sys_rst          	(sys_rst           ),
        .sys_inst_cmd     	(cpu_inst_cmd      ),
        .sys_inst_up      	(cpu_inst_up       ),
        .sys_inst_st      	(cpu_inst_st       ),
        .sys_io_ctr       	(cpu_io_ctr        ),
        .sys_io_io        	(cpu_io_io         ),
        .sys_io_done      	(cpu_io_done       ),
        .sys_io_data_addr 	(cpu_io_data_addr  ),
        .sys_io_data_rd   	(cpu_io_data_rd    ),
        .sys_io_data_sv   	(cpu_io_data_sv    ),
        .sys_cpu_reg0     	(cpu_cpu_reg0      ),
        .sys_cpu_reg1     	(cpu_cpu_reg1      ),
        .sys_cpu_reg2     	(cpu_cpu_reg2      ),
        .sys_cpu_reg3     	(cpu_cpu_reg3      )
    );
    //实例化MEM
    reg mem_ctr;
    reg mem_io;
    wire mem_done;
    reg[31:0]mem_data_addr;
    wire[31:0]mem_data_rd;
    reg[31:0]mem_data_sv;
    mem
    u_mem(
        .sys_clk     	(sys_clk      ),
        .sys_rst     	(sys_rst      ),
        .sys_ctr     	(mem_ctr      ),
        .sys_io      	(mem_io       ),
        .sys_done    	(mem_done     ),
        .sys_data_addr  (mem_data_addr),
        .sys_data_rd 	(mem_data_rd  ),
        .sys_data_sv 	(mem_data_sv  )
    );
    //连接
    assign mem_ctr        = cpu_io_ctr;
    assign mem_io         = cpu_io_io;
    assign mem_data_addr  = cpu_io_data_addr;
    assign mem_data_sv    = cpu_io_data_sv;
    assign cpu_io_done    = mem_done;
    assign cpu_io_data_rd = mem_data_rd;


    //时钟
    always
    begin
        #10;
        sys_clk=~sys_clk;
    end

    //功能
    initial
    begin
        //初始化
        $display("end simulate");
        $dumpfile("top_test_cpu.vcd");
        $dumpvars(0,top_test_cpu);
        $display("start simulate");
        //复位
        sys_rst=1;
        #1
        sys_rst=0;
        #1
        sys_rst=1;
        sys_clk=0;
        sys_count=0;
        #10
        sys_count=10;

        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(cpu_inst_st==1);
        //加载立即数到寄存器0
        cpu_inst_cmd={4'd1,6'd8,5'd0,17'd17};
        cpu_inst_up=0;
        cpu_inst_up=1;
        sys_count=sys_count+1;

        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(cpu_inst_st==1);
        //保存数据到内存0
        cpu_inst_cmd={4'd2,6'd2,5'd0,5'd0,12'd0};
        cpu_inst_up=0;
        cpu_inst_up=1;
        sys_count=sys_count+1;

        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(cpu_inst_st==1);
        //读取内存0到寄存器1
        cpu_inst_cmd={4'd2,6'd1,5'd1,5'd0,12'd0};
        cpu_inst_up=0;
        cpu_inst_up=1;
        sys_count=sys_count+1;

        //等待执行完毕
        #1
        // $display("sys_clk=%b",sys_clk);
        wait(sys_clk==1);
        // $display("cpu_inst_st=%b",cpu_inst_st);
        wait(cpu_inst_st==1);
        //结束
        sys_count=sys_count+10;
        #40;
        $display("end simulate");
        $finish;
    end

endmodule







// `timescale 1ns/1ps
// module top_test_cpu();
//     //计数器
//     reg[31:0]sys_count;
//     //端口
//     reg sys_clk;
//     reg sys_rst;
//     reg[31:0]cpu_inst_cmd;
//     reg cpu_inst_up;
//     wire cpu_inst_st;
//     wire cpu_io_ctr;
//     wire cpu_io_io;
//     reg cpu_io_done;
//     wire[31:0]cpu_io_data_addr;
//     reg[31:0]cpu_io_data_rd;
//     wire[31:0]cpu_io_data_sv;
//     wire[31:0]cpu_cpu_reg0;
//     wire[31:0]cpu_cpu_reg1;
//     wire[31:0]cpu_cpu_reg2;
//     wire[31:0]cpu_cpu_reg3;
//     //实例化CPU
//     cpu
//     u_cpu(
//         .sys_clk          	(sys_clk           ),
//         .sys_rst          	(sys_rst           ),
//         .sys_inst_cmd     	(cpu_inst_cmd      ),
//         .sys_inst_up      	(cpu_inst_up       ),
//         .sys_inst_st      	(cpu_inst_st       ),
//         .sys_io_ctr       	(cpu_io_ctr        ),
//         .sys_io_io        	(cpu_io_io         ),
//         .sys_io_done      	(cpu_io_done       ),
//         .sys_io_data_addr 	(cpu_io_data_addr  ),
//         .sys_io_data_rd   	(cpu_io_data_rd    ),
//         .sys_io_data_sv   	(cpu_io_data_sv    ),
//         .sys_cpu_reg0     	(cpu_cpu_reg0      ),
//         .sys_cpu_reg1     	(cpu_cpu_reg1      ),
//         .sys_cpu_reg2     	(cpu_cpu_reg2      ),
//         .sys_cpu_reg3     	(cpu_cpu_reg3      )
//     );
    
//     //时钟
//     always
//     begin
//         #10;
//         sys_clk=~sys_clk;
//     end

//     //功能
//     initial
//     begin
//         //初始化
//         $display("end simulate");
//         $dumpfile("top_test_cpu.vcd");
//         $dumpvars(0,top_test_cpu);
//         $display("start simulate");
//         //复位
//         sys_rst=1;
//         #1
//         sys_rst=0;
//         #1
//         sys_rst=1;
//         sys_clk=0;
//         sys_count=0;
//         #30
//         sys_count=sys_count+10;



//         //等待执行完毕
//         #1
//         wait(sys_clk==1);
//         // $display("cpu_inst_st=%b",cpu_inst_st);
//         wait(cpu_inst_st==1);
//         //加载立即数到寄存器0
//         cpu_inst_cmd={4'b0001,6'b1001,5'd0,17'd17};
//         cpu_inst_up=0;
//         cpu_inst_up=1;
//         sys_count=sys_count+1;


//         //等待执行完毕
//         #1
//         $display("sys_clk=%b",sys_clk);
//         wait(sys_clk==1);
//         $display("cpu_inst_st=%b",cpu_inst_st);
//         wait(cpu_inst_st==1);
//         //加载立即数到寄存器0
//         cpu_inst_cmd={4'b0001,6'b1001,5'd0,17'd8};
//         cpu_inst_up=0;
//         cpu_inst_up=1;
//         sys_count=sys_count+1;


//         //等待执行完毕
//         #1
//         $display("sys_clk=%b",sys_clk);
//         wait(sys_clk==1);
//         $display("cpu_inst_st=%b",cpu_inst_st);
//         wait(cpu_inst_st==1);
//         //寄存器左移
//         cpu_inst_cmd={4'b0001,6'b0110,5'd0,5'd0,5'd0,5'd0,2'd0};
//         cpu_inst_up=0;
//         cpu_inst_up=1;
//         sys_count=sys_count+1;


//         //等待执行完毕
//         #1
//         $display("sys_clk=%b",sys_clk);
//         wait(sys_clk==1);
//         $display("cpu_inst_st=%b",cpu_inst_st);
//         wait(cpu_inst_st==1);
//         //结束
//         sys_count=sys_count+10;
//         #30;
//         $display("end simulate");
//         $finish;
//     end

// endmodule


