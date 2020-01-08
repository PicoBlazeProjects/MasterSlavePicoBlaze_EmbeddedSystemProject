`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2019 02:40:04 AM
// Design Name: 
// Module Name: TOP
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


module TOP(
    input clock,reset
    );
    
    //////////////////////MASTER PICOBLAZE//////////////////////////////////
    wire [17:0] instruction_master;
    
    wire [7:0] in_port_master,
               out_port_master,
               port_id_master;
              
    wire [11:0] address_master;
    
    wire bram_enable_master, 
         write_strobe_master,
         k_write_strobe_master, 
         read_strobe_master,
         interrupt_master, 
         interrupt_ack_master;
    
    Master_BRAM MBRAM(.address(address_master), 
                      .instruction(instruction_master),
                      .enable(bram_enable_master), 
                      .clk(clock));
                       
    kcpsm6 master(.address(address_master), 
                  .instruction(instruction_master),
                  .bram_enable(bram_enable_master), 
                  .in_port(in_port_master),
                  .out_port(out_port_master), 
                  .port_id(port_id_master),
                  .write_strobe(write_strobe_master), 
                  .k_write_strobe(k_write_strobe_master),
                  .read_strobe(read_strobe_master), 
                  .interrupt(interrupt_master), 
                  .interrupt_ack(interrupt_ack_master),
                  .sleep(1'b0), 
                  .reset(reset), 
                  .clk(clock));
                  
     
     
                 
    //////////////////////GENERATED BLOCK RAM//////////////////////////////////
    wire [5:0]ram_addr;
    wire bram_en=port_id_master[7]&port_id_master[6];
    assign ram_addr=bram_en?port_id_master[5:0]:0;
    
    blk_mem_gen_0 BRAM(.clka(clock), 
                       .ena(bram_en), 
                       .wea(1'b0), 
                       .addra(ram_addr), 
                       .dina(8'bZ), 
                       .douta(in_port_master));
    
    wire [17:0] instruction_slave;
    
    wire [7:0] in_port_slave,
               out_port_slave,
               port_id_slave;
              
    wire [11:0] address_slave;
    
    wire bram_enable_slave, 
         write_strobe_slave,
         k_write_strobe_slave, 
         read_strobe_slave,
         interrupt_slave,
         interrupt_ack_slave;
    
    
    //////////////////////SLAVE PICOBLAZE//////////////////////////////////
    Slave_BRAM SBRAM(.address(address_slave), 
                     .instruction(instruction_slave),
                     .enable(bram_enable_slave), 
                     .clk(clock));
                       
    kcpsm6 slave(.address(address_slave), 
                 .instruction(instruction_slave),
                 .bram_enable(bram_enable_slave), 
                 .in_port(in_port_slave),
                 .out_port(out_port_slave), 
                 .port_id(port_id_slave),
                 .write_strobe(write_strobe_slave), 
                 .k_write_strobe(k_write_strobe_slave),
                 .read_strobe(read_strobe_slave), 
                 .interrupt(interrupt_slave), 
                 .interrupt_ack(interrupt_ack_slave),
                 .sleep(1'b0), 
                 .reset(reset), 
                 .clk(clock));
    
        
    //////////////////////FIFO//////////////////////////////////
    wire [7:0] data_in;  
    assign data_in=out_port_master;
    wire data_out, 
         fifo_full, 
         fifo_empty, 
         fifo_threshold, 
         fifo_overflow, 
         fifo_underflow;
    
    assign in_port_slave={7'd0,data_out};
    
    fifo FIFO(write_strobe_master, 
              read_strobe_slave, 
              clock, 
              reset,
              data_in,  
              data_out,  
              fifo_full, 
              fifo_empty, 
              fifo_threshold, 
              fifo_overflow, 
              fifo_underflow  
    );

    
    assign interrupt_master=fifo_full;
    assign interrupt_slave=fifo_empty;
    
endmodule
