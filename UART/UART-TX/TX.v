////////////////////////////////////////
////////  uart_tx_block   /////////////
//////////////////////////////////////
module uart_tx #(parameter SB_TICK = 16,DBIT=8)(
input clk,rst_n,
input s_tick,tx_start,  // tx_start when turns high the uart start sending the start bit && s_tick is the done signal of the baud rate generator 
input [DBIT-1:0]tx_din,
output reg tx_done_tick,  // tx_done_tick goes high when the pattern of the uart (idle,start,data,stop bits)is completely transmitted
output reg tx
);
reg [2:0]current_state,next_state;
reg [3:0]current_s,next_s;       // s is an internal counter to check if i reached the baud rate or not 
reg [$clog2(DBIT)-1:0] current_n,next_n;      // n is an internal reg that counts the number of data bits that are transmitted
reg [DBIT-1:0]current_b,next_b;   // b is an internal reg that stores the data bits when they are written to the uart write_data port
reg [DBIT-1:0]current_parity,next_parity; // this reg stores the data bits to check the parity bit 
//////////////////////////////////////////
////////    state_encoding   /////////////
//////////////////////////////////////////
localparam IDLE=0,
           START=1,
           DATA=2,
           parity=3,
           STOP=4;
           

//////////////////////////////////////////
////////    state_memory   ///////////////
//////////////////////////////////////////
always@(posedge clk,negedge rst_n)
begin
  if(!rst_n) begin
    current_state<=IDLE;
    current_s<=0;
    current_n<=0;
    current_b<=0;
    current_parity<=0;
  end

   

  else begin
    current_state<=next_state;
    current_s<=next_s;
    current_n<=next_n;
    current_b<=next_b;
    current_parity<=next_parity;
    
  end
end
//////////////////////////////////////
///////    next_state_logic     //////
//////////////////////////////////////


always@(*)
begin
case(current_state)
IDLE:begin
       if(tx_start) 
            
            next_state=START;
            
       else
            next_state=IDLE;
       end


START:begin
      if((s_tick==1) && (current_s==15))
            next_state=DATA;
      else
            next_state=START;
            
      end


DATA:begin
       if((s_tick==1) && (current_s==15) && (current_n==7))
              next_state=parity;
       else
              next_state=DATA;
                    
       end

parity:begin
      if((s_tick==1) && (current_s==15)) 
          next_state=STOP; 
      else
          next_state=parity;
      end

       
STOP:begin
      if((s_tick==1) && (current_s==SB_TICK-1)) 
          next_state=IDLE; 
      else
          next_state=STOP;
      end

default:next_state=current_state;

endcase
end
///////////////////////////////////
////////    output_logic     //////
///////////////////////////////////


always@(*)
begin

  case(current_state)
IDLE:begin
  tx=1;
  tx_done_tick=0;
end

START:begin
  tx=0;
  tx_done_tick=0;
end


DATA:begin
  tx=current_b[0];
  tx_done_tick=0;
end

parity:begin
  tx_done_tick=0;
  if((^current_parity))   // even parity check 
  tx=1;  // this means we have odd number of ones 
  else
  tx=0;   // this means we have even number of ones 
end



STOP:begin
  tx=1;
   if((s_tick==1) && (current_s==SB_TICK-1)) 
     tx_done_tick=1;
   else
     tx_done_tick=0;
     
 end
 
endcase
end

///////////////////////////////////////////
////////    handling internal reg   ///////
///////////////////////////////////////////

always@(*)
begin
  
  case(current_state)
IDLE:begin
  next_s=0;
  next_n=0;
  next_b=0;
  next_parity=0;
end



START:begin
    if(s_tick)begin
          if((current_s==15)) begin
              next_s=0;
              next_b=tx_din;
              next_parity=tx_din;
              end
                
           else  
              next_s=current_s+1;
              end   
end


DATA:begin
      if(s_tick)begin
            if(current_s==15) begin
                next_s=0;
                next_b={1'b0,current_b[DBIT-1:1]};
                    if(current_n!=7)
                      next_n=current_n+1;
                      end
              else  
                next_s=current_s+1;
              end         
end

parity:begin
   if(s_tick)begin
        if((current_s==15)) begin
              next_s=0;
              end
        else  
           next_s=current_s+1;
        end         
end

STOP:begin
   if(s_tick)begin
        if((current_s==SB_TICK-1)) begin
              next_s=0;
              next_n=0;
              next_parity=0;
              end
        else  
           next_s=current_s+1;
        end         
end

default:begin
    next_s=current_s;
    next_n=current_n;
    next_b=current_b;
    next_parity=current_parity;
end

endcase
end
endmodule


