`timescale 1ns/1ps
module uart_rx_with_baud_rate_tb;
parameter width=10,DBIT=8 ;
reg clk,rst_n;
reg [width-1:0]final_value;
reg rx;
reg enablee;
wire rx_done_tick;
wire [DBIT-1:0]rx_dout;

uart_rx_with_baud_rate dut(
.clk(clk),
.rst_n(rst_n),
.final_value(final_value),
.rx(rx),                    
.enablee(enablee),               
.rx_done_tick(rx_done_tick),         
.rx_dout(rx_dout)     
);


localparam T=10,
           baud_rate= 9600;
always
begin
  clk=0;
  #(T/2);
  clk=1;
  #(T/2);
end



initial
begin
  final_value=650;
  enablee=1;

  rst_n=0;
  #2;
  rst_n=1;
end


initial
begin
///idle_bit////
 rx=1;
 #10;
///start_bit////
rx=0;
#(( 10 ** (9) )/(baud_rate));
///data_bits////
rx=1;
#(( 10 ** (9) )/(baud_rate));
rx=0;
#(( 10 ** (9) )/(baud_rate));
rx=1;
#(( 10 ** (9) )/(baud_rate));
rx=0;
#(( 10 ** (9) )/(baud_rate));
rx=0;
#(( 10 ** (9) )/(baud_rate));
rx=1;
#(( 10 ** (9) )/(baud_rate));
rx=1;
#(( 10 ** (9) )/(baud_rate));
rx=0;
#(( 10 ** (9) )/(baud_rate));
///parity_bit////
rx=0; 
#(( 10 ** (9) )/(baud_rate));
///stop_bit////
rx=1; 
#(( 10 ** (9) )/(baud_rate));
$stop;
end

endmodule


