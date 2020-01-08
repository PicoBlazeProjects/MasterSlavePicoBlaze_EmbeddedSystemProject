`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2020 02:07:11 PM
// Design Name: 
// Module Name: datapath
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


module datapath( 
    input clk,rst,rptr_ld,fifo_rd,fifo_we,overflow_set, underflow_set,
    input [7:0] data_in,
    output fifo_overflow, fifo_underflow,
    output [3:0] rbit,
    output fifo_full, fifo_empty, fifo_threshold, data_out);
    
    wire [4:0] rptr;
    wire [4:0] wptr;

    rptr_reg reg1(clk,
                  rst,
                  rptr_ld,
                  rptr);
                  
    rbit_reg reg2(clk,
                  rst,
                  fifo_rd,
                  rbit);
                  
    wptr_reg reg3(clk,
                  rst,
                  fifo_we,
                  wptr);

    memory_array_reg memory(data_out,
                            data_in,
                            clk,
                            fifo_we,
                            wptr,
                            rptr,
                            rbit);
    
    status_signal_datapath  status(clk,
                                   rst,
                                   overflow_set, 
                                   underflow_set,
                                   fifo_we, 
                                   fifo_rd,
                                   wptr, rptr,
                                   fifo_full, 
                                   fifo_empty, 
                                   fifo_threshold, 
                                   fifo_overflow, 
                                   fifo_underflow); 
endmodule



module rptr_reg(clk,rst,load,rptr);  
    input clk,rst,load;
    output reg [4:0] rptr;
        
    always @(posedge clk)  
    begin  
        if(rst) 
        begin
            rptr <= 5'b000000;
        end
        else if(load)  
        begin 
            rptr <= rptr + 5'b000001;  
        end
    end  
endmodule 

module rbit_reg(clk,rst,load,rbit);  

    input clk,rst,load;  
    output reg [3:0]rbit;  
        
    always @(posedge clk)  
    begin  
        if(rst) 
        begin
            rbit <= 4'b0111;
        end  
        else if(load)  
        begin 
            rbit <= rbit + 4'b1111;
        end
    end  
  
endmodule  


module wptr_reg(clk,rst,fifo_we,wptr);  

    input clk,rst,fifo_we;  
    output [4:0] wptr;  
    
    reg [4:0] wptr;  
    
    
    always @(posedge clk )  
    begin  
        if(rst) 
            wptr <= 5'b00000;  
        else if(fifo_we)  
            wptr <= wptr + 5'b00001;  
        else  
           wptr <= wptr;  
    end  
    
endmodule
 
 
module memory_array_reg(data_out,data_in,clk,load,wptr,rptr,rbit);  

    output data_out;  
    input[7:0] data_in;  
    input clk,load;  
    input[4:0] wptr,rptr;  
    input [3:0]rbit;
    
    reg[7:0] data_reg[15:0];  
    
    assign data_out = data_reg[rptr[3:0]][rbit[2:0]];
    
    always @(posedge clk)  
    begin  
        if(load)   
            data_reg[wptr[3:0]] <= data_in;  
    end
    
endmodule  


module status_signal_datapath(
    input clk,
          rst,
          overflow_set, 
          underflow_set,
          fifo_we, 
          fifo_rd,
           
    input [4:0] wptr, rptr,
      
    output reg fifo_full, 
               fifo_empty, 
               fifo_threshold, 
               fifo_overflow, 
               fifo_underflow);  
    
    
    wire fbit_comp, overflow_set, underflow_set;  
    wire pointer_equal;  
    wire [4:0] pointer_result;  
    
    assign fbit_comp = wptr[4] ^ rptr[4];  
    assign pointer_equal = (wptr[3:0] - rptr[3:0]) ? 0:1;  
    assign pointer_result = wptr[4:0] - rptr[4:0];  
    
    always @(*)  
    begin  
        fifo_full =fbit_comp & pointer_equal;  
        fifo_empty = (~fbit_comp) & pointer_equal;  
        fifo_threshold = (pointer_result[4]||pointer_result[3]) ? 1:0;  
    end  
    
    always @(posedge clk )  
    begin  
        if(rst) 
            fifo_overflow <=0;  
        else if((overflow_set==1)&&(fifo_rd==0))  
            fifo_overflow <=1;  
        else if(fifo_rd)  
            fifo_overflow <=0;  
        else  
            fifo_overflow <= fifo_overflow;  
    end  
        
    always @(posedge clk )  
    begin  
        if(rst) 
            fifo_underflow <=0;  
        else if((underflow_set==1)&&(fifo_we==0))  
            fifo_underflow <=1;  
        else if(fifo_we)  
            fifo_underflow <=0;  
        else  
            fifo_underflow <= fifo_underflow;  
    end  
    
 endmodule  