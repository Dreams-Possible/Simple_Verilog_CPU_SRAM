`timescale 1ns/1ps
module top_test_mem();
    //计数器
    reg[31:0]sys_count;
    //端口
    reg sys_clk;
    reg sys_rst;
    reg mem_ctr;
    reg mem_io;
    wire mem_done;
    reg[31:0]mem_data_addr;
    wire[31:0]mem_data_rd;
    reg[31:0]mem_data_sv;
    //实例化MEM
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
        $dumpfile("top_test_mem.vcd");
        $dumpvars(0,top_test_mem);
        $display("start simulate");
        //复位
        //复位
        sys_rst=1;
        #1
        sys_rst=0;
        #1
        sys_rst=1;
        sys_clk=0;
        sys_count=0;
        #30
        sys_count=sys_count+10;


        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(mem_done==1);
        //保存数据17到内存10
        mem_data_sv=32'd17;
        mem_data_addr=32'd10;
        mem_io=0;
        mem_ctr=0;
        mem_ctr=1;
        sys_count=sys_count+1;

        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(mem_done==1);
        //读取数据17从内存10
        mem_data_addr=32'd10;
        mem_io=1;
        mem_ctr=0;
        mem_ctr=1;
        sys_count=sys_count+1;

        //等待执行完毕
        #1
        wait(sys_clk==1);
        wait(mem_done==1);


        //结束
        sys_count=sys_count+10;
        #30;
        $display("end simulate");
        $finish;
    end

endmodule

