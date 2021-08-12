#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

int matrixSize;

/*
 * Print a matrix
 * input: the matrix to print
 */
void printMatrix(double** matrix) {
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
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
double** buildMatrix(FILE *input_file) {
    double** matrix = malloc(matrixSize*sizeof(double*));

    for(int i = 0; i < matrixSize; i++) { 
        matrix[i] = malloc(sizeof(double*) * matrixSize); 
    } 

    if (input_file == NULL) 
    {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    } 

    char buff[255];
    char * token;

    for(int i = 0; i < matrixSize; i++) {
        fgets(buff, 255, (FILE*)input_file);
        token = strtok(buff, " ");
        for(int j = 0; j < matrixSize; j++) {
            matrix[i][j] = atoi(token);
            token = strtok(NULL, " ");
        }
    }

    return matrix;
}

/*
 * Generates an identity matrix of matrixSize
 * output: the identity matrix
 */
double** generateIdentityMatrix() {
    double** identityMatrix = malloc(matrixSize*sizeof(double*));
    for(int i = 0; i < matrixSize; i++) { 
        identityMatrix[i] = malloc(sizeof(double*) * matrixSize); 
    } 

    for(int i = 0; i < matrixSize; i++) {
        for(int j = 0; j < matrixSize; j++) {
            if (i == j) {
                identityMatrix[i][j] = 1.0;
            } else {
                identityMatrix[i][j] = 0.0;
            }
        }
    }

    return identityMatrix;
}

/*
 * Division step
 * input: row that will be divided, how much to divide that row
 * output: the row post division
 */
double* divideRow(double timesToDivide, double* rowToDivide) {
    for(int col = 0; col < matrixSize; col++) {
        rowToDivide[col] /= timesToDivide;
    }
    return rowToDivide;
}

/*
 * Subtraction step
 * input: row that will be reduced, row to reduce it with, multiple of the reducing row
 * output: the row post subtraction
 */
double* subtractRowTimes(double timesToSubtract, double* rowToReduce, double* reducingRow) {
    for(int col = 0; col < matrixSize; col++) {
        rowToReduce[col] -= timesToSubtract * reducingRow[col];
    }
    return rowToReduce;
}

/*
 * Get the index of the highest absolute value in the column, to use later to swap it with the [diagIndex] row
 * input: matrix to search, index to start looking at
 * output: the index of the max value
 */
int getSwapRow(double** matrix, int diagIndex) {
    double maxVal = 0;
    int maxIndex = 0;
    for(int row = diagIndex; row < matrixSize; row++) {
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
double** invertMatrix(double** matrixToInvert) {
    double** invertedMatrix = generateIdentityMatrix();
    double divideRowBy, timesToSubtract;
    int swappingIndex;

    for(int highestIndex = 0; highestIndex < matrixSize; highestIndex++) {
        divideRowBy = matrixToInvert[highestIndex][highestIndex];

        // This if statement contains the pivoting steps
        if(divideRowBy == 0) {
            double* tempRow;
            swappingIndex = getSwapRow(matrixToInvert, highestIndex);
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
        invertedMatrix[highestIndex] = divideRow(divideRowBy, invertedMatrix[highestIndex]);
        matrixToInvert[highestIndex] = divideRow(divideRowBy, matrixToInvert[highestIndex]);

        for(int row = 0; row < matrixSize; row++) {
            if (highestIndex == row) {
                continue;
            }
            timesToSubtract = matrixToInvert[row][highestIndex];
            invertedMatrix[row] = subtractRowTimes(timesToSubtract, invertedMatrix[row], invertedMatrix[highestIndex]);
            matrixToInvert[row] = subtractRowTimes(timesToSubtract, matrixToInvert[row], matrixToInvert[highestIndex]);
        }

    }

    return invertedMatrix;
}

double computeConditionNumber(double** matrix) {
	double norm = 0.0;
	for (int i=0; i<matrixSize; i++) {
		double rowSum = 0.0;
		for (int j=0; j<matrixSize; j++) {
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
    FILE *input_file  = fopen(argv[1], "r");
    char buff[255];
    matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
    // matrixSize = atoi(argv[2]);
    double** matrix = buildMatrix(input_file);
    double conditionNum  = computeConditionNumber(matrix);

    printf("Condition number of the matrix: %f\n", conditionNum);
    if (conditionNum >= 25.00) {
	    fclose(input_file);
	    free(matrix);
	    printf("Input matix is not well-conditioned. Exiting program.\n");
	    return -1;
    }

    printf("Input Matrix\n");
    printMatrix(matrix);

    double** invertedMatrix = invertMatrix(matrix);
    if (invertedMatrix == 0) {
        printf("Matrix inversion failed\n");
        return 0;
    }

    // printf("Row reduced input matrix (should be the identity matrix)\n");
    // printMatrix(matrix);
    printf("Inverted Matrix\n");
    printMatrix(invertedMatrix);
    fclose(input_file);
    free(matrix);
    free(invertedMatrix);
}
