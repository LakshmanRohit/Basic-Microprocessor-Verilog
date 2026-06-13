`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2026 06:51:18 PM
// Design Name: 
// Module Name: pipe_MIPS32_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipe_MIPS32_tb();

reg clk1,clk2;
integer k;

pipe_MIPS32 mips (clk1,clk2);

initial
  begin
    clk1=0; clk2=0;
    repeat(20) // Two phase clock
     begin
        #5 clk1=1; 
        #5 clk1=0;
        #5 clk2=1;
        #5 clk2=0;
     end
  end

initial
   begin
     for (k=0; k<31; k=k+1)
      mips.RegBank[k]=k;
    //Example 1 
//    mips.Mem[0] = 32'h2801000a;//ADDI R1,R0,10
//    mips.Mem[1] = 32'h28020014;//ADDI R2,R0,20 
//    mips.Mem[2] = 32'h28030019;//ADDI R3,R0,25
//    mips.Mem[3] = 32'h0ce77800;//OR R7,R7,R7
//    mips.Mem[4] = 32'h0ce77800;//OR R7,R7,R7
//    mips.Mem[5] = 32'h00222000;//ADD R4,R1,R2
//    mips.Mem[6] = 32'h0ce77800;//OR R7,R7,R7
//    mips.Mem[7] = 32'h00832800;//ADD R5,54,R3
//    mips.Mem[8] = 32'hfc000000;//HLT
    
    //Example 2
    mips.Mem[0] = 32'h28010078;//ADDI R1,R0,120
    mips.Mem[1] = 32'h0ce77800;//OR R7,R7,R7 DUMMY
    mips.Mem[2] = 32'h20220000;//LW R2,0(R1)
    mips.Mem[3] = 32'h0ce77800;//OR R7,R7,R7
    mips.Mem[4] = 32'h2842002d;//ADDI R2,R2,45
    mips.Mem[5] = 32'h0ce77800;//OR R7,R7,R7
    mips.Mem[6] = 32'h24220001;//SW R2,1(R1)
    mips.Mem[7] = 32'hfc000000;//HLT
    mips.Mem[120] = 85;
    
    mips.HALTED=0;
    mips.PC=0;
    mips.TAKEN_BRANCH=0;
    
//    #280 
//    for (k=0; k<6;k=k+1)
//     $display ("R%1d - %2d",k,mips.RegBank[k]);
     
     #500 // Example 2
     $display ("Mem[120]: %4d \nMem[121]: %4d",mips.Mem[120], mips.Mem[121]);
   end
    
//initial
//  begin
//    $dumpfile ("mips.vcd");
//    $dumpfile (0, test_mips32);
//    #300 $finish;
//  end
endmodule
