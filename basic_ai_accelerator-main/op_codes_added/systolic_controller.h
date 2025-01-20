#ifndef SYSTOLIC_CONTROLLER_H
#define SYSTOLIC_CONTROLLER_H

#include <ap_fixed.h>

// Fixed-Point Types
typedef ap_fixed<32,8>  data_t;   // Q8.24
typedef ap_fixed<32,12> acc_t;    // Q12.20
typedef unsigned char   opcode_t;

// 3×3 Systolic Array Size
#define N 3
#define NUM_ARRAYS 4

// Finite State Machine
typedef enum { IDLE, CALC, FINISH } state_enum;

typedef struct {
    state_enum state;
    int k;
    bool busy;
    acc_t partial_sum[N*N];
} systolic_state_t;

//-----------------------------------
// Define OPCODES
//-----------------------------------
// Using your table (resolving duplicates):
// Binary / Hex  / Operation
// 0000 / 0x0  : No-Op
// 0001 / 0x1  : 3x3 Systolic Matrix Multiply
// 0010 / 0x2  : ReLU
// 0011 / 0x3  : Leaky ReLU
// 0100 / 0x4  : Softmax
// 1000 / 0x8  : Min Pooling
// 1001 / 0x9  : Stochastic Gradient Descent
// 1010 / 0xA  : Sigmoid
// 1011 / 0xB  : Compute Loss
// 1100 / 0xC  : Average Pooling
// 1110 / 0xE  : Max Pooling
//
// (If you need 0xD, 0xF, etc. for something else, you can add them here.)

// External learning rate
extern const acc_t LR;

//-----------------------------------
// Function Prototypes
//-----------------------------------
void systolic_array(
    bool rst,
    bool start,
    data_t A[N*N],
    data_t B[N*N],
    acc_t C[N*N],
    bool &done,
    systolic_state_t &state,
    opcode_t opcode
);

void top_systolic_controller_flat(
    bool rst,
    bool start,
    opcode_t opcode,
    data_t flat_A[NUM_ARRAYS * N * N],
    data_t flat_B[NUM_ARRAYS * N * N],
    acc_t flat_C[NUM_ARRAYS * N * N],
    bool done[NUM_ARRAYS]
);

#endif // SYSTOLIC_CONTROLLER_H
