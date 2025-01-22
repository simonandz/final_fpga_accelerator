`timescale 1ns/1ps

module tb_systolic_top_uart_4parallel_q8_24;

//-------------------------------------
// Testbench signals
//-------------------------------------
reg        opcode_in0;
reg        opcode_in1;
reg        opcode_in2;
reg        opcode_in3;
reg        start_in;
reg        tx_in;
reg        clk_in;
reg        rst_in;

wire       done_out;
wire       busy_out;
wire       rx_out;
wire       out4, out5, out6, out7, out8;

//-------------------------------------
// Instantiate the DUT
//-------------------------------------
systolic_top_uart_4parallel_q8_24 dut (
    .opcode_in0(opcode_in0),
    .opcode_in1(opcode_in1),
    .opcode_in2(opcode_in2),
    .opcode_in3(opcode_in3),
    .start_in(start_in),
    .tx_in(tx_in),
    .clk_in(clk_in),
    .rst_in(rst_in),
    .done_out(done_out),
    .busy_out(busy_out),
    .rx_out(rx_out),
    .out4(out4),
    .out5(out5),
    .out6(out6),
    .out7(out7),
    .out8(out8)
);

//-------------------------------------
// Clock generation
//-------------------------------------
localparam CLK_PERIOD = 10;  // 10 ns -> 100 MHz
always begin
    #(CLK_PERIOD/2) clk_in = ~clk_in;
end

//-------------------------------------
// UART send task
// - Because BAUD_TICKS=10 in the DUT,
//   and our clock is every 10 ns, we
//   must hold each UART bit for 10
//   clock cycles = 100 ns total.
//
//   So to send 1 bit, we do # (BAUD_TICKS * CLK_PERIOD) = 100 ns
//-------------------------------------
task send_uart_byte;
    input [7:0] data;
    integer i;
begin
    // Start bit (low)
    tx_in = 1'b0;
    #(10 * CLK_PERIOD);

    // Send 8 data bits (LSB first)
    for (i = 0; i < 8; i = i + 1) begin
        tx_in = data[i];
        #(10 * CLK_PERIOD);
    end

    // Stop bit (high)
    tx_in = 1'b1;
    #(10 * CLK_PERIOD);
end
endtask

//-------------------------------------
// Test stimulus
//-------------------------------------
integer i;

initial begin
    // Initialize signals
    clk_in     = 1'b0;
    rst_in     = 1'b0;
    tx_in      = 1'b1; // idle high
    start_in   = 1'b0;
    opcode_in0 = 1'b0;
    opcode_in1 = 1'b0;
    opcode_in2 = 1'b0;
    opcode_in3 = 1'b0;

    // Step 1: Assert reset
    $display("Applying reset...");
    rst_in = 1'b1;
    #(5*CLK_PERIOD);
    rst_in = 1'b0;
    #(5*CLK_PERIOD);

    // Step 2: Set up an opcode (example: 0x01 => multiplication & then no activation)
    //  opcode = {4'b0000, opcode_in3, opcode_in2, opcode_in1, opcode_in0} = 8'h01
    opcode_in0 = 1'b1;   // LSB
    opcode_in1 = 1'b0;
    opcode_in2 = 1'b0;
    opcode_in3 = 1'b0;   // MSB => overall opcode = 0x1

    // Step 3: Pulse start_in
    $display("Pulsing start_in...");
    start_in = 1'b1;
    #(CLK_PERIOD);
    start_in = 1'b0;

    // Step 4: Transmit 36 bytes for A data.
    $display("Sending 36 bytes for A_data_packed...");
    for (i = 0; i < 36; i = i + 1) begin
        // Example: send i or any pattern you like
        send_uart_byte(i[7:0]);
    end

    // Step 5: Transmit 36 bytes for B data.
    $display("Sending 36 bytes for B_data_packed...");
    for (i = 0; i < 36; i = i + 1) begin
        // Another pattern for B
        send_uart_byte((i + 8'h80)[7:0]); 
    end

    // Now the FSM_RUN state will compute.
    // Wait for done_out
    wait(done_out == 1'b1);
    #(2*CLK_PERIOD);

    $display("done_out asserted, computation finished.");
    $display("Simulation completed.");
    $finish;
end

endmodule
