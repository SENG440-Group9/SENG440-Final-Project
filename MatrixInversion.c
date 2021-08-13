#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

/*
 * Print a matrix
 * input: the matrix to print
 */
void printMatrix(double** matrix, register short int matrixSize) {
    register short int i, j;

    for (i = 0; i < matrixSize; i++) {
        for (j = 0; j < matrixSize; j++) {
            printf("%f ", matrix[i][j]);
        }
        printf("\n");
    }
    return;
}

/*
 * Builds a matrix from an input file
 * input: a file containing a matrix
 * output: the matrix as a 2d array of doubles
 */
void buildMatrix(FILE *input_file, double ** matrix, register short int matrixSize ) {
    register short int i, j;
    char buff[255];
    char * token;
    char *eptr;
    if (input_file == NULL) 
    {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    } 

    for(i = 0; i < matrixSize; i++) {
        fgets(buff, 255, (FILE*)input_file);
        token = strtok(buff, " ");
        if ( token == NULL ) printf(" Null token\n");
        for(j = 0; j < matrixSize; j++) {
            matrix[i][j] = strtod(token, &eptr);
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
                identityMatrix[row][col] = 1.0;
            } else {
                identityMatrix[row][col] = 0.0;
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
double* divideRow(double divisor, double* rowToDivide, register short int matrixSize) {
    register short int col;
    double inverseDivisor = 1 / divisor;
    for(col = 0; col < matrixSize; col++) {
        rowToDivide[col] *= inverseDivisor;
    }
    return rowToDivide;
}

/*
 * Subtraction step
 * input: row that will be reduced, row to reduce it with, multiple of the reducing row
 * output: the row post subtraction
 */
double* subtractRowTimes(register double timesToSubtract, double* rowToReduce, double* reducingRow, register short int matrixSize) {
    register short int col;
    for(col = 0; col < matrixSize; col++) {
        rowToReduce[col] -= timesToSubtract * reducingRow[col];
    }
    return rowToReduce;
}

/*
 * Get the index of the highest absolute value in the column, to use later to swap it with the [diagIndex] row
 * input: matrix to search, index to start looking at
 * output: the index of the max value
 */
int getSwapRow(double** matrix, short int col, register short int matrixSize) {
    register short int row;
    short int maxIndex = 0;
    double maxVal = 0;
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
int invertMatrix(double** inputMatrix, double** outputMatrix, register short int matrixSize ) {
    generateIdentityMatrix(outputMatrix, matrixSize);
    register short int outerRow, innerRow;
    double divideRowBy, timesToSubtract;
    short int indexToSwap;

    for(outerRow = 0; outerRow < matrixSize; outerRow++) {
        divideRowBy = inputMatrix[outerRow][outerRow];

        // This if statement contains the pivoting steps
        if(divideRowBy == 0) {
            double* tempRow;
            indexToSwap = getSwapRow(inputMatrix, outerRow, matrixSize);
            if(indexToSwap == 0) {
                printf("Error! Matrix is not invertable. There is no usable value to pivot in column %d\n", outerRow);
                return 0;
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
            timesToSubtract = inputMatrix[innerRow][outerRow];
            outputMatrix[innerRow] = subtractRowTimes(timesToSubtract, outputMatrix[innerRow], outputMatrix[outerRow], matrixSize);
            inputMatrix[innerRow] = subtractRowTimes(timesToSubtract, inputMatrix[innerRow], inputMatrix[outerRow], matrixSize);
        }

    }

    return 1;
}

double computeConditionNumber(double** matrix, register short int matrixSize) {
    register short int i, j;
	double norm = 0.0;
    double rowSum;
	for (i=0; i<matrixSize; i++) {
		rowSum = 0.0;
		for (j=0; j<matrixSize; j++) {
			rowSum += fabs(matrix[i][j]);
		}
		if (norm < rowSum) {
			norm = rowSum;
		}
	}
	return norm;
}

/* main.c */
int main(int argc, char *argv[]) {
    int i;
    if ( argc != 2 ) {
        printf("Error, need input filename.\n");
        return -1;
    }
    FILE *input_file  = fopen(argv[1], "r");
    char buff[255];
    short int matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
    printf(" Matrix size = %d, argc: %d\n", matrixSize, argc ) ;
    // matrixSize = atoi(argv[2]);
    double ** matrix = malloc(matrixSize*sizeof(double*));
    for(i=0; i<matrixSize; i++)
        *(matrix+i) = (double*)malloc(sizeof(double)*matrixSize);

    buildMatrix(input_file, matrix, matrixSize);
    double conditionNum  = computeConditionNumber(matrix, matrixSize);

    printf("Condition number of the matrix: %f\n", conditionNum);
    if (conditionNum >= 25.00) {
	    fclose(input_file);
	    free(matrix);
	    printf("Input matix is not well-conditioned. Exiting program.\n");
	    return -1;
    }

    printf("Input Matrix\n");
    printMatrix(matrix, matrixSize);

    double ** invertedMatrix = malloc(matrixSize*sizeof(double*));
    for(i=0; i<matrixSize; i++)
        *(invertedMatrix+i) = (double*)malloc(sizeof(double)*matrixSize);
    int x = invertMatrix(matrix, invertedMatrix, matrixSize);
    if (x == 0) {
        printf("Matrix inversion failed\n");
        return 0;
    }

    // printf("Row reduced input matrix (should be the identity matrix)\n");
    // printMatrix(matrix, matrixSize);
    printf("Inverted Matrix\n");
    printMatrix(invertedMatrix, matrixSize);
    fclose(input_file);
    free(matrix);
    free(invertedMatrix);
}
