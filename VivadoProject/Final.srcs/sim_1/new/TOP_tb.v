`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2019 03:19:32 AM
// Design Name: 
// Module Name: TOP_tb
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


module TOP_tb;
    reg clock,reset,interrupt;
    TOP uut(clock,reset);
    initial
    begin
        interrupt<=0;
        reset<=0;
    end
    
    always
    begin
        clock<=0;
        #5;
        clock<=1;
        #5;
    end
    initial
    begin
        reset<=1;
        #100;
        reset<=0;
    end
endmodule
