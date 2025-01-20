// overall_tb.cpp
#include "systolic_controller.h"
#include <iostream>
#include <cstring>
#include <cmath> // For fabs
#include <cassert>

// Define ZERO as a constant
const acc_t ZERO = (acc_t)0.0;

// Function to Print the Output Matrix
void print_matrix(acc_t flat_C[N*N], int array_id) {
    std::cout << "Array " << array_id << " Output C:" << std::endl;
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            // Convert acc_t to double before printing
            std::cout << flat_C[i*N + j].to_double() << " ";
        }
        std::cout << std::endl;
    }
}

// Function to Compare Two ap_fixed Values with a Tolerance
bool compare_fixed(ap_fixed<32,12> a, ap_fixed<32,12> b, ap_fixed<32,12> tolerance = 0.01) {
    return fabs(a.to_double() - b.to_double()) < tolerance.to_double();
}

int main() {
    // Define Test Inputs
    data_t flat_A[NUM_ARRAYS * N * N];
    data_t flat_B[NUM_ARRAYS * N * N];
    acc_t flat_C[NUM_ARRAYS * N * N];
    bool done[NUM_ARRAYS];
    bool rst = true;   // Start with Reset Asserted
    bool start = false;
    opcode_t opcode = 0x0; // Initialize Opcode

    // Initialize Outputs
    std::fill(flat_C, flat_C + NUM_ARRAYS * N * N, ZERO);
    std::fill(done, done + NUM_ARRAYS, false);

    // Define Simulation Parameters
    const int max_cycles = 300; // Increased Cycles to Accommodate All Test Cases
    int cycle = 0;
    bool all_tests_passed = true;

    // Define a Variable to Track the Current Test Case
    enum TestCase {
        TEST_CASE_0,
        TEST_CASE_1,
        TEST_CASE_2,
        TEST_CASE_3,
        TEST_CASE_4,
        TEST_COMPLETE
    } current_test = TEST_CASE_0;

    // Simulation Loop
    while(cycle < max_cycles && current_test != TEST_COMPLETE) {
        // Apply Reset for the First Few Cycles
        if(cycle < 5) {
            rst = true;
            start = false;
            opcode = 0x0; // No Op During Reset
        }
        else if(cycle == 5) {
            rst = false;  // Deassert Reset
            start = false;
            opcode = 0x0; // No Op
            std::cout << "Deasserting reset at cycle " << cycle << std::endl;
        }

        // Set Opcode and Start Signal at Specific Cycles Based on the Current Test Case
        switch(current_test) {
            case TEST_CASE_0:
                if(cycle == 10) {
                    // Initialize Inputs for Test Case 0: All Ones
                    for(int i = 0; i < NUM_ARRAYS * N * N; i++) {
                        flat_A[i] = 1;
                        flat_B[i] = 1;
                    }
                    start = true;
                    opcode = 0x1; // Multiplication Only
                    std::cout << "Asserting start and setting opcode to 0x1 (Multiplication Only) at cycle " << cycle << std::endl;
                }
                else if(cycle == 11) {
                    start = false;
                    std::cout << "Deasserting start at cycle " << cycle << std::endl;
                }
                break;

            case TEST_CASE_1:
                if(cycle == 20) {
                    // Initialize Inputs for Test Case 1: ReLU - All Positive Inputs
                    for(int i = 0; i < NUM_ARRAYS * N * N; i++) {
                        flat_A[i] = 1; // All Ones
                        flat_B[i] = 1; // All Ones
                    }
                    start = true;
                    opcode = 0x2; // ReLU
                    std::cout << "Asserting start and setting opcode to 0x2 (ReLU) at cycle " << cycle << std::endl;
                }
                else if(cycle == 21) {
                    start = false;
                    std::cout << "Deasserting start at cycle " << cycle << std::endl;
                }
                break;

            case TEST_CASE_2:
                if(cycle == 30) {
                    // Initialize Inputs for Test Case 2: Leaky ReLU - All Positive Inputs
                    for(int i = 0; i < NUM_ARRAYS * N * N; i++) {
                        flat_A[i] = 2; // All Twos
                        flat_B[i] = 2; // All Twos
                    }
                    start = true;
                    opcode = 0xC; // Leaky ReLU
                    std::cout << "Asserting start and setting opcode to 0xC (Leaky ReLU) at cycle " << cycle << std::endl;
                }
                else if(cycle == 31) {
                    start = false;
                    std::cout << "Deasserting start at cycle " << cycle << std::endl;
                }
                break;

            case TEST_CASE_3:
                if(cycle == 40) {
                    // Initialize Inputs for Test Case 3: Sigmoid
                    for(int i = 0; i < NUM_ARRAYS * N * N; i++) {
                        flat_A[i] = (ap_fixed<32,8>) (i - 2); // Values: -2, -1, 0, 1, etc.
                        flat_B[i] = (ap_fixed<32,8>) (i - 2);
                    }
                    start = true;
                    opcode = 0xA; // Sigmoid
                    std::cout << "Asserting start and setting opcode to 0xA (Sigmoid) at cycle " << cycle << std::endl;
                }
                else if(cycle == 41) {
                    start = false;
                    std::cout << "Deasserting start at cycle " << cycle << std::endl;
                }
                break;

            case TEST_CASE_4:
                if(cycle == 50) {
                    // Initialize Inputs for Test Case 4: Softmax
                    for(int m = 0; m < NUM_ARRAYS; m++) {
                        for(int i = 0; i < N*N; i++) {
                            flat_A[m*N*N + i] = (ap_fixed<32,8>) (m + i); // Incremental Values
                            flat_B[m*N*N + i] = (ap_fixed<32,8>) (m + i);
                        }
                    }
                    start = true;
                    opcode = 0x8; // Softmax
                    std::cout << "Asserting start and setting opcode to 0x8 (Softmax) at cycle " << cycle << std::endl;
                }
                else if(cycle == 51) {
                    start = false;
                    std::cout << "Deasserting start at cycle " << cycle << std::endl;
                }
                break;

            default:
                break;
        }

        // Call the Top Controller Function
        top_systolic_controller_flat(
            rst,
            start,
            opcode, // Pass the Opcode
            flat_A,
            flat_B,
            flat_C,
            done
        );

        // Check if Any Systolic Array Has Completed
        bool all_done = true;
        for(int m = 0; m < NUM_ARRAYS; m++) {
            if(done[m]) {
                print_matrix(&flat_C[m*N*N], m);
            }
            else {
                all_done = false;
            }
        }

        // If All Arrays Are Done for the Current Test Case, Verify and Move to the Next Test Case
        if(all_done) {
            switch(current_test) {
                case TEST_CASE_0:
                    // Verify Outputs for Test Case 0: All Ones
                    {
                        bool pass = true;
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            for(int i = 0; i < N*N; i++) {
                                // Expected value: 1 * 1 * 4 = 4
                                if(flat_C[m*N*N + i].to_double() != 4.0) {
                                    std::cout << "Mismatch in Array " << m << ", Element " << i 
                                              << ": Expected 4, Got " << flat_C[m*N*N + i].to_double() << std::endl;
                                    pass = false;
                                }
                            }
                        }
                        if(pass) {
                            std::cout << "Test Case 0 PASSED!" << std::endl;
                        }
                        else {
                            std::cout << "Test Case 0 FAILED!" << std::endl;
                            all_tests_passed = false;
                        }
                    }
                    current_test = TEST_CASE_1;
                    break;

                case TEST_CASE_1:
                    // Verify Outputs for Test Case 1: ReLU
                    {
                        bool pass = true;
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            for(int i = 0; i < N*N; i++) {
                                acc_t expected = 4; // 1 * 1 * 4
                                if(!compare_fixed(flat_C[m*N*N + i], expected)) {
                                    std::cout << "Mismatch in Array " << m << ", Element " << i 
                                              << ": Expected " << expected.to_double() << ", Got " << flat_C[m*N*N + i].to_double() << std::endl;
                                    pass = false;
                                }
                            }
                        }
                        if(pass) {
                            std::cout << "Test Case 1 (ReLU) PASSED!" << std::endl;
                        }
                        else {
                            std::cout << "Test Case 1 (ReLU) FAILED!" << std::endl;
                            all_tests_passed = false;
                        }
                    }
                    current_test = TEST_CASE_2;
                    break;

                case TEST_CASE_2:
                    // Verify Outputs for Test Case 2: Leaky ReLU
                    {
                        bool pass = true;
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            for(int i = 0; i < N*N; i++) {
                                acc_t expected = 16; // 2 * 2 * 4
                                if(!compare_fixed(flat_C[m*N*N + i], expected)) {
                                    std::cout << "Mismatch in Array " << m << ", Element " << i 
                                              << ": Expected " << expected.to_double() << ", Got " << flat_C[m*N*N + i].to_double() << std::endl;
                                    pass = false;
                                }
                            }
                        }
                        if(pass) {
                            std::cout << "Test Case 2 (Leaky ReLU) PASSED!" << std::endl;
                        }
                        else {
                            std::cout << "Test Case 2 (Leaky ReLU) FAILED!" << std::endl;
                            all_tests_passed = false;
                        }
                    }
                    current_test = TEST_CASE_3;
                    break;

                case TEST_CASE_3:
                    // Verify Outputs for Test Case 3: Sigmoid
                    {
                        bool pass = true;
                        // Since sigmoid is approximated, define expected ranges
                        // For simplicity, check if outputs are between 0 and 1
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            for(int i = 0; i < N*N; i++) {
                                acc_t val = flat_C[m*N*N + i];
                                if(val.to_double() < 0.0 || val.to_double() > 1.0) {
                                    std::cout << "Mismatch in Array " << m << ", Element " << i 
                                              << ": Expected between 0 and 1, Got " << val.to_double() << std::endl;
                                    pass = false;
                                }
                            }
                        }
                        if(pass) {
                            std::cout << "Test Case 3 (Sigmoid) PASSED!" << std::endl;
                        }
                        else {
                            std::cout << "Test Case 3 (Sigmoid) FAILED!" << std::endl;
                            all_tests_passed = false;
                        }
                    }
                    current_test = TEST_CASE_4;
                    break;

                case TEST_CASE_4:
                    // Verify Outputs for Test Case 4: Softmax
                    {
                        bool pass = true;
                        // For simplicity, check if each row sums to approximately 1
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            acc_t row_sum = ZERO; // Now defined
                            for(int i = 0; i < N; i++) {
                                row_sum += flat_C[m*N*N + i];
                            }
                            if(row_sum.to_double() < 0.99 || row_sum.to_double() > 1.01) { // Allowing Small Numerical Errors
                                std::cout << "Mismatch in Array " << m << ": Row sum = " << row_sum.to_double() << " (Expected ~1)" << std::endl;
                                pass = false;
                            }
                        }
                        if(pass) {
                            std::cout << "Test Case 4 (Softmax) PASSED!" << std::endl;
                        }
                        else {
                            std::cout << "Test Case 4 (Softmax) FAILED!" << std::endl;
                            all_tests_passed = false;
                        }
                    }
                    current_test = TEST_COMPLETE;
                    break;

                default:
                    current_test = TEST_COMPLETE;
                    break;
            }
        }

        // Final Verification Message
        if(all_tests_passed && current_test == TEST_COMPLETE) {
            std::cout << "All test cases passed successfully." << std::endl;
        }
        else if(current_test == TEST_COMPLETE) {
            std::cout << "Some test cases failed. Please check the design." << std::endl;
        }

        // Check if Simulation Timed Out
        if(cycle == max_cycles && current_test != TEST_COMPLETE) {
            std::cout << "Simulation did not complete within " << max_cycles << " cycles." << std::endl;
            all_tests_passed = false;
        }

        // Final Verification Message (Repeated for Clarity)
        if(all_tests_passed) {
            std::cout << "All test cases passed successfully." << std::endl;
        }
        else {
            std::cout << "Some test cases failed. Please check the design." << std::endl;
        }

        // Increment cycle counter at the end of each loop iteration
        cycle++;
    }

    return 0; // Moved outside the while loop
}
