# UART
UART, or universal asynchronous receiver-transmitter, is one of the most used device-to-device communication protocols .

## RX


>>Register s is an internal register used as a counter to check the bit after a  certain amount of time which is (1/baud_rate) s counts 16 ticks and it increases by one when stick signal is set to high and it is set to high when the baud rate generator reaches the final value which is 650 and this value is calculated depending on the value of the baud rate .

>>Register b is an internal register used to store the data coming to the receiver.

>>Register n is an internal register used to count the number of data bits received.

>>the signal rx done tick is set to high when the frame is completely received.

>>The rx_dout signal holds the received data bits .

## TX


>>Register s is an internal register used as a counter to send the bit with a certain width of time which is (1/baud_rate),s counts 16 ticks and it increases by one when s_tick signal is set to high and it is set to high when the baud rate generator reaches the final value which is 650 and this value is calculated depending on the value of the baud rate. 

>>Register b is an internal register used to store the data to be transmitted .

>>Register n is an internal register used to count the number of data bits  transmitted.
## for more information check the pdf file

 >>the tx_done_tick  signal  is set to high when the  frame is completely transmitted including the stop bit.

>>Register parity is an internal register used to store the data to be transmitted to check its parity .
