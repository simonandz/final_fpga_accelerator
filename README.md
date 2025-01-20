In Pins	
1	Op-Code
2	Op-Code
3	Op-Code
4	Op-Code
5	Start
6	TX
7	Clk
8	Reset
	
Out Pins	
1	Done
2	Busy
3	RX
4	
5	
6	
7	
8	




Op-Codes	
0000	No-op
0001	4 Parallel 3x3 Systolic Matrix Multiplier Dot Product
0010	RELU
0011	Leaky RELU
0100	Softmax
1010	Sigmond
1100	No-op
1110	No-op
1000	No-op
1001	No-op
1010	No-op
1011	No-op
1100	No-op
1101	No-op
1110	No-op
1111	No-op



Op-Code Description:
0001: Does the 4 parallel matrix opertaions. Each systolic matrix multiplier handles multiplying 2 fixed 3x3 matricies. Each number in the 3x3 matrix is a 32 point bit Q8.24 fixed point.
0010: Applies Relu after matrix operation.
0011:	Applies leaky relu after matrix operation.
0100: Applies softmax after matrix operation.
1010: Applies sigmoid after matrix operation.


Baud-Rate: 100 mbps 


Steps to Load Memory into U-ART
Waiting for Data (Idle State):
Initially, the FSM is in the idle state. When the external start signal (start_in) is asserted, the FSM transitions to the first loading phase.

Loading Matrix A Data (FSM_LOAD_A):

The UART receiver continually monitors the UART receive pin and, when it detects a complete 8‑bit byte (after processing the start bit, data bits, and stop bit), it asserts a valid flag (for example, setting rx_valid high) and provides the received byte in a register (e.g. rx_data).
A counter (load_count) is used to index the 32‑bit words within the A matrix memory array. Although data are received as 8‑bit values, they get sign‑extended (or zero‑extended, as needed) to form 32‑bit words.
Each received 8‑bit value is inserted into the proper slice of the A data memory array (named here A_data_packed) at the location:
A_data_packed[load_count*32 +: 32] = { {24{rx_data[7]}}, rx_data };
This operation ensures that the 8‑bit value is converted into a 32‑bit signed representation.
This continues until 36 words have been loaded into A_data_packed (which corresponds to four 3×3 matrices, since 9×4=36).
Loading Matrix B Data (FSM_LOAD_B):

After A_data_packed is completely filled, the FSM resets load_count to zero and transitions to the FSM_LOAD_B state.
The same procedure is repeated for the B matrix. Now, each received byte (again sign‑extended to 32‑bits) is stored into B_data_packed at the location:
B_data_packed[load_count*32 +: 32] = { {24{rx_data[7]}}, rx_data };
Again, 36 words are loaded (36 bytes, each expanded to 32 bits) to fill B_data_packed.
Data Packing After Load:

Once both A_data_packed and B_data_packed contain the full set of 36 words, an always-combinational block repacks these 36 words into four contiguous 288‑bit blocks. Each block represents one 3×3 matrix:
A_blk_packed[i*288 +: 288] = A_data_packed[i*9*32 +: 9*32];
B_blk_packed[i*288 +: 288] = B_data_packed[i*9*32 +: 9*32];



Steps to Unload Memory From U-ARt
Results Are Stored in Packed Memory:
After the systolic arrays finish their processing (in the FSM_RUN and FSM_SEND_C phases), the four 288‑bit blocks containing the computed results are stored in C_blk_packed. This 1152‑bit value represents 36 words (each 32 bits), corresponding to the outputs of the four 3×3 systolic arrays.

Unpacking the Results:
Like the packing process, an always‑comb block or a dedicated process (not fully shown in the code) would unpack the 1152‑bit C_blk_packed into 36 separate 32‑bit words. Each 32‑bit word could then be broken down further (if necessary) into 8‑bit chunks for serial transmission via UART.

Transmitting the Data via UART TX Task:
A separate FSM or transmit task would iterate over these 36 words. For each 32‑bit word, the design could either:

Transmit the entire 32‑bit word as four 8‑bit bytes (for example, sending the high byte first) or
Truncate/convert the 32‑bit value (if the application permits) to an 8‑bit value before transmission.
The process would work as follows:

A counter (similar to load_count) would be used to index the output words.
For each word, the appropriate 8‑bit slice is selected.
The UART TX task is then called with the 8‑bit data. The task serializes this byte (adding start/stop bits) and shifts it out on the UART TX line.
This loop repeats until all 36 words (or the appropriate number of bytes) have been transmitted.
State Transition:
In the provided code, the FSM transitions to FSM_SEND_C after all systolic arrays finish processing. At that point, it sets internal_done and returns to idle. In a complete design, you might have additional logic in FSM_SEND_C (or in a subsequent state) that:

Iterates through each word of the computed result,
Loads the word into a transmit register,
And calls the UART TX task repeatedly until the entire result is unloaded.
