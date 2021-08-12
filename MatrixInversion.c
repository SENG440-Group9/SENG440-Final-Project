#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

#define FIXED_POINT_FRACTIONAL_BITS 18

typedef int fixed_int_t;

double fixedToFloat(fixed_int_t fixedVal) {
    return ((double)fixedVal / (double)(1 << FIXED_POINT_FRACTIONAL_BITS));
}

fixed_int_t floatToFixed(int floatVal) {
    return (fixed_int_t)(floatVal * (1 << FIXED_POINT_FRACTIONAL_BITS));
}

// fixed_int_t longIntToFixed(long int longVal) {
//     int temp = longVal * (1 >> FIXED_POINT_FRACTIONAL_BITS);
//     return (fixed_int_t)(longVal >> FIXED_POINT_FRACTIONAL_BITS);
// }

/*
 * Print a matrix
 * input: the matrix to print
 */
void printMatrix(fixed_int_t** matrix, register short int matrixSize) {
    register short int row, col;
    printf("\nfloats\n");
    for (row = 0; row < matrixSize; row++) {
        for (col = 0; col < matrixSize; col++) {
            printf("%f ", fixedToFloat(matrix[row][col])); 
        }
        printf("\n");
    }
    printf("\nFixed\n");
    for (row = 0; row < matrixSize; row++) {
        for (col = 0; col < matrixSize; col++) {
            printf("%d ", matrix[row][col]);
        }
        printf("\n\n");
    }
    return;
}

void printRow(fixed_int_t* row) {
    printf("\nReal matrix\n");
    for (i = 0; i < matrixSize; i++) {
        printf("%f ", fixedToFloat(row[i])); 
    }
    printf("\n");
    return;
}

/*
 * Builds a matrix from an input file
 * input: a file containing a matrix 
 */
void buildMatrix(FILE *input_file, double ** matrix, register short int matrixSize) {
    register short int row, col;
    char buff[255];
    char * token;
    char *eptr;

    if (input_file == NULL) 
    {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    } 

    for(row = 0; row < matrixSize; row++) {
        fgets(buff, 255, (FILE*)input_file);
        token = strtok(buff, " ");
        if ( token == NULL ) printf(" Null token\n");
        for(col = 0; col < matrixSize; col++) {
            matrix[row][col] = floatToFixed(strtod(token, &eptr));
            token = strtok(NULL, " ");
        }
    }

    return;
}

/*
 * Generates an identity matrix of matrixSize
 * output: the identity matrix
 */
void generateIdentityMatrix(double **identityMatrix, register short int matrixSize) {
    register short int row, col;
    
    for(row = 0; row < matrixSize; row++) {
        for(col = 0; col < matrixSize; col++) {
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
fixed_int_t* divideRow(fixed_int_t divisor, fixed_int_t* rowToDivide, register short int matrixSize) {
    register short int col;
    long int longTransferVariable = 0;
    fixed_int_t dividingVar = 0;
    for(col = 0; col < matrixSize; col++) {
        dividingVar = rowToDivide[col];
        rowToDivide[col] = (fixed_int_t)((long)(rowToDivide[col] * (1 << FIXED_POINT_FRACTIONAL_BITS)) / divisor);
        longTransferVariable = rowToDivide[col];
    }
    return rowToDivide;
}

/*
 * Subtraction step
 * input: row that will be reduced, row to reduce it with, multiple of the reducing row
 * output: the row post subtraction
 */
fixed_int_t* subtractRowTimes(fixed_int_t timesToSubtract, fixed_int_t* rowToReduce, fixed_int_t* reducingRow, register short int matrixSize) {
    register short int col;
    long int longTransferVariable = 0;
    fixed_int_t dividingVar, dividedVar;
    for(col = 0; col < matrixSize; col++) {
        longTransferVariable = (long int)(timesToSubtract * reducingRow[col]) >> FIXED_POINT_FRACTIONAL_BITS;
        rowToReduce[col] -= (fixed_int_t)longTransferVariable;
    }
    return rowToReduce;
}

/*
 * Get the index of the highest absolute value in the column, to use later to swap it with the [diagIndex] row
 * input: matrix to search, index to start looking at
 * output: the index of the max value
 */
int getSwapRow(fixed_int_t** matrix, short int col, register short int matrixSize) {
    register short int row;
    fixed_int_t maxVal = 0;
    int maxIndex = 0;
    for(row = col; row < matrixSize; row++) {
        if(abs(matrix[row][col]) > maxVal) {
            maxVal = abs(matrix[row][col]);
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
int invertMatrix(fixed_int_t** inputMatrix, fixed_int_t** outputMatrix, register short int matrixSize) {
    generateIdentityMatrix(outputMatrix, matrixSize);
    register short int outerRow, innerRow;
    fixed_int_t divideRowBy, timesToSubtract;
    int indexToSwap;

    for(outerRow = 0; outerRow < matrixSize; outerRow++) {
        divideRowBy = inputMatrix[outerRow][outerRow];

        // This if statement contains the pivoting steps
        if(divideRowBy == 0) {
            fixed_int_t* tempRow;
            indexToSwap = getSwapRow(inputMatrix, outerRow, matrixSize);
            if(indexToSwap == 0) {
                printf("Error! Matrix is not invertable. There is no usable value to pivot in column %d\n", outerRow);
                exit(-1);
            }
            // Swapping the rows
            tempRow = inputMatrix[outerRow];
            inputMatrix[outerRow] = inputMatrix[indexToSwap];
            inputMatrix[indexToSwap] = tempRow;
            tempRow = outputMatrix[outerRow];
            outputMatrix[outerRow] = outputMatrix[indexToSwap];
            outputMatrix[indexToSwap] = tempRow;
            divideRowBy = inputMatrix[outerRow][outerRow];
        }
        outputMatrix[outerRow] = divideRow(divideRowBy, outputMatrix[outerRow], matrixSize);
        inputMatrix[outerRow] = divideRow(divideRowBy, inputMatrix[outerRow], matrixSize);

        for(innerRow = 0; innerRow < matrixSize; innerRow++) {
            if (outerRow == innerRow) {
                continue;
            }
            // printf("\n\n----------------------\n Stubracting\n");
            // printf("inputMatrix\n");
            // printMatrix(inputMatrix);
            // printf("\n\noutputMatrix\n");
            // printMatrix(outputMatrix);
            timesToSubtract = inputMatrix[innerRow][outerRow];
            inputMatrix[innerRow] = subtractRowTimes(timesToSubtract, inputMatrix[innerRow], inputMatrix[outerRow], matrixSize);
            outputMatrix[innerRow] = subtractRowTimes(timesToSubtract, outputMatrix[innerRow], outputMatrix[outerRow], matrixSize);
        }

    }

    return 1;
}

double computeConditionNumber(double** matrix, register short int matrixSize) {
    register short int row, col;
	double norm = 0.0;
    double rowSum;
	for (row=0; row<matrixSize; row++) {
		rowSum = 0.0;
		for (col=0; col<matrixSize; col++) {
			rowSum += fabs(matrix[row][col]);
		}
		if (norm < rowSum) {
			norm = rowSum;
		}
	}
	return norm;
}

int main(int argc, char *argv[]) {
    register short int i;
    char buff[255];
    short int matrixSize;
    double conditionNum;

    if ( argc != 2 ) {
        printf("Error, need input filename.\n");
        return -1;
    }
    FILE *input_file  = fopen(argv[1], "r");
    matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
    printf(" Matrix size = %d, argc: %d\n", matrixSize, argc);
    fixed_int_t** matrix = malloc(matrixSize*sizeof(fixed_int_t*));
    for(i = 0; i < matrixSize; i++)
        *(matrix+i) = (fixed_int_t*)malloc(sizeof(fixed_int_t)*matrixSize);
    buildMatrix(input_file, matrix, matrixSize);

    conditionNum  = computeConditionNumber(matrix, matrixSize);

    printf("Condition number of the matrix: %f\n", conditionNum);
    if (conditionNum >= 25.00) {
	    fclose(input_file);
	    free(matrix);
	    printf("Input matix is not well-conditioned. Exiting program.\n");
	    return -1;
    }
    printf("Input Matrix\n");
    printMatrix(matrix, matrixSize);
    fixed_int_t** outputMatrix = malloc(matrixSize*sizeof(fixed_int_t*));
    for(i=0; i<matrixSize; i++)
        *(outputMatrix+i) = (fixed_int_t*)malloc(sizeof(fixed_int_t)*matrixSize);
    invertMatrix(matrix, outputMatrix, matrixSize);

    // printf("Row reduced input matrix (should be the identity matrix)\n");
    // printMatrix(matrix, matrixSize);
    printf("Inverted Matrix\n");
    printMatrix(outputMatrix, matrixSize);
    fclose(input_file);
    free(matrix);
    free(outputMatrix);
}
