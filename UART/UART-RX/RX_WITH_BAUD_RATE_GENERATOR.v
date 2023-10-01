module uart_rx_with_baud_rate #(parameter width=10,DBIT=8)(
input clk,rst_n,
input [width-1:0]final_value,
input rx,
input enablee,
output rx_done_tick,
output [DBIT-1:0]rx_dout
);
 wire s_tick_done;
 baud_rate_generator uut0(
.rst_n(rst_n),                 
.clk(clk),                   
.enable(enablee),                
.final_value(final_value),
.done(s_tick_done)                  
);

 uart_rx uut1(
.clk(clk),
.rst_n(rst_n),         
.rx(rx),                
.s_tick(s_tick_done),            
.rx_done_tick(rx_done_tick), 
.rx_dout(rx_dout)
);
endmodule


