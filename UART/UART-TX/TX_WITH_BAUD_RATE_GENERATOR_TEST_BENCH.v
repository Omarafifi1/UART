`timescale 1ns/1ps
////////////////////////////////////////
////////  FINAL_UART_TX_TEST_BENCH ////
//////////////////////////////////////
module uart_tx_with_baud_rate_gen_tb;
parameter width=10,DBIT=8;

reg clk,rst_n;
reg [width-1:0]final_value;
reg [DBIT-1:0]tx_din;
reg tx_start;
reg enablee;
wire tx;
wire tx_done_tick;          


uart_tx_with_baud_rate_generator #(.width(width),.DBIT(DBIT)) dut (
.clk(clk),
.rst_n(rst_n),            
.final_value(final_value),
.tx_din(tx_din),       
.tx_start(tx_start),              
.enablee(enablee),                
.tx(tx),                   
.tx_done_tick(tx_done_tick)              
);

localparam T=10;
always
begin
  clk=0;
  #(T/2);
  clk=1;
  #(T/2);
end

initial 
begin
  rst_n=0;
  #5
  rst_n=1;
end
 
initial 
begin
  tx_start=0;
  #10
  tx_start=1;
end


initial 
begin
enablee=1;
final_value=650;           
tx_din=8'b1000_1101;
end 

  
endmodule






