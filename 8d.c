//shriyans singh 114807762
#include <stdio.h>
#define X 4 //ta may change this so having it in one spot is easier


void multiply(int n, int m, int p, int A[n][m], int B[m][p], int C[n][p])
{
for (int r = 0; r < n; r++) {
for (int c = 0; c < p; c++) {
int sum = 0;
for (int i = 0; i < m; i++) {
sum += A[r][i] * B[i][c];
}
C[r][c] = sum;
}
}
}

int main(){
    int A[X][X]={{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}};
    int I[X][X]={{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}};
    int res[X][X]={0};
    multiply(X,X,X,A,I,res);

    for(int r=0;r<X;r++){
        for(int c=0;c<X;c++){
            printf("%d",res[r][c]);
        }
        printf("\n");
    }
}