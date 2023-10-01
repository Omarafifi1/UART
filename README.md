# UART
UART, or universal asynchronous receiver-transmitter, is one of the most used device-to-device communication protocols 
#RX
---------
rx checks the bit at its middle for higher stability 
there are three registers used: s , b , n
>>s is used as a counter to check the bit after a a certain amount of time which is (1/baud_rate) 
s counts 16 ticks and it increases by one when stick signal is set to high and it is high when the baud rate generator reaches the final value which is 650
and it is calculated depending on the value of the baud rate 


>>b is used to store the data comming to the receiver

>>n is used to count the number of data bits received


>>the signal rx done tick is set to high when the frame is completely received




TX
---------
there are thre registers used: s , b , n
>>s is used as a counter to check the bit after a a certain amount of time which is (1/baud_rate) 
s counts 16 ticks and it increases by one when stick signal is set to high and it is high when the baud rate generator reaches the final value which is 650
and it is calculated depending on the value of the baud rate 


>>b is used to store the data to be transmitted 

>>n is used to count the number of data bits  transmitted 


>>the signal tx done tick is set to high when the  frame is completely transmitted 


>>parity  is used to store the data to be transmitted to check its parity 
