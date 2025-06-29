# Simple_Verilog_CPU_SRAM
期末周压力太大写着玩的，没有技术含量，本来有计划实现alu，但刚考完试实验室有项目了，遂搁置。
IDE是VSCode插件DigitalIDE，写verilog功能很丰富，很不错，推荐试试，跑仿真几乎可以平替modelsim。
参考了RISCV的一些ISA指南，但是为了方便实现我这个ISA基本上是随便写的，没想过实际应用。
已经调试差不多了，应该没有问题，感兴趣可以自己改仿真文件玩一玩，读写内存啥的都是正常的。
![image](https://github.com/user-attachments/assets/bc99a754-9c2c-44de-af8e-bcb895e7f99d)
图为CPU仿真流程：将立即数17加载进寄存器0，将寄存器0中的数据保存至内存0，将内存0中的数据读取到寄存器1，可以验证电路工作符合预期。
