`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2020 06:28:06 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input wr, rd, clk, rst,
    input [7:0] data_in,  
    output data_out,  
           fifo_full, 
           fifo_empty, 
           fifo_threshold, 
           fifo_overflow, 
           fifo_underflow  
    );
    
    wire [4:0] wptr, rptr;
    wire [3:0] rbit;
    wire rptr_ld,fifo_rd,fifo_we,overflow_set, underflow_set;
    
    controller uut1(clk,
                    rst,
                    wr, 
                    rd,
                    fifo_full,
                    fifo_empty, 
                    fifo_threshold,
                    rbit,
                    rptr_ld,
                    fifo_rd,
                    fifo_we,
                    overflow_set, 
                    underflow_set);
                    
                    
    datapath uut2(clk,
                  rst,
                  rptr_ld,
                  fifo_rd,
                  fifo_we,
                  overflow_set, 
                  underflow_set,
                  data_in,  
                  fifo_overflow, 
                  fifo_underflow,   
                  rbit,
                  fifo_full, 
                  fifo_empty, 
                  fifo_threshold, 
                  data_out);            
  
endmodule
