module uart_rx #(parameter SB_TICK = 16,DBIT=8)(
input clk,rst_n,
input rx,
input s_tick,
output reg rx_done_tick,
output [DBIT-1:0]rx_dout
);
reg [2:0]current_state,next_state;
reg [3:0]s_reg,s_next;
reg [$clog2(DBIT)-1:0]n_reg,n_next;
reg [DBIT-1:0]b_reg,b_next;

//////////////////////////////////////////
////////    state_encoding   /////////////
//////////////////////////////////////////
localparam IDLE=0,
           START=1,
           DATA=2,
           PARITY=3,
           STOP=4;

//////////////////////////////////////////
////////    state_memory   ///////////////
//////////////////////////////////////////
always@(posedge clk,negedge rst_n)
begin
  if(!rst_n) begin
     current_state<=IDLE;
     s_reg<=0;
     n_reg<=0;
     b_reg<=0;
   end

  else begin
    current_state<=next_state;
    s_reg<=s_next;  
    n_reg<=n_next;  
    b_reg<=b_next;
  end
end
//////////////////////////////////////////
////////    next_state_logic     /////////
//////////////////////////////////////////


always@(*)
begin
            rx_done_tick=0;
            s_next=0;
            n_next=0;
            b_next=0;
            next_state=START;  
  case(current_state)
///////////////////////////////////      
////////    IDLE_state     ////////
///////////////////////////////////  
IDLE:begin
       if(!rx) begin
            s_next=0;
            n_next=0;
            b_next=0;
            next_state=START;
            end
      else
            next_state=IDLE;
end
/////////////////////////////////// 
////////    START_state    //////// 
///////////////////////////////////                   
START:begin
      if(s_tick)begin
           if(s_reg==7)begin
               s_next=0;
               next_state=DATA;
               end
             else begin
               next_state=START;
               s_next=s_reg+1;
             end
               end
      else 
         next_state=START;
               
end
///////////////////////////////////        
////////   DATA_state      ////////       
///////////////////////////////////        
DATA:begin
       if(s_tick)begin
           if(s_reg==15)begin
                s_next=0;
                b_next={rx,b_reg[DBIT-1:1]};
                    if(n_reg==DBIT-1)
                         next_state=PARITY;
                    else begin
                         n_next=n_reg+1; 
                         next_state=DATA;
                          end
                          end
            else begin
                  s_next=s_reg+1;
                  next_state=DATA;
                  end
                  end
     else
        next_state=DATA;
end

///////////////////////////////////        
////////   PARITY_state      //////// 
///////////////////////////////////        
PARITY:begin
      if(s_tick) begin
           if(s_reg==15) begin
               next_state=STOP; 
               s_next=0;
               end
           else begin
              s_next=s_reg+1;
              next_state=PARITY;
              end
              end
      else
        next_state=PARITY;
end


///////////////////////////////////        
////////   STOP_state      //////// 
///////////////////////////////////        
STOP:begin
      if(s_tick) begin
           if(s_reg==SB_TICK-1) begin
               rx_done_tick=1;
               next_state=IDLE; 
               end
           
           else begin
              s_next=s_reg+1;
              next_state=STOP;
              end
              end
      else
        next_state=STOP;
end
default:next_state=IDLE;
///////////////////////////////////  
///////////////////////////////////  
///////////////////////////////////  
  endcase
end

assign rx_dout=b_reg;
endmodule


