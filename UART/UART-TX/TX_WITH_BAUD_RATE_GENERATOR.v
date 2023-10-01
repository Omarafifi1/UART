////////////////////////////////////////////////////////////////////////////////////////////////
////////    instinitiating the tx block with the baud rate generator                  /////////
//////////////////////////////////////////////////////////////////////////////////////////////
module uart_tx_with_baud_rate_generator #(parameter width=10,DBIT=8)(
input clk,rst_n,
input [width-1:0]final_value,
input [DBIT-1:0]tx_din,
input tx_start,
input enablee,
output tx,
output tx_done_tick
);

wire s_tick_done;

uart_tx uut0 (
.clk(clk),
.rst_n(rst_n),
.s_tick(s_tick_done),
.tx_start(tx_start),
.tx_done_tick(tx_done_tick),
.tx_din(tx_din),        
.tx(tx) 
);



baud_rate_generator uut1 (
.rst_n(rst_n),                 
.clk(clk),                   
.enable(enablee),                
.final_value(final_value),
.done(s_tick_done)                
);


 


endmodule



