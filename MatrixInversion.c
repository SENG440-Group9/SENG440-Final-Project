#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define BASE_SCALE_FACTOR 11

typedef struct FixedNum {
    int scaleFactor;
    int fixedValue;
} FixedNum;

enum {MATRIX_SIZE = 20};

double fixedToFloat(FixedNum fixedVal) {
    return ((double)fixedVal.fixedValue / (double)(1 << fixedVal.scaleFactor)); }

FixedNum floatToFixed(double floatVal) {
    if(floatVal != 0) {
        return (FixedNum){ .scaleFactor = BASE_SCALE_FACTOR, .fixedValue = (int)(floatVal * (1 << BASE_SCALE_FACTOR))};
    } else {
        return (FixedNum){ .scaleFactor = 0, .fixedValue = 0};
    }
}

/*
 * Print a matrix
 * input: the matrix to print
 */
void printMatrix(FixedNum** matrix) {
    register int row, col;
    for (row = 0; row < MATRIX_SIZE; row++) {
		/*
		 * Loop unrolling performed here.
		 * ASSUMPTION: MATRIX_SIZE > 4 && MATRIX_SIZE a multiple of 4
		 */
        for (col = 0; col < MATRIX_SIZE; col+=4){
            printf("%f %f %f %f ", 
					fixedToFloat(matrix[row][col]),
					fixedToFloat(matrix[row][col+1]),
					fixedToFloat(matrix[row][col+2]),
					fixedToFloat(matrix[row][col+3]));
        }
        printf("\n");
    }
    return;
}

/*
 * Builds a matrix from an input file
 * input: a file containing a matrix 
 */
void buildMatrix(FILE *input_file, FixedNum** matrix) {
    register int row, col;
    char buff[255];
    char * token;
    char *eptr;

    if (input_file == NULL) 
    {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    }

    for(row = 0; row < MATRIX_SIZE; row++) {
        fgets(buff, 255, (FILE*)input_file);
        token = strtok(buff, " ");
        if ( token == NULL ) printf(" Null token\n");
        for(col = 0; col < MATRIX_SIZE; col++) {
            matrix[row][col] = floatToFixed(strtod(token, &eptr));
            token = strtok(NULL, " ");
        }
    }

    return;
}

/*
 * Generates an identity matrix of MATRIX_SIZE
 * output: the identity matrix
 */
void generateIdentityMatrix(FixedNum **identityMatrix) {
    register int row, col;

    for(row = 0; row < MATRIX_SIZE; row++) {
        for(col = 0; col < MATRIX_SIZE; col++) {
            if (row == col) {
                identityMatrix[row][col] = floatToFixed(1.0);
            } else {
                identityMatrix[row][col] = floatToFixed(0.0);
            }
        }
    }
    return;
}

/*
 * Division step
 * input: row that will be divided, how much to divide that row
 * output: the row post division
 */
FixedNum* divideRow(FixedNum divisor, FixedNum* rowToDivide) {
    register int col;
    int shiftProduct, divisionResult;
    
    /*
     * Loop unrolling performed here.
     * ASSUMPTION: MATRIX_SIZE > 2 && MATRIX_SIZE a multiple of 2
     */
    for(col = 0; col < MATRIX_SIZE; col++) {
        // Ignore divisions that won't change the value
        if(!(rowToDivide[col].fixedValue == 0 || (divisor.fixedValue == 1024 && divisor.scaleFactor == BASE_SCALE_FACTOR))) {
			// Shift the dividend before dividing to preserve more decimal precision
            __asm__("SDR %0, %1, %2" : "=r" (divisionResult) : "r" (rowToDivide[col].fixedValue), "r" (divisor.fixedValue));
			rowToDivide[col] = (FixedNum){ 
				.fixedValue = divisionResult, 
				.scaleFactor = (rowToDivide[col].scaleFactor + BASE_SCALE_FACTOR - divisor.scaleFactor)
				};
				
			// Make sure the new number has the correct precision
			if(rowToDivide[col].fixedValue != 0) {
				if(rowToDivide[col].scaleFactor > BASE_SCALE_FACTOR) {
					shiftProduct = rowToDivide[col].scaleFactor - BASE_SCALE_FACTOR;
					rowToDivide[col].fixedValue = rowToDivide[col].fixedValue >> shiftProduct;
					rowToDivide[col].scaleFactor -= shiftProduct;
				} else if(rowToDivide[col].scaleFactor < BASE_SCALE_FACTOR) {
					shiftProduct = BASE_SCALE_FACTOR - rowToDivide[col].scaleFactor;
					rowToDivide[col].fixedValue = rowToDivide[col].fixedValue << shiftProduct;
					rowToDivide[col].scaleFactor += shiftProduct;
				}
			}
        }

		col++;

        // Ignore divisions that won't change the value
        if(!(rowToDivide[col].fixedValue == 0 || (divisor.fixedValue == 1024 && divisor.scaleFactor == BASE_SCALE_FACTOR))) {
			// Shift the dividend before dividing to preserve more decimal precision
            __asm__("SDR %0, %1, %2" : "=r" (divisionResult) : "r" (rowToDivide[col].fixedValue), "r" (divisor.fixedValue));
			rowToDivide[col] = (FixedNum){ 
				.fixedValue = divisionResult, 
				.scaleFactor = (rowToDivide[col].scaleFactor + BASE_SCALE_FACTOR - divisor.scaleFactor)
				};
				
			// Make sure the new number has the correct precision
			if(rowToDivide[col].fixedValue != 0) {
				if(rowToDivide[col].scaleFactor > BASE_SCALE_FACTOR) {
					shiftProduct = rowToDivide[col].scaleFactor - BASE_SCALE_FACTOR;
					rowToDivide[col].fixedValue = rowToDivide[col].fixedValue >> shiftProduct;
					rowToDivide[col].scaleFactor -= shiftProduct;
				} else if(rowToDivide[col].scaleFactor < BASE_SCALE_FACTOR) {
					shiftProduct = BASE_SCALE_FACTOR - rowToDivide[col].scaleFactor;
					rowToDivide[col].fixedValue = rowToDivide[col].fixedValue << shiftProduct;
					rowToDivide[col].scaleFactor += shiftProduct;
				}
			}
        }
    }
    return rowToDivide;
}

/*
 * Subtraction step
 * input: row that will be reduced, row to reduce it with, multiple of the reducing row
 * output: the row post subtraction
 */
FixedNum* subtractRowTimes(FixedNum timesToSubtract, FixedNum* rowToReduce, FixedNum* reducingRow) {
    register int col;
    FixedNum transferVariable;
    int shiftProduct, newFixedValue, newScaleFactor;
    /*
     * Loop unrolling performed here.
     * ASSUMPTION: MATRIX_SIZE > 2 && MATRIX_SIZE a multiple of 2
     */
    for(col = 0; col < MATRIX_SIZE; col++) {
        // Ignore subtractions that have no effect
        if(timesToSubtract.fixedValue != 0 && reducingRow[col].fixedValue != 0) {
			
			// Multiplying the subtractor
			newFixedValue = (timesToSubtract.fixedValue * reducingRow[col].fixedValue) >> BASE_SCALE_FACTOR;
			newScaleFactor = timesToSubtract.scaleFactor + reducingRow[col].scaleFactor - BASE_SCALE_FACTOR;
			transferVariable = (FixedNum){.fixedValue = newFixedValue, .scaleFactor = newScaleFactor };
			// Both numbers must have the same scaling factor to subtract properly
			if(transferVariable.scaleFactor > rowToReduce[col].scaleFactor) {
				rowToReduce[col].fixedValue = rowToReduce[col].fixedValue << (transferVariable.scaleFactor - rowToReduce[col].scaleFactor);
				rowToReduce[col].scaleFactor = transferVariable.scaleFactor;
			} else if(transferVariable.scaleFactor < rowToReduce[col].scaleFactor) {
				transferVariable.fixedValue = transferVariable.fixedValue << (rowToReduce[col].scaleFactor - transferVariable.scaleFactor);
				transferVariable.scaleFactor = rowToReduce[col].scaleFactor;
			}
			// The actual subtraction
			rowToReduce[col].fixedValue -=  transferVariable.fixedValue;

			// Make sure the new number has the correct precision
			if(rowToReduce[col].fixedValue != 0) {
				if(rowToReduce[col].scaleFactor > BASE_SCALE_FACTOR) {
					shiftProduct = rowToReduce[col].scaleFactor - BASE_SCALE_FACTOR;
					rowToReduce[col].fixedValue = rowToReduce[col].fixedValue >> shiftProduct;
					rowToReduce[col].scaleFactor -= shiftProduct;
				} else if(rowToReduce[col].scaleFactor < BASE_SCALE_FACTOR) {
					shiftProduct = BASE_SCALE_FACTOR - rowToReduce[col].scaleFactor;
					rowToReduce[col].fixedValue = rowToReduce[col].fixedValue << shiftProduct;
					rowToReduce[col].scaleFactor += shiftProduct;
				}
			}
        }

		col++;

        // Ignore subtractions that have no effect
        if(timesToSubtract.fixedValue != 0 && reducingRow[col].fixedValue != 0) {
			
			// Multiplying the subtractor
			newFixedValue = (timesToSubtract.fixedValue * reducingRow[col].fixedValue) >> BASE_SCALE_FACTOR;
			newScaleFactor = timesToSubtract.scaleFactor + reducingRow[col].scaleFactor - BASE_SCALE_FACTOR;
			transferVariable = (FixedNum){.fixedValue = newFixedValue, .scaleFactor = newScaleFactor };
			// Both numbers must have the same scaling factor to subtract properly
			if(transferVariable.scaleFactor > rowToReduce[col].scaleFactor) {
				rowToReduce[col].fixedValue = rowToReduce[col].fixedValue << (transferVariable.scaleFactor - rowToReduce[col].scaleFactor);
				rowToReduce[col].scaleFactor = transferVariable.scaleFactor;
			} else if(transferVariable.scaleFactor < rowToReduce[col].scaleFactor) {
				transferVariable.fixedValue = transferVariable.fixedValue << (rowToReduce[col].scaleFactor - transferVariable.scaleFactor);
				transferVariable.scaleFactor = rowToReduce[col].scaleFactor;
			}
			// The actual subtraction
			rowToReduce[col].fixedValue -=  transferVariable.fixedValue;

			// Make sure the new number has the correct precision
			if(rowToReduce[col].fixedValue != 0) {
				if(rowToReduce[col].scaleFactor > BASE_SCALE_FACTOR) {
					shiftProduct = rowToReduce[col].scaleFactor - BASE_SCALE_FACTOR;
					rowToReduce[col].fixedValue = rowToReduce[col].fixedValue >> shiftProduct;
					rowToReduce[col].scaleFactor -= shiftProduct;
				} else if(rowToReduce[col].scaleFactor < BASE_SCALE_FACTOR) {
					shiftProduct = BASE_SCALE_FACTOR - rowToReduce[col].scaleFactor;
					rowToReduce[col].fixedValue = rowToReduce[col].fixedValue << shiftProduct;
					rowToReduce[col].scaleFactor += shiftProduct;
				}
			}
        }
    }
    return rowToReduce;
}

/*
 * Get the index of the highest absolute value in the column, to use later to swap it with the [col] row
 * input: matrix to search, index to start looking at
 * output: the index of the max value
 */
int getSwapRow(FixedNum** matrix, int col) {
    register int row;
    int maxVal = 0;
    int maxIndex = 0;
    int currentValue;
    /*
     * Loop unrolling performed here.
     * ASSUMPTION: MATRIX_SIZE > 2 && MATRIX_SIZE a multiple of 2
     */
    for(row = col; row < MATRIX_SIZE; row++) {
        currentValue = abs(matrix[row][col].fixedValue >> matrix[row][col].scaleFactor);
        if(currentValue > maxVal) {
            maxVal = currentValue;
            maxIndex = row;
        }
		row++;
        currentValue = abs(matrix[row][col].fixedValue >> matrix[row][col].scaleFactor);
        if(currentValue > maxVal) {
            maxVal = currentValue;
            maxIndex = row;
        }
    }
    return maxIndex;
}

/*
 * Invert the matrix
 * input: matrix to invert
 * output: the matrix's inverse
 */
int invertMatrix(FixedNum** inputMatrix, FixedNum** outputMatrix) {
    register int outerRow, innerRow;
    int indexToSwap;
    FixedNum divideRowBy, timesToSubtract;
    FixedNum* rowTransferVariable;
    generateIdentityMatrix(outputMatrix);

    for(outerRow = 0; outerRow < MATRIX_SIZE; outerRow++) {
        divideRowBy = inputMatrix[outerRow][outerRow];

        // This if statement contains the pivoting steps
        if(divideRowBy.fixedValue == 0) {
            indexToSwap = getSwapRow(inputMatrix, outerRow);
            if(indexToSwap == 0) {
                printf("Error! Matrix is not invertable. There is no usable value to pivot in column %d\n", outerRow);
                exit(-1);
            }
            // Swapping the rows
            rowTransferVariable = inputMatrix[outerRow];
            inputMatrix[outerRow] = inputMatrix[indexToSwap];
            inputMatrix[indexToSwap] = rowTransferVariable;
            rowTransferVariable = outputMatrix[outerRow];
            outputMatrix[outerRow] = outputMatrix[indexToSwap];
            outputMatrix[indexToSwap] = rowTransferVariable;
            divideRowBy = inputMatrix[outerRow][outerRow];
        }
        inputMatrix[outerRow] = divideRow(divideRowBy, inputMatrix[outerRow]);
        outputMatrix[outerRow] = divideRow(divideRowBy, outputMatrix[outerRow]);

		/*
		 * Loop unrolling performed here.
		 * ASSUMPTION: MATRIX_SIZE > 2 && MATRIX_SIZE a multiple of 2
		 */
        for(innerRow = 0; innerRow < MATRIX_SIZE; innerRow++) {
            if (outerRow != innerRow) {
				timesToSubtract = inputMatrix[innerRow][outerRow];
				inputMatrix[innerRow] = subtractRowTimes(timesToSubtract, inputMatrix[innerRow], inputMatrix[outerRow]);
				outputMatrix[innerRow] = subtractRowTimes(timesToSubtract, outputMatrix[innerRow], outputMatrix[outerRow]);
            }
			innerRow++;
            if (outerRow != innerRow) {
				timesToSubtract = inputMatrix[innerRow][outerRow];
				inputMatrix[innerRow] = subtractRowTimes(timesToSubtract, inputMatrix[innerRow], inputMatrix[outerRow]);
				outputMatrix[innerRow] = subtractRowTimes(timesToSubtract, outputMatrix[innerRow], outputMatrix[outerRow]);
            }
        }
    }
    return 1;
}

int computeConditionNumber(FixedNum** matrix) {
    register int row, col;
	int norm = 0;
    int rowSum;

    /*
     * Loop unrolling performed here.
     * ASSUMPTION: MATRIX_SIZE > 2 && MATRIX_SIZE a multiple of 2
     */
	for (row=0; row<MATRIX_SIZE; row++) {
		rowSum = 0;
		/*
		 * Loop unrolling performed here.
		 * ASSUMPTION: MATRIX_SIZE > 4 && MATRIX_SIZE a multiple of 4
		 */
		for (col=0; col<MATRIX_SIZE; col+=4) {
			rowSum += abs(matrix[row][col].fixedValue >> matrix[row][col].scaleFactor);
			rowSum += abs(matrix[row][col+1].fixedValue >> matrix[row][col+1].scaleFactor);
			rowSum += abs(matrix[row][col+2].fixedValue >> matrix[row][col+2].scaleFactor);
			rowSum += abs(matrix[row][col+3].fixedValue >> matrix[row][col+3].scaleFactor);
		}
		if (norm < rowSum) {
			norm = rowSum;
		}

		row++;

		rowSum = 0;
		/*
		 * Loop unrolling performed here.
		 * ASSUMPTION: MATRIX_SIZE > 4 && MATRIX_SIZE a multiple of 4
		 */
		for (col=0; col<MATRIX_SIZE; col+=4) {
			rowSum += abs(matrix[row][col].fixedValue >> matrix[row][col].scaleFactor);
			rowSum += abs(matrix[row][col+1].fixedValue >> matrix[row][col+1].scaleFactor);
			rowSum += abs(matrix[row][col+2].fixedValue >> matrix[row][col+2].scaleFactor);
			rowSum += abs(matrix[row][col+3].fixedValue >> matrix[row][col+3].scaleFactor);
		}
		if (norm < rowSum) {
			norm = rowSum;
		}
	}

	return norm;
}

int main(int argc, char *argv[]) {
    register int i;
    char buff[255];
    int matrixSize;
    double conditionNum;

    // File IO
    if(argc != 2) {
        printf("Error, need input filename.\n");
        return -1;
    }
    FILE *input_file  = fopen(argv[1], "r");
    matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
    if(matrixSize != MATRIX_SIZE) {
        printf("Error, incorrect matrix size. Must be a %dX%d matrix.\n", MATRIX_SIZE, MATRIX_SIZE);
        return -1;
    }
    printf(" Matrix size = %d, argc: %d\n", argc, MATRIX_SIZE);

    // Building input matrix
    FixedNum** inputMatrix = malloc(MATRIX_SIZE*sizeof(FixedNum*));
    for(i = 0; i < MATRIX_SIZE; i++)
        *(inputMatrix+i) = (FixedNum*)malloc(sizeof(FixedNum)*MATRIX_SIZE);
    buildMatrix(input_file, inputMatrix);

    // Condition number calculation
    conditionNum  = computeConditionNumber(inputMatrix);
    printf("Condition number of the matrix: %f\n", conditionNum);
    if (conditionNum >= 25.00) {
        fclose(input_file);
        free(inputMatrix);
        printf("Input matix is not well-conditioned. Exiting program.\n");
        return -1;
    }
    printf("Input Matrix\n");
    printMatrix(inputMatrix);
    
    // Building output matrix
    FixedNum** outputMatrix = malloc(MATRIX_SIZE*sizeof(FixedNum*));
    for(i = 0; i < MATRIX_SIZE; i++)
        *(outputMatrix+i) = (FixedNum*)malloc(sizeof(FixedNum)*MATRIX_SIZE);

    // Invert matrices
    invertMatrix(inputMatrix, outputMatrix);

    // printf("Row reduced input matrix (should be the identity matrix)\n");
    // printMatrix(inputMatrix);
    printf("Inverted Matrix\n");
    printMatrix(outputMatrix);
    fclose(input_file);
    free(inputMatrix);
    free(outputMatrix);
}
