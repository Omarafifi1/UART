//////////////////////////////////////////////////////////////////
////////  handling the baud rate using mod counter   ////////////
////////////////////////////////////////////////////////////////
module baud_rate_generator #(parameter width=10)(   
input rst_n,
input clk,
input enable,
input [width-1:0]final_value,  // final value will be calculated depending on the baud rate using the formula: 1/(baud_rate*16*T_clk  )-1
output done                    // what i do here is that i divided the baud rate region into 16 sections each section goes from zero to final value by this counter and the signal
 );                            //done goes high 16 times within a single baud rate region  
reg [width-1:0]counter;
assign done=(counter==final_value);
always@(posedge clk,negedge rst_n)
begin
  if(!rst_n)
    counter<=0;
  else if(enable)
    counter<=done?0:(counter+1);
    else
      counter<=0;
end
endmodule

