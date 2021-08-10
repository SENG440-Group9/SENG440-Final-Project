#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int matrixSize;

void printMatrix(double** matrix) {
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            printf("%f ", matrix[i][j]);
        }
        printf("\n");
    }
}

double** buildMatrix(FILE *input_file) {
    double** matrix = malloc(matrixSize*sizeof(double*));

    for(int i = 0; i < matrixSize; i++) { 
        matrix[i] = malloc(sizeof(double*) * matrixSize); 
    } 

    // test for bad file
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

double* divideRow(double timesToDivide, double* rowToDivide) {
    for(int col = 0; col < matrixSize; col++) {
        rowToDivide[col] /= timesToDivide;
    }
    return rowToDivide;
}

double* subtractRowTimes(double timesToSubtract, double* rowToReduce, double* reducingRow) {
    for(int col = 0; col < matrixSize; col++) {
        rowToReduce[col] -= timesToSubtract * reducingRow[col];
    }
    return rowToReduce;
}

double** invertMatrix(double** matrixToInvert) {
    double** invertedMatrix = generateIdentityMatrix();
    double divideRowBy, timesToSubtract;

    for(int highestIndex = 0; highestIndex < matrixSize; highestIndex++) {

        divideRowBy = matrixToInvert[highestIndex][highestIndex];
        if(divideRowBy == 0){
            printf("Error! Tried to divide by 0 at index %d\n", highestIndex);
            printMatrix(matrixToInvert);
            return 0;
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

int main(int argc, char *argv[]) {
    FILE *input_file  = fopen(argv[1], "r");
    char buff[255];
    matrixSize = atoi(fgets(buff, 255, (FILE*)input_file));
    // matrixSize = atoi(argv[2]);
    double** matrix = buildMatrix(input_file);
    printf("Input Matrix\n");
    printMatrix(matrix);
    double** invertedMatrix = invertMatrix(matrix);

    // printf("Row reduced input matrix (should be the identity matrix)\n");
    // printMatrix(matrix);
    printf("Inverted Matrix\n");
    printMatrix(invertedMatrix);
    fclose(input_file);
}