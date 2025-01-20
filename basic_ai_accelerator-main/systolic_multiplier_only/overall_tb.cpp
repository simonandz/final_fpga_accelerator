#include <iostream>
#include <iomanip>
#include <vector>
#include "ap_int.h"
using namespace std;

// Declare the top function for the test bench
// (Same signature as in the code above.)
void systolic_top_uart_4parallel(
    bool opcode_in0,
    bool opcode_in1,
    bool opcode_in2,
    bool opcode_in3,
    bool start_in,
    bool tx_in,
    bool clk_in,
    bool rst_in,

    bool &done_out,
    bool &busy_out,
    bool &rx_out,
    bool &out4,
    bool &out5,
    bool &out6,
    bool &out7,
    bool &out8
);

//----------------------------------
// Helper to send a byte via TX pin
//----------------------------------
static const unsigned BAUD_TICKS = 10; // match the design
void send_byte_to_dut(unsigned char b, vector<bool> &tx_sequence) {
    // 8N1 => Start bit=0, LSB first, Stop=1
    // We'll produce BAUD_TICKS bits for each bit
    // Start
    tx_sequence.push_back(false); // start bit
    for (int i=0; i<8; i++) {
        bool bit_val = ((b >> i) & 1) ? true : false;
        tx_sequence.push_back(bit_val);
    }
    tx_sequence.push_back(true); // stop bit
    // We also add some idle (stop) time after
    for (unsigned i=0; i<BAUD_TICKS; i++) {
        tx_sequence.push_back(true);
    }
}

int main() {
    // We will store signals in variables, then call the top function each "cycle"
    bool opcode_in0 = false, opcode_in1 = false, opcode_in2 = false, opcode_in3 = false;
    bool start_in   = false;
    bool tx_in      = true;  // idle line is high
    bool clk_in     = true;
    bool rst_in     = true;

    bool done_out   = false;
    bool busy_out   = false;
    bool rx_out     = true;
    bool out4       = false;
    bool out5       = false;
    bool out6       = false;
    bool out7       = false;
    bool out8       = false;

    // We'll define a helper function to "simulate clock cycles"
    auto tick = [&](int cycles=1) {
        for (int c=0; c<cycles; c++) {
            systolic_top_uart_4parallel(
                opcode_in0, opcode_in1, opcode_in2, opcode_in3,
                start_in, tx_in, clk_in, rst_in,
                done_out, busy_out, rx_out, out4, out5, out6, out7, out8
            );
        }
    };

    //-----------------------------------------
    // 1) Reset
    //-----------------------------------------
    tick(10);  // while rst_in= true => design resets
    rst_in = false;
    tick(10);

    //-----------------------------------------
    // Prepare data for A, B
    // We'll pick a small pattern:
    // A = [1,2,3,4,5,6,7,8,9]
    // B = [1,1,1,1,1,1,1,1,1], just for a quick test
    //-----------------------------------------
    vector<unsigned char> to_send;
    // 9 bytes for A
    unsigned char Avals[9] = {1,2,3,4,5,6,7,8,9};
    for (int i=0; i<9; i++) {
        to_send.push_back(Avals[i]);
    }
    // 9 bytes for B
    unsigned char Bvals[9] = {1,1,1,1,1,1,1,1,1};
    for (int i=0; i<9; i++) {
        to_send.push_back(Bvals[i]);
    }

    // We'll pick an opcode for "Matrix Multiply" = 0x1 => 0001
    // Then we rely on the hardware to read that after Start
    opcode_in0 = true;  // LSB
    opcode_in1 = false;
    opcode_in2 = false;
    opcode_in3 = false; // MSB => 0001
    tick(1);

    // We'll gather the bits in a big boolean vector, to feed them cycle by cycle
    vector<bool> tx_bits;
    for (auto b : to_send) {
        send_byte_to_dut(b, tx_bits);
    }

    // Because the design uses an internal FSM that waits for "start_in" first,
    // we won't actually feed these bits in until after we set start_in=1.

    // 2) Set start
    start_in = true;
    tick(1);
    start_in = false;

    // 3) Now feed the TX bits, one bit per cycle
    //    Each bit remains stable for BAUD_TICKS cycles
    //    But we already included that in send_byte_to_dut
    //    so we only shift once per "bit" in the vector
    //    (We've effectively combined them, to keep it simpler.)
    for (bool bit_val : tx_bits) {
        tx_in = bit_val;
        tick(1);
    }

    // Wait for the design to run
    // The design will eventually send 9 bytes out on rx_out
    // We'll sample rx_out each cycle (like a soft UART on the TB side).
    vector<bool> rx_capt; // store raw line states
    int cycles_wait = 2000; // big enough
    for (int i=0; i<cycles_wait; i++) {
        tick(1);
        rx_capt.push_back(rx_out);
        if (done_out) {
            // once done is high, we break
            break;
        }
    }

    // Now parse rx_capt as a UART input. We'll look for start bits, etc.
    // same approach as in "send_byte_to_dut" but in reverse
    vector<unsigned char> received_bytes;
    unsigned idx = 0;
    while (idx + 10 < rx_capt.size()) {
        // look for start bit = 0
        if (rx_capt[idx] == false) {
            // read next 8 bits + 1 stop
            unsigned char acc = 0;
            for (int i=0; i<8; i++) {
                bool bit_val = rx_capt[idx+1+i];
                acc |= (bit_val ? 1<<i : 0);
            }
            received_bytes.push_back(acc);
            // skip stop bit
            idx += 10; 
        } else {
            idx++;
        }
    }

    // Print results
    cout << "Received " << received_bytes.size() << " bytes from the design:\n";
    for (auto b : received_bytes) {
        cout << (int)b << " ";
    }
    cout << endl;

    // Done
    return 0;
}
