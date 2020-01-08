`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 03:55:32 PM
// Design Name: 
// Module Name: controller
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

module controller (
    input clk,rst,wr_en,rd,fifo_full,fifo_empty, fifo_threshold,
    input [3:0] rbit,
    output rptr_ld,fifo_rd,fifo_we,overflow_set, underflow_set
    );
    
    status_controller status(wr_en,
                             rd,
                             fifo_full,
                             fifo_empty,
                             overflow_set,
                             underflow_set);
    
    assign fifo_rd = (~fifo_empty) & rd;
    assign fifo_we = (~fifo_full) & wr_en;
    assign rptr_ld = (rbit[2:0]==3'b000) & fifo_rd;
    
endmodule


module status_controller(
    input wr_en,rd,fifo_full,fifo_empty,
    output overflow_set,underflow_set);
    
    assign overflow_set = fifo_full & wr_en;  
    assign underflow_set = fifo_empty&rd; 
endmodule

