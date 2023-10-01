module baud_rate_generator #(parameter width=10)(   
input rst_n,
input clk,
input enable,
input [width-1:0]final_value,
output done 
); 
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


