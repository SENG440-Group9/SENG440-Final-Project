#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

/*
 * Print a matrix
 * input: the matrix to print
 */
void printMatrix(double** matrix, int matrixSize) {
    register int i, j;

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
void buildMatrix(FILE *input_file, double ** matrix, int matrixSize ) {
    register int i, j;
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
        if ( token == '\0' ) printf(" Null token\n");
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
void generateIdentityMatrix(double **identityMatrix, int matrixSize) {
    register int i, j;
    for(i = 0; i < matrixSize; i++) {
        for(j = 0; j < matrixSize; j++) {
            if (i == j) {
                identityMatrix[i][j] = 1.0;
            } else {
                identityMatrix[i][j] = 0.0;
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
double* divideRow(double timesToDivide, double* rowToDivide, int matrixSize) {
    register int col;
    for(col = 0; col < matrixSize; col++) {
        rowToDivide[col] /= timesToDivide;
    }
    return rowToDivide;
}

/*
 * Subtraction step
 * input: row that will be reduced, row to reduce it with, multiple of the reducing row
 * output: the row post subtraction
 */
double* subtractRowTimes(double timesToSubtract, double* restrict rowToReduce, double* restrict reducingRow, int matrixSize) {
    register int col;
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
int getSwapRow(double** matrix, int diagIndex, int matrixSize) {
    register int row;
    double maxVal = 0;
    int maxIndex = 0;
    for(row = diagIndex; row < matrixSize; row++) {
        if(abs(matrix[row][diagIndex]) > maxVal) {
            maxVal = abs(matrix[row][diagIndex]);
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
int invertMatrix(double** matrixToInvert, double **invertedMatrix, int matrixSize ) {
    generateIdentityMatrix(invertedMatrix, matrixSize);
    register int highestIndex, row;
    double divideRowBy, timesToSubtract;
    int swappingIndex;

    for(highestIndex = 0; highestIndex < matrixSize; highestIndex++) {
        divideRowBy = matrixToInvert[highestIndex][highestIndex];

        // This if statement contains the pivoting steps
        if(divideRowBy == 0) {
            double* tempRow;
            swappingIndex = getSwapRow(matrixToInvert, highestIndex, matrixSize);
            if(swappingIndex == 0) {
                printf("Error! Matrix is not invertable. There is no usable value to pivot in column %d\n", highestIndex);
                return 0;
            }
            // Swapping the rows
            tempRow = matrixToInvert[highestIndex];
            matrixToInvert[highestIndex] = matrixToInvert[swappingIndex];
            matrixToInvert[swappingIndex] = tempRow;
            tempRow = invertedMatrix[highestIndex];
            invertedMatrix[highestIndex] = invertedMatrix[swappingIndex];
            invertedMatrix[swappingIndex] = tempRow;
            divideRowBy = matrixToInvert[highestIndex][highestIndex];
        }
        invertedMatrix[highestIndex] = divideRow(divideRowBy, invertedMatrix[highestIndex], matrixSize);
        matrixToInvert[highestIndex] = divideRow(divideRowBy, matrixToInvert[highestIndex], matrixSize);

        for(row = 0; row < matrixSize; row++) {
            if (highestIndex == row) {
                continue;
            }
            timesToSubtract = matrixToInvert[row][highestIndex];
            invertedMatrix[row] = subtractRowTimes(timesToSubtract, invertedMatrix[row], invertedMatrix[highestIndex], matrixSize);
            matrixToInvert[row] = subtractRowTimes(timesToSubtract, matrixToInvert[row], matrixToInvert[highestIndex], matrixSize);
        }

    }

    return 1;
}

double computeConditionNumber(double** matrix, int matrixSize) {
    register int i, j;
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
    int matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
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
