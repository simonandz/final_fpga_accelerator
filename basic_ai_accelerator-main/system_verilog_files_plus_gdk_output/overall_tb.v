`timescale 1ns/1ps

module tb_systolic_top_uart_4parallel_q8_24;

    // --------------------------------------------------------------------
    // DUT I/O
    // --------------------------------------------------------------------
    logic opcode_in0;
    logic opcode_in1;
    logic opcode_in2;
    logic opcode_in3;
    logic start_in;
    logic tx_in;      // We drive this as a "fake RX" from the test bench side
    logic clk_in;
    logic rst_in;

    logic done_out;
    logic busy_out;
    logic rx_out;     // DUT TX pin (we can sample this to see the output data)
    logic out4;
    logic out5;
    logic out6;
    logic out7;
    logic out8;

    // --------------------------------------------------------------------
    // Instantiate the DUT
    // --------------------------------------------------------------------
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

    // --------------------------------------------------------------------
    // Clock Generation
    // --------------------------------------------------------------------
    initial begin
        clk_in = 1'b0;
        forever #5 clk_in = ~clk_in;  // 10 ns period => 100 MHz clock
    end

    // --------------------------------------------------------------------
    // Reset / Initial Setup
    // --------------------------------------------------------------------
    initial begin
        // Default inputs
        rst_in    = 1'b1;    // assert reset
        start_in  = 1'b0;
        tx_in     = 1'b1;    // idle line for UART is high
        opcode_in0= 1'b0;
        opcode_in1= 1'b0;
        opcode_in2= 1'b0;
        opcode_in3= 1'b0;    // => opcode = 0x00 initially

        // Deassert reset after 100 ns
        #100 rst_in = 1'b0;

        // Wait some time
        #50;

        // Example: set opcode to 0x01 => 3x3 multiply
        // Bits = (opcode_in3, opcode_in2, opcode_in1, opcode_in0) => (0,0,0,1)
        opcode_in0 = 1'b1; // => 0x01
        opcode_in1 = 1'b0;
        opcode_in2 = 1'b0;
        opcode_in3 = 1'b0;

        // Now, pulse start_in for one clock to move from FSM_IDLE to FSM_LOAD_A
        @(posedge clk_in);
        start_in = 1'b1;
        @(posedge clk_in);
        start_in = 1'b0;
    end

    // --------------------------------------------------------------------
    // We match BAUD_TICKS = 10 in the DUT => each "bit" = 10 clock cycles
    // => at 10 ns clock period, each bit = 100 ns
    // We'll define a task to "send" a byte on tx_in with 8N1 format
    // --------------------------------------------------------------------
    localparam BAUD_TICKS = 10;

    task automatic send_byte(input [7:0] data);
        integer i;
        begin
            // Start bit = 0
            tx_in = 1'b0;
            // Wait 10 clock cycles
            repeat (BAUD_TICKS) @(posedge clk_in);

            // 8 data bits (LSB first)
            for (i=0; i<8; i=i+1) begin
                tx_in = data[i];
                repeat (BAUD_TICKS) @(posedge clk_in);
            end

            // Stop bit = 1
            tx_in = 1'b1;
            repeat (BAUD_TICKS) @(posedge clk_in);
        end
    endtask

    // --------------------------------------------------------------------
    // Optionally, we can also RECV bytes from DUT’s rx_out
    // This requires sampling rx_out in mid-bit. We'll do a simple approach:
    // Wait for start bit, sample data bits, etc. (like a minimal UART).
    // If you only want to see the waveforms in simulation, you can skip it.
    // --------------------------------------------------------------------
    function automatic [7:0] recv_byte();
        reg [7:0] tmp;
        integer i;
        begin
            // Wait for line to go LOW => start bit
            wait (rx_out == 1'b0);
            // Wait half a bit
            repeat (BAUD_TICKS/2) @(posedge clk_in);

            // Now sample bits
            for (i=0; i<8; i=i+1) begin
                tmp[i] = rx_out;
                // Wait one bit time
                repeat (BAUD_TICKS) @(posedge clk_in);
            end

            // Stop bit => line should go high
            // Wait one bit time for the stop bit
            repeat (BAUD_TICKS) @(posedge clk_in);

            return tmp;
        end
    endfunction

    // --------------------------------------------------------------------
    // Main Test Sequence
    // --------------------------------------------------------------------
    initial begin
        // Wait until reset is deasserted
        @(negedge rst_in);

        // Wait until FSM_LOAD_A is reached
        // The FSM needs 36 bytes for A
        $display("[TB] Sending 36 bytes for A ...");
        for (int k = 0; k < 36; k++) begin
            // Example pattern => 0,1,2,...,35
            send_byte(k[7:0]);
        end

        // Now 36 bytes for B
        $display("[TB] Sending 36 bytes for B ...");
        for (int k = 0; k < 36; k++) begin
            // Example pattern => ~k
            send_byte(~k[7:0]);
        end

        // Wait for done_out
        $display("[TB] Waiting for done_out ...");
        wait (done_out == 1'b1);
        $display("[TB] done_out=1 => reading results from rx_out ...");

        // Let's read the 36 bytes from rx_out
        // We know the FSM will transmit 36 bytes in sequence
        for (int i=0; i<36; i++) begin
            logic [7:0] rcv;
            rcv = recv_byte();
            $display("[TB] Received byte %0d => %0d (signed)", i, $signed(rcv));
        end

        // Done
        #200;
        $display("[TB] Simulation complete.");
        $finish;
    end

endmodule
