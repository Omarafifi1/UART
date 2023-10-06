# UART
UART, or universal asynchronous receiver-transmitter, is one of the most used device-to-device communication protocols 

RX
---------

Register s is an internal register used as a counter to check the bit after a  certain amount of time which is (1/baud_rate) s counts 16 ticks and it increases by one when stick signal is set to high and it is set to high when the baud rate generator reaches the final value which is 650 and this value is calculated depending on the value of the baud rate .

Register b is an internal register used to store the data coming to the receiver.

Register n is an internal register used to count the number of data bits received.

the signal rx done tick is set to high when the frame is completely received.

The rx_dout signal holds the received data bits .
![image](https://github.com/Omarafifi1/UART/assets/106562602/6a5725ad-0fbe-4bb7-9133-a457d25f6647)




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
