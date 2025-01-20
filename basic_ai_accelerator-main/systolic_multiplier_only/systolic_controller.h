#ifndef SYSTOLIC_CONTROLLER_H
#define SYSTOLIC_CONTROLLER_H

#include <ap_fixed.h>

// Define Fixed-Point Types
typedef ap_fixed<32,8> data_t;   // Q8.24 format
typedef ap_fixed<32,12> acc_t;   // Q12.20 format
typedef unsigned char opcode_t;

// Define Systolic Array Parameters
#define N 4
#define NUM_ARRAYS 4

// Define State Enumeration
typedef enum { IDLE, CALC, FINISH } state_enum;

// Define Systolic State Structure
typedef struct {
    state_enum state;
    int k;
    bool busy;
    acc_t partial_sum[N*N];
} systolic_state_t;

// Function Prototypes
void systolic_array(
    bool rst,
    bool start,
    data_t A[N*N],
    data_t B[N*N],
    acc_t C[N*N],
    bool &done,
    systolic_state_t &state,
    opcode_t opcode // Opcode Input
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
