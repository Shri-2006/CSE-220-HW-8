//shriyans Singh 114807762
//just to get the C implementation done as practice
#define max 10
#include<stdio.h>

int a[max],b[max];
int num=10;

int main(){
    for(int i=0;i<num;i++){
        //get va;ues
        printf("a[%d]=",i+1);
        scanf("%d", &a[i]);
        printf("b[%d]=",i+1);
        scanf("%d",&b[i]);
    }
    for(int i=0;i<num;i++){
        //swap
        int temp=a[i];
        a[i]=b[i];
        b[i]=temp;
    }
    //print values
    printf("\n");
    for(int i=0;i<num;i++){
        printf("%d  %d|",a[i],b[i]);
    }
    
}