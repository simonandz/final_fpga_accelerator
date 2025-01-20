`timescale 1ns/1ps

// ----------------------------------------------------------------
// Parameter definitions (Classic Verilog, no localparam logic)
// ----------------------------------------------------------------
parameter [1:0] IDLE   = 2'd0;
parameter [1:0] CALC   = 2'd1;
parameter [1:0] FINISH = 2'd2;

// FSM States
parameter [2:0] FSM_IDLE   = 3'd0;
parameter [2:0] FSM_LOAD_A = 3'd1;
parameter [2:0] FSM_LOAD_B = 3'd2;
parameter [2:0] FSM_RUN    = 3'd3;
parameter [2:0] FSM_SEND_C = 3'd4;

module systolic_top_uart_4parallel_q8_24 (
    input  opcode_in0,
    input  opcode_in1,
    input  opcode_in2,
    input  opcode_in3,
    input  start_in,
    input  tx_in,       // UART RX pin
    input  clk_in,
    input  rst_in,
    output reg  done_out,
    output reg  busy_out,
    output       rx_out,      // UART TX pin
    output       out4,
    output       out5,
    output       out6,
    output       out7,
    output       out8
);

// ----------------------------------------------------------------
// Additional constants
// ----------------------------------------------------------------
parameter integer N           = 3;   // for CALC
parameter integer NUM_ARRAYS  = 4;
parameter integer TOTAL_3x3   = 9;  // 3×3
parameter integer BAUD_TICKS  = 10; // old code had 8'd10

// Q8.24 constants
parameter [31:0] Q8_24_ONE     = 32'd16777216;   
parameter [31:0] Q8_24_0_1     = 32'd1677722;    
parameter [31:0] Q8_24_0_01    = 32'd167772;     
parameter [31:0] Q8_24_SIX     = 32'd100663296;  
parameter [31:0] Q8_24_NEG_SIX = 32'hFA000000;    // -6.0

// ----------------------------------------------------------------
// Parallel arrays for "systolic_state_t" fields
// ----------------------------------------------------------------
reg [1:0]   st_state   [0:NUM_ARRAYS-1];
reg [31:0]  st_k       [0:NUM_ARRAYS-1];
reg         st_busy    [0:NUM_ARRAYS-1];
reg [287:0] st_partial [0:NUM_ARRAYS-1];
reg [NUM_ARRAYS-1:0] done_array;

// ----------------------------------------------------------------
// Memory/Packed Data for A/B/C
// ----------------------------------------------------------------
reg [(NUM_ARRAYS*288)-1:0] A_blk_packed;
reg [(NUM_ARRAYS*288)-1:0] B_blk_packed;
reg [(NUM_ARRAYS*288)-1:0] C_blk_packed;

// 9×4=36 => each 32 bits => 1152 bits total
reg [((9*4*32)-1):0] A_data_packed; 
reg [((9*4*32)-1):0] B_data_packed;

// FSM signals
reg [2:0] fsm_state;
reg [5:0] load_count;
reg       internal_busy;
reg       internal_done;

// Flattened UART regs
reg        rx_active;
reg [7:0]  rx_bitcount;
reg [7:0]  rx_sample_count;
reg [7:0]  rx_shift_reg;

reg        tx_active;
reg [7:0]  tx_bitcount;
reg [7:0]  tx_sample_count;
reg [7:0]  tx_shift_reg;
reg        tx_out_reg;
reg        tx_data_latched;

// ephemeral byte from RX
reg [7:0] rx_data;
reg       rx_valid;

// We used to declare these as wire in the always block, but older Verilog doesn't allow that
// We'll define them here as module-level regs and assign them inside the always block
reg [7:0]   rx_data_tmp;
reg         rx_valid_tmp;
reg         dummy_tx_wire; 

// Build an 8-bit opcode from the input bits
wire [7:0] opcode;
assign opcode = {4'b0000, opcode_in3, opcode_in2, opcode_in1, opcode_in0};

// ----------------------------------------------------------------
// Flatten the "generate" for A/B packing with an always @(*)
// ----------------------------------------------------------------
integer i_g;
always @(*) begin
    for (i_g = 0; i_g < (NUM_ARRAYS*9); i_g = i_g + 1) begin
        A_blk_packed[i_g*32 +: 32] = A_data_packed[i_g*32 +: 32];
        B_blk_packed[i_g*32 +: 32] = B_data_packed[i_g*32 +: 32];
    end
end

// ----------------------------------------------------------------
// Q8.24 math in old style
// ----------------------------------------------------------------
function [31:0] get_lut_val;
    input integer i;
begin
    case (i)
        0 :  get_lut_val = 32'd418;      
        1 :  get_lut_val = 32'd1130;     
        2 :  get_lut_val = 32'd3077;     
        3 :  get_lut_val = 32'd8395;     
        4 :  get_lut_val = 32'd22873;    
        5 :  get_lut_val = 32'd62261;    
        6 :  get_lut_val = 32'd16777216; // e^0
        7 :  get_lut_val = 32'd271441614;
        8 :  get_lut_val = 32'd737846116;
        9 :  get_lut_val = 32'd2006340599;
        10: get_lut_val = 32'hFF000000;
        11: get_lut_val = 32'hFF800000;
        12: get_lut_val = 32'hFFC00000;
        default: get_lut_val = 32'd0;
    endcase
end
endfunction

function [31:0] q8_24_exp_fixed;
    input [31:0] x_in;
    integer x_int, lut_index;
    reg [31:0] tmpx;
begin
    tmpx = x_in;
    if ($signed(tmpx) > $signed(Q8_24_SIX))     tmpx = Q8_24_SIX;
    if ($signed(tmpx) < $signed(Q8_24_NEG_SIX)) tmpx = Q8_24_NEG_SIX;

    x_int    = $signed(tmpx) >>> 24;
    lut_index= x_int + 6;
    if (lut_index < 0)   lut_index = 0;
    if (lut_index > 12)  lut_index = 12;

    q8_24_exp_fixed = get_lut_val(lut_index);
end
endfunction

function [31:0] q8_24_mul;
    input [31:0] a;
    input [31:0] b;
    reg signed [63:0] product;
    reg signed [63:0] shifted;
begin
    product = { {32{a[31]}}, a } * { {32{b[31]}}, b };
    shifted = product >>> 24;
    q8_24_mul = shifted[31:0];
end
endfunction

function [31:0] q8_24_div;
    input [31:0] num;
    input [31:0] den;
    reg signed [63:0] num_64;
    reg signed [63:0] den_64;
    reg signed [63:0] quotient;
begin
    num_64 = { {32{num[31]}}, num };
    den_64 = { {32{den[31]}}, den };
    num_64 = num_64 <<< 24;
    if (den_64 == 0)
        quotient = 0;
    else
        quotient = num_64 / den_64;
    q8_24_div = quotient[31:0];
end
endfunction

function [31:0] q8_24_relu;
    input [31:0] x_in;
begin
    if ($signed(x_in) < 0)
        q8_24_relu = 32'd0;
    else
        q8_24_relu = x_in;
end
endfunction

function [31:0] q8_24_leaky_relu;
    input [31:0] x_in;
    reg [31:0] tmpmul;
begin
    if ($signed(x_in) < 0) begin
        tmpmul = q8_24_mul(x_in, Q8_24_0_1);
        q8_24_leaky_relu = tmpmul;
    end
    else
        q8_24_leaky_relu = x_in;
end
endfunction

function [31:0] q8_24_sigmoid;
    input [31:0] x_in;
    integer x_int;
begin
    x_int = $signed(x_in) >>> 24;
    if (x_int >= 4)
        q8_24_sigmoid = Q8_24_ONE;
    else if (x_int <= -4)
        q8_24_sigmoid = 32'd0;
    else
        q8_24_sigmoid = (Q8_24_ONE >>> 1);
end
endfunction

task q8_24_softmax;
    input  [TOTAL_3x3*32-1:0] in_arr;
    output [TOTAL_3x3*32-1:0] out_arr;

    integer i;
    reg signed [31:0] local_array [0:8];
    reg signed [31:0] sum_val, tmp;
begin
    sum_val = 0;
    // unpack
    for (i=0; i<9; i=i+1) begin
        local_array[i] = $signed(in_arr[i*32 +: 32]);
    end

    // exponentials
    for (i=0; i<9; i=i+1) begin
        tmp = q8_24_exp_fixed(local_array[i]);
        local_array[i] = tmp;
        sum_val = sum_val + tmp;
    end

    // normalize
    if (sum_val != 0) begin
        for (i=0; i<9; i=i+1) begin
            local_array[i] = q8_24_div(local_array[i], sum_val);
        end
    end

    // repack
    for (i=0; i<9; i=i+1) begin
        out_arr[i*32 +: 32] = local_array[i];
    end
end
endtask

// ----------------------------------------------------------------
// Systolic Array Task
// ----------------------------------------------------------------
task systolic_array;
    input         rst;
    input         start;
    input  [287:0]A_blk;
    input  [287:0]B_blk;
    output [287:0]C_blk_out;
    output        done;

    input  [1:0]   s_state_in;
    input  [31:0]  s_k_in;
    input          s_busy_in;
    input  [287:0] s_partial_in;

    output [1:0]   s_state_out;
    output [31:0]  s_k_out;
    output         s_busy_out;
    output [287:0] s_partial_out;

    input [7:0] opcode;

    reg [31:0] localA [0:8];
    reg [31:0] localB [0:8];
    reg [31:0] localC [0:8];
    reg [1:0]  local_state;
    reg [31:0] local_k;
    reg        local_busy;
    reg [287:0]tempC;

    reg done_reg;
    reg [1:0] s_state_out_reg;
    reg [31:0]s_k_out_reg;
    reg       s_busy_out_reg;
    reg [287:0] s_partial_out_reg;

    integer i, j, idx, a_idx, b_idx;
begin : SYSTOLIC_TASK
    local_state = s_state_in;
    local_k     = s_k_in;
    local_busy  = s_busy_in;

    for (i=0; i<9; i=i+1) begin
        localC[i] = s_partial_in[i*32 +: 32];
    end
    for (i=0; i<9; i=i+1) begin
        localA[i] = A_blk[i*32 +: 32];
        localB[i] = B_blk[i*32 +: 32];
    end

    done_reg = 1'b0;
    if (rst) begin
        local_state = IDLE;
        local_k     = 32'd0;
        local_busy  = 1'b0;
        for (i=0; i<9; i=i+1) localC[i] = 32'd0;
    end
    else begin
        case (local_state)
            IDLE: begin
                if (start && !local_busy) begin
                    local_busy = 1'b1;
                    if (opcode == 8'h01) begin
                        local_state = CALC;
                        local_k     = 32'd0;
                        for (i=0; i<9; i=i+1)
                            localC[i] = 32'd0;
                    end
                    else begin
                        local_state = FINISH;
                    end
                end
            end

            CALC: begin
                if (local_k < N) begin
                    for (i=0; i<N; i=i+1) begin
                        for (j=0; j<N; j=j+1) begin
                            idx   = i*N + j;
                            a_idx = i*N + local_k;
                            b_idx = local_k*N + j;
                            localC[idx] = localC[idx] + q8_24_mul(localA[a_idx], localB[b_idx]);
                        end
                    end
                    local_k = local_k + 1;
                    if (local_k == N)
                        local_state = FINISH;
                end
            end

            FINISH: begin
                for (i=0; i<9; i=i+1) begin
                    tempC[i*32 +: 32] = localC[i];
                end

                if (opcode == 8'h02) begin
                    // ReLU
                    for (i=0; i<9; i=i+1)
                        tempC[i*32 +: 32] = q8_24_relu(tempC[i*32 +: 32]);
                end
                else if (opcode == 8'h03) begin
                    // Leaky ReLU
                    for (i=0; i<9; i=i+1)
                        tempC[i*32 +: 32] = q8_24_leaky_relu(tempC[i*32 +: 32]);
                end
                else if (opcode == 8'h04) begin
                    reg [287:0] so_in, so_out;
                    so_in = tempC;
                    q8_24_softmax(so_in, so_out);
                    tempC = so_out;
                end
                else if (opcode == 8'h0A) begin
                    // Sigmoid
                    for (i=0; i<9; i=i+1)
                        tempC[i*32 +: 32] = q8_24_sigmoid(tempC[i*32 +: 32]);
                end

                done_reg   = 1'b1;
                local_busy = 1'b0;
                local_state= IDLE;
            end
        endcase
    end

    for (i=0; i<9; i=i+1) begin
        s_partial_out_reg[i*32 +: 32] = localC[i];
    end

    if (local_state == FINISH)
        tempC = tempC;
    else
        tempC = 288'd0;

    s_state_out_reg = local_state;
    s_k_out_reg     = local_k;
    s_busy_out_reg  = local_busy;

    // drive output ports
    C_blk_out         = tempC;
    done              = done_reg;
    s_state_out       = s_state_out_reg;
    s_k_out           = s_k_out_reg;
    s_busy_out        = s_busy_out_reg;
    s_partial_out     = s_partial_out_reg;
end
endtask

// ------------------------------------------------------
// Minimal old style tasks for UART
// ------------------------------------------------------
task uart_rx;
    input        rx_pin;
    output [7:0] rx_data_out;
    output       rx_valid_out;
    input        rst;
    integer bc;
    reg b_bit, valid_temp;
    reg [7:0] data_temp;
begin
    valid_temp <= 1'b0;
    data_temp  <= 8'd0;

    if (rst) begin
        rx_active       <= 1'b0;
        rx_bitcount     <= 8'd0;
        rx_sample_count <= 8'd0;
        rx_shift_reg    <= 8'd0;
    end
    else begin
        if (!rx_active) begin
            if (!rx_pin) begin
                rx_active       <= 1'b1;
                rx_bitcount     <= 8'd0;
                rx_sample_count <= 8'd0;
                rx_shift_reg    <= 8'd0;
            end
        end
        else begin
            rx_sample_count <= rx_sample_count + 1;
            if (rx_sample_count == (BAUD_TICKS >> 1)) begin
                if ((rx_bitcount > 0) && (rx_bitcount <= 8)) begin
                    b_bit = rx_pin;
                    rx_shift_reg <= {b_bit, rx_shift_reg[7:1]};
                end
            end
            if (rx_sample_count >= BAUD_TICKS) begin
                rx_sample_count <= 8'd0;
                rx_bitcount <= rx_bitcount + 1;
                if (rx_bitcount > 9) begin
                    rx_active <= 1'b0;
                    data_temp <= rx_shift_reg;
                    valid_temp <= 1'b1;
                end
            end
        end
    end

    rx_data_out   <= data_temp;
    rx_valid_out  <= valid_temp;
end
endtask

task uart_tx;
    output tx_dummy;
    input  tx_req;
    input  [7:0] tx_data_in;
    input  rst;
    reg   tx_dummy_reg;
begin
    if (rst) begin
        tx_active       <= 1'b0;
        tx_bitcount     <= 8'd0;
        tx_sample_count <= 8'd0;
        tx_shift_reg    <= 8'd0;
        tx_out_reg      <= 1'b1;
        tx_data_latched <= 1'b0;
        tx_dummy_reg    = 1'b1;
    end
    else begin
        if (!tx_active) begin
            if (tx_req && !tx_data_latched) begin
                tx_active       <= 1'b1;
                tx_bitcount     <= 8'd0;
                tx_sample_count <= 8'd0;
                tx_shift_reg    <= tx_data_in;
                tx_out_reg      <= 1'b0; // start bit
                tx_data_latched <= 1'b1;
            end
            else begin
                tx_out_reg      <= 1'b1;
                tx_data_latched <= 1'b0;
            end
        end
        else begin
            tx_sample_count <= tx_sample_count + 1;
            if (tx_sample_count >= BAUD_TICKS) begin
                tx_sample_count <= 8'd0;
                tx_bitcount     <= tx_bitcount + 1;
                if (tx_bitcount <= 8) begin
                    tx_out_reg    <= tx_shift_reg[0];
                    tx_shift_reg  <= tx_shift_reg >> 1;
                end
                else if (tx_bitcount == 9) begin
                    tx_out_reg <= 1'b1; // stop bit
                end
                else begin
                    tx_active       <= 1'b0;
                    tx_bitcount     <= 8'd0;
                    tx_data_latched <= 1'b0;
                    tx_out_reg      <= 1'b1;
                end
            end
        end
        tx_dummy_reg = tx_out_reg;
    end
    tx_dummy = tx_dummy_reg;
end
endtask

// ------------------------------------------------------
// Main FSM
// ------------------------------------------------------
always @(posedge clk_in or posedge rst_in) begin : MAIN_FSM
    integer i_loc;
    if (rst_in) begin
        done_out      <= 1'b0;
        busy_out      <= 1'b0;
        fsm_state     <= FSM_IDLE;
        load_count    <= 6'd0;
        internal_busy <= 1'b0;
        internal_done <= 1'b0;

        for (i_loc=0; i_loc<NUM_ARRAYS; i_loc=i_loc+1) begin
            st_state[i_loc]   <= IDLE;
            st_k[i_loc]       <= 32'd0;
            st_busy[i_loc]    <= 1'b0;
            st_partial[i_loc] <= 288'd0;
            done_array[i_loc] <= 1'b0;
        end

        A_data_packed <= {(9*4*32){1'b0}};
        B_data_packed <= {(9*4*32){1'b0}};
        C_blk_packed  <= {(4*288){1'b0}};

        rx_data       <= 8'd0;
        rx_valid      <= 1'b0;
    end
    else begin
        // call old style tasks, store in module-level regs
        uart_rx(tx_in, rx_data_tmp, rx_valid_tmp, 1'b0);
        rx_data  <= rx_data_tmp;
        rx_valid <= rx_valid_tmp;

        // do TX
        uart_tx(dummy_tx_wire, 1'b0, 8'd0, 1'b0);
        tx_out_reg <= dummy_tx_wire;

        case (fsm_state)
            FSM_IDLE: begin
                if (start_in) begin
                    fsm_state     <= FSM_LOAD_A;
                    load_count    <= 6'd0;
                    internal_busy <= 1'b1;
                    internal_done <= 1'b0;
                end
            end

            FSM_LOAD_A: begin
                if (rx_valid && load_count < 36) begin
                    A_data_packed[load_count*32 +: 32]
                        <= {{24{rx_data[7]}}, rx_data};
                    if (load_count == 35) begin
                        load_count <= 6'd0;
                        fsm_state  <= FSM_LOAD_B;
                    end
                    else begin
                        load_count <= load_count + 1;
                    end
                end
            end

            FSM_LOAD_B: begin
                if (rx_valid && load_count < 36) begin
                    B_data_packed[load_count*32 +: 32]
                        <= {{24{rx_data[7]}}, rx_data};
                    if (load_count == 35) begin
                        load_count <= 6'd0;
                        fsm_state  <= FSM_RUN;
                    end
                    else begin
                        load_count <= load_count + 1;
                    end
                end
            end

            FSM_RUN: begin
                // We'll do 4 parallel systolic_array calls
                reg [287:0] tC [0:3];
                reg [1:0]   s_st_in [0:3], s_st_out [0:3];
                reg [31:0]  s_k_inarr [0:3], s_k_outarr [0:3];
                reg         s_b_inarr [0:3], s_b_outarr[0:3];
                reg [287:0] s_ps_inarr[0:3], s_ps_outarr[0:3];
                reg         done_f[0:3];
                integer xx;

                for (xx=0; xx<4; xx=xx+1) begin
                    s_st_in[xx]   = st_state[xx];
                    s_k_inarr[xx] = st_k[xx];
                    s_b_inarr[xx] = st_busy[xx];
                    s_ps_inarr[xx]= st_partial[xx];
                end

                // #0
                systolic_array(
                    1'b0, 1'b1,
                    A_blk_packed[0 +: 288],
                    B_blk_packed[0 +: 288],
                    tC[0], done_f[0],
                    s_st_in[0], s_k_inarr[0], s_b_inarr[0], s_ps_inarr[0],
                    s_st_out[0], s_k_outarr[0], s_b_outarr[0], s_ps_outarr[0],
                    opcode
                );

                // #1
                systolic_array(
                    1'b0, 1'b1,
                    A_blk_packed[288 +: 288],
                    B_blk_packed[288 +: 288],
                    tC[1], done_f[1],
                    s_st_in[1], s_k_inarr[1], s_b_inarr[1], s_ps_inarr[1],
                    s_st_out[1], s_k_outarr[1], s_b_outarr[1], s_ps_outarr[1],
                    opcode
                );

                // #2
                systolic_array(
                    1'b0, 1'b1,
                    A_blk_packed[576 +: 288],
                    B_blk_packed[576 +: 288],
                    tC[2], done_f[2],
                    s_st_in[2], s_k_inarr[2], s_b_inarr[2], s_ps_inarr[2],
                    s_st_out[2], s_k_outarr[2], s_b_outarr[2], s_ps_outarr[2],
                    opcode
                );

                // #3
                systolic_array(
                    1'b0, 1'b1,
                    A_blk_packed[864 +: 288],
                    B_blk_packed[864 +: 288],
                    tC[3], done_f[3],
                    s_st_in[3], s_k_inarr[3], s_b_inarr[3], s_ps_inarr[3],
                    s_st_out[3], s_k_outarr[3], s_b_outarr[3], s_ps_outarr[3],
                    opcode
                );

                for (xx=0; xx<4; xx=xx+1) begin
                    st_state[xx]   <= s_st_out[xx];
                    st_k[xx]       <= s_k_outarr[xx];
                    st_busy[xx]    <= s_b_outarr[xx];
                    st_partial[xx] <= s_ps_outarr[xx];
                    done_array[xx] <= done_f[xx];
                end

                C_blk_packed <= { tC[3], tC[2], tC[1], tC[0] };

                if (done_array == 4'b1111)
                    fsm_state <= FSM_SEND_C;
            end

            FSM_SEND_C: begin
                fsm_state     <= FSM_IDLE;
                internal_busy <= 1'b0;
                internal_done <= 1'b1;
            end
        endcase

        done_out <= internal_done;
        busy_out <= internal_busy;
    end
end

// Assign final TX out
assign rx_out = tx_out_reg;

// Tie off unused outputs
assign out4 = 1'b0;
assign out5 = 1'b0;
assign out6 = 1'b0;
assign out7 = 1'b0;
assign out8 = 1'b0;

endmodule
