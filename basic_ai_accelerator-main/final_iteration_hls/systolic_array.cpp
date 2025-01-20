#include <ap_int.h>
#include <hls_stream.h>
#include <iostream>
#include <cmath>

//---------------------------------------------------------------------
// Debug macro: prints only in simulation (not synthesized into hardware)
#ifndef __SYNTHESIS__
  #define DEBUG_PRINT(msg) (std::cout << msg << std::endl)
#else
  #define DEBUG_PRINT(msg) /* no-op */
#endif

//---------------------------------------------------------------------
// Fixed-Point Types
//---------------------------------------------------------------------
typedef ap_fixed<32, 8>  data_t;   // Q8.24
typedef ap_fixed<32, 12> acc_t;    // Q12.20
typedef unsigned char    opcode_t;

static const int N = 3;
static const int NUM_ARRAYS = 4;  // <<-- 4 in parallel
static const acc_t LR = (acc_t)0.01;

//---------------------------------------------------------------------
// Activation / Utility
//---------------------------------------------------------------------
static acc_t relu(acc_t x) {
    return (x > (acc_t)0) ? x : (acc_t)0;
}

acc_t leaky_relu(acc_t x) {
    // Ensure 'alpha' is the same type as 'x'
    acc_t alpha = (acc_t)0.1;

    if (x > (acc_t)0) {
        return x;
    } else {
        return x * alpha;
    }
}

static acc_t sigmoid(acc_t x) {
    double xd = (double)x;
    double ret = 1.0 / (1.0 + std::exp(-xd));
    return (acc_t)ret;
}

// For Softmax
static acc_t exp_fixed(acc_t x) {
    if (x > (acc_t)6.0)  x = (acc_t)6.0;
    if (x < (acc_t)-6.0) x = (acc_t)-6.0;
    acc_t one=(acc_t)1.0, two=(acc_t)2.0, six=(acc_t)6.0, twelve=(acc_t)12.0;
    acc_t r = one + x + (x*x)/two + (x*x*x)/six + (x*x*x*x)/twelve;
    if (r < (acc_t)0) return (acc_t)0;
    return r;
}

static void softmax(acc_t arr[N*N]) {
    acc_t sum_val = 0;
    for (int i = 0; i < N*N; i++) {
        acc_t e = exp_fixed(arr[i]);
        arr[i] = e;
        sum_val += e;
    }
    if (sum_val > 0) {
        for (int i = 0; i < N*N; i++) {
            arr[i] = arr[i] / sum_val;
        }
    }
}

//---------------------------------------------------------------------
// Systolic State
//---------------------------------------------------------------------
enum state_enum { IDLE, CALC, FINISH };

struct systolic_state_t {
    state_enum state;
    int k;
    bool busy;
    acc_t partial_sum[N*N];
};

//---------------------------------------------------------------------
// Single 3x3 Systolic Array
//---------------------------------------------------------------------
static void systolic_array(
    bool  rst,
    bool  start,
    data_t A[N*N],
    data_t B[N*N],
    acc_t C[N*N],
    bool &done,
    systolic_state_t &state,
    opcode_t opcode
) {
#pragma HLS PIPELINE II=1

    if (rst) {
        state.state = IDLE;
        state.k = 0;
        state.busy = false;
        done = false;
        for (int i=0; i<N*N; i++) {
#pragma HLS UNROLL
            state.partial_sum[i] = 0;
            C[i] = 0;
        }
        return;
    }

    switch (state.state) {
    case IDLE:
        done = false;
        if (start && !state.busy) {
            state.busy = true;
            DEBUG_PRINT("[sys_array] Start, opcode=0x" << std::hex << (int)opcode << std::dec);
            if (opcode == 0x1) { // 3x3 multiply
                state.state = CALC;
                state.k = 0;
                for (int i=0; i<N*N; i++) {
#pragma HLS UNROLL
                    state.partial_sum[i] = 0;
                }
            } else {
                // skip multiply, go to FINISH
                state.state = FINISH;
            }
        }
        break;

    case CALC:
        // Accumulate partial sums
        if (state.k < N) {
            DEBUG_PRINT("[sys_array] CALC, k=" << state.k);
            for (int i=0; i<N; i++) {
#pragma HLS UNROLL
                for (int j=0; j<N; j++) {
#pragma HLS UNROLL
                    state.partial_sum[i*N + j] +=
                        (acc_t)A[i*N + state.k] * (acc_t)B[state.k*N + j];
                }
            }
            state.k++;
            if (state.k == N) {
                state.state = FINISH;
            }
        }
        break;

    case FINISH:
        DEBUG_PRINT("[sys_array] FINISH opcode=0x" << std::hex << (int)opcode << std::dec);
        // Copy partial_sum
        for (int i=0; i<N*N; i++) {
#pragma HLS UNROLL
            C[i] = state.partial_sum[i];
        }
        // Apply opcode
        switch(opcode) {
        case 0x0: // No-Op
            break;
        case 0x1: // Multiply done
            break;
        case 0x2: // ReLU
            for (int i=0; i< N*N; i++) {
#pragma HLS UNROLL
                C[i] = relu(C[i]);
            }
            break;
        case 0x3: // Leaky ReLU
            for (int i=0; i< N*N; i++) {
#pragma HLS UNROLL
                C[i] = leaky_relu(C[i]);
            }
            break;
        case 0x4: // Softmax
            softmax(C);
            break;
        case 0x8: // Min Pooling
        {
            acc_t mn = C[0];
            for (int i=1; i< N*N; i++) {
#pragma HLS UNROLL
                if (C[i] < mn) mn = C[i];
            }
            C[0] = mn;
            for (int i=1; i< N*N; i++) {
#pragma HLS UNROLL
                C[i] = 0;
            }
            break;
        }
        case 0x9: // SGD: param - LR * grad
            for (int i=0; i< N*N; i++) {
#pragma HLS UNROLL
                C[i] = (acc_t)A[i] - LR*(acc_t)B[i];
            }
            break;
        case 0xA: // Sigmoid
            for (int i=0; i< N*N; i++) {
#pragma HLS UNROLL
                C[i] = sigmoid(C[i]);
            }
            break;
        case 0xC: // Average Pooling
        {
            acc_t sum_val=0;
            for(int i=0;i<N*N;i++){
#pragma HLS UNROLL
                sum_val+=C[i];
            }
            acc_t avg=(acc_t)(sum_val/(acc_t)(N*N));
            C[0]=avg;
            for(int i=1;i<N*N;i++){
#pragma HLS UNROLL
                C[i]=0;
            }
            break;
        }
        case 0xE: // Max Pooling
        {
            acc_t mx=C[0];
            for(int i=1;i<N*N;i++){
#pragma HLS UNROLL
                if(C[i]>mx) mx=C[i];
            }
            C[0]=mx;
            for(int i=1;i<N*N;i++){
#pragma HLS UNROLL
                C[i]=0;
            }
            break;
        }
        default:
            break;
        }
        done=true;
        state.busy=false;
        state.state=IDLE;
        break;
    }
}

//---------------------------------------------------------------------
// We'll re-use the same style of UART logic (1-bit TX_in, 1-bit RX_out).
// But now we read/write 36 elements for A, B, C (since 9 per array x4).
//---------------------------------------------------------------------
static const unsigned BAUD_TICKS = 10;

struct UartRxState {
    bool active;
    unsigned bitcount;
    unsigned sample_count;
    unsigned char shift_reg;
};

struct UartTxState {
    bool active;
    unsigned bitcount;
    unsigned sample_count;
    unsigned char shift_reg;
    bool tx_out;
    bool data_latched;
};

// Simple 8N1 UART receiver
static void uart_rx(bool rx_pin, unsigned &rx_data, bool &rx_valid, bool rst, UartRxState &st) {
#pragma HLS PIPELINE II=1
    rx_valid=false;
    if(rst){
        st.active=false; st.bitcount=0; st.sample_count=0; st.shift_reg=0;
        rx_data=0;
        return;
    }

    if(!st.active){
        // look for start bit
        if(!rx_pin){
            st.active=true; 
            st.bitcount=0; st.sample_count=0; st.shift_reg=0;
            DEBUG_PRINT("[uart_rx] Found start bit");
        }
    } else {
        st.sample_count++;
        if(st.sample_count == (BAUD_TICKS/2)){
            if(st.bitcount>0 && st.bitcount<=8){
                unsigned char b=(rx_pin?1:0);
                st.shift_reg=(unsigned char)((b<<7)|(st.shift_reg>>1));
            }
        }
        if(st.sample_count >= BAUD_TICKS){
            st.sample_count=0;
            st.bitcount++;
            if(st.bitcount>9){
                st.active=false;
                rx_data=st.shift_reg;
                rx_valid=true;
                DEBUG_PRINT("[uart_rx] Received byte="<<(int)(signed char)rx_data);
            }
        }
    }
}

// Simple 8N1 UART transmitter
static void uart_tx(bool &tx_pin, bool tx_req, unsigned tx_data, bool rst, UartTxState &st) {
#pragma HLS PIPELINE II=1
    if(rst){
        st.active=false; st.bitcount=0; st.sample_count=0; 
        st.shift_reg=0; st.tx_out=true; st.data_latched=false;
        tx_pin=true;
        return;
    }

    if(!st.active){
        // idle
        if(tx_req && !st.data_latched){
            st.active=true; st.bitcount=0; st.sample_count=0;
            st.shift_reg=(unsigned char)tx_data;
            st.tx_out=false; // start bit
            st.data_latched=true;
            DEBUG_PRINT("[uart_tx] Sending byte="<<(int)(signed char)tx_data);
        } else {
            st.tx_out=true;
            st.data_latched=false;
        }
    } else {
        // sending
        st.sample_count++;
        if(st.sample_count>=BAUD_TICKS){
            st.sample_count=0;
            st.bitcount++;
            if(st.bitcount<=8){
                bool b=(st.shift_reg & 0x01)?true:false;
                st.tx_out=b;
                st.shift_reg=(st.shift_reg>>1);
            } else if(st.bitcount==9){
                // stop bit
                st.tx_out=true;
            } else {
                // done
                st.active=false; st.bitcount=0;
                st.data_latched=false;
                st.tx_out=true;
                DEBUG_PRINT("[uart_tx] Byte done");
            }
        }
    }
    tx_pin=st.tx_out;
}

//---------------------------------------------------------------------
// Top-level for 4 parallel arrays
//  - We'll read 36 bytes for A, 36 for B, run all 4 in parallel, then send 36
//---------------------------------------------------------------------
void systolic_top_uart_4parallel(
    // 8 In Pins
    bool opcode_in0,
    bool opcode_in1,
    bool opcode_in2,
    bool opcode_in3,
    bool start_in,
    bool tx_in,
    bool clk_in,
    bool rst_in,

    // 8 Out Pins
    bool &done_out,
    bool &busy_out,
    bool &rx_out,
    bool &out4,
    bool &out5,
    bool &out6,
    bool &out7,
    bool &out8
)
{
#pragma HLS INTERFACE ap_none port=opcode_in0
#pragma HLS INTERFACE ap_none port=opcode_in1
#pragma HLS INTERFACE ap_none port=opcode_in2
#pragma HLS INTERFACE ap_none port=opcode_in3
#pragma HLS INTERFACE ap_none port=start_in
#pragma HLS INTERFACE ap_none port=tx_in
#pragma HLS INTERFACE ap_none port=clk_in
#pragma HLS INTERFACE ap_none port=rst_in

#pragma HLS INTERFACE ap_none port=done_out
#pragma HLS INTERFACE ap_none port=busy_out
#pragma HLS INTERFACE ap_none port=rx_out
#pragma HLS INTERFACE ap_none port=out4
#pragma HLS INTERFACE ap_none port=out5
#pragma HLS INTERFACE ap_none port=out6
#pragma HLS INTERFACE ap_none port=out7
#pragma HLS INTERFACE ap_none port=out8

#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1

    // Pack opcode
    opcode_t opcode=0;
    opcode |= (opcode_in0?1:0)<<0;
    opcode |= (opcode_in1?1:0)<<1;
    opcode |= (opcode_in2?1:0)<<2;
    opcode |= (opcode_in3?1:0)<<3;

    // We store A,B,C for 4 arrays in flatten style
    // => each array has 9 elements => total 36
    static data_t A[NUM_ARRAYS*N*N];
    static data_t B[NUM_ARRAYS*N*N];
    static acc_t  C[NUM_ARRAYS*N*N];

    // 4 states
    static systolic_state_t states[NUM_ARRAYS];
    static bool done_array[NUM_ARRAYS];

    // UART
    static UartRxState rx_st;
    static UartTxState tx_st;
    static unsigned rx_data;
    static bool rx_valid=false;

    // A small FSM to read 36 bytes => A, 36 => B, run parallel, output 36 => C
    static enum {FSM_IDLE, FSM_LOAD_A, FSM_LOAD_B, FSM_RUN, FSM_SEND_C} fsm_state;
    static unsigned load_count=0;
    static unsigned send_count=0;
    static bool internal_busy=false;
    static bool internal_done=false;

    // Reset
    if(rst_in){
        for(int m=0;m<NUM_ARRAYS;m++){
            states[m].state=IDLE; 
            states[m].busy=false; 
            states[m].k=0;
            done_array[m]=false;
            for(int i=0;i<N*N;i++){
                states[m].partial_sum[i]=0;
                A[m*N*N + i]=0;
                B[m*N*N + i]=0;
                C[m*N*N + i]=0;
            }
        }
        rx_st.active=false; rx_st.bitcount=0; rx_st.sample_count=0; rx_st.shift_reg=0;
        rx_data=0; rx_valid=false;

        tx_st.active=false; tx_st.bitcount=0; tx_st.sample_count=0; 
        tx_st.shift_reg=0; tx_st.tx_out=true; tx_st.data_latched=false;

        fsm_state=FSM_IDLE;
        load_count=0;
        send_count=0;
        internal_busy=false;
        internal_done=false;
        done_out=false; 
        busy_out=false; 
        rx_out=true;
        out4=false; 
        out5=false; 
        out6=false; 
        out7=false; 
        out8=false;

        DEBUG_PRINT("[top_4parallel] RESET");
        return;
    }

    // UART each cycle
    uart_rx(tx_in, rx_data, rx_valid, false, rx_st);
    bool tx_req=false;
    unsigned tx_data_tmp=0;
    uart_tx(rx_out, tx_req, tx_data_tmp, false, tx_st);

    // FSM
    switch(fsm_state){
    case FSM_IDLE:
        if(start_in){
            fsm_state=FSM_LOAD_A;
            load_count=0;
            internal_busy=true;
            internal_done=false;
            DEBUG_PRINT("[FSM] -> FSM_LOAD_A");
        }
        break;
    case FSM_LOAD_A:
        // Need 36 bytes for A
        if(rx_valid){
            A[load_count] = (data_t)((signed char)rx_data);
            DEBUG_PRINT("[FSM_LOAD_A] A["<<load_count<<"]="<<(int)(signed char)rx_data);
            load_count++;
            if(load_count== (N*N*NUM_ARRAYS)){
                load_count=0;
                fsm_state=FSM_LOAD_B;
                DEBUG_PRINT("[FSM_LOAD_A] Done reading A => FSM_LOAD_B");
            }
        }
        break;
    case FSM_LOAD_B:
        if(rx_valid){
            B[load_count] = (data_t)((signed char)rx_data);
            DEBUG_PRINT("[FSM_LOAD_B] B["<<load_count<<"]="<<(int)(signed char)rx_data);
            load_count++;
            if(load_count== (N*N*NUM_ARRAYS)){
                load_count=0;
                fsm_state=FSM_RUN;
                DEBUG_PRINT("[FSM_LOAD_B] Done reading B => FSM_RUN, opcode=0x"
                            <<std::hex<<(int)opcode<<std::dec);
            }
        }
        break;
    case FSM_RUN:
    {
        // Call systolic_array for each parallel block
        bool all_done=true;
        bool any_busy=false;
        for(int m=0;m<NUM_ARRAYS;m++){
#pragma HLS UNROLL
            systolic_array(false, true,
                           &A[m*N*N], &B[m*N*N], &C[m*N*N],
                           done_array[m],
                           states[m],
                           opcode);
            all_done &= done_array[m];
            any_busy |= states[m].busy;
        }
        if(all_done){
            fsm_state=FSM_SEND_C;
            send_count=0;
            DEBUG_PRINT("[FSM_RUN] All arrays done => FSM_SEND_C");
        }
        break;
    }
    case FSM_SEND_C:
        // 36 total elements => each element as one signed byte
        if(!tx_st.active && !tx_st.data_latched){
            signed char out_val = (signed char)(C[send_count]);
            tx_data_tmp = (unsigned char)out_val;
            tx_req=true;
            DEBUG_PRINT("[FSM_SEND_C] C["<<send_count<<"]="<<(int)out_val<<" => TX");
            send_count++;
            if(send_count==(N*N*NUM_ARRAYS)){
                fsm_state=FSM_IDLE;
                internal_busy=false;
                internal_done=true;
                DEBUG_PRINT("[FSM_SEND_C] Finished sending 36 => FSM_IDLE");
            }
        }
        break;
    }

    // Combine busy/done
    done_out = internal_done;
    busy_out = internal_busy;

    // placeholders
    out4=false; out5=false; out6=false; out7=false; out8=false;
}
