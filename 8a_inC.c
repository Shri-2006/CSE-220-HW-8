//writing out how to do in C before doing in MIPS
//shriyans singh 114807762
#include <stdio.h>

//star printer
void printer(int count){
    for(int i=0;i<count;i++){
        printf("*");
    }
    printf("\n");
}

//0, drawung a triangle

void triangle(int s){
    for(int row=1;row<=s;row++){
        printer(row);
    }
}

//square-1
void square(int s){
    for(int row=0;row<s;row++){
        printer(s);
    }
}

//drawing pyramid which is just centrerlized triangle from pdf instructions
void pyramid(int s){
    //printer wont work here, need to do it manulaly
    for(int row=1;row<=s;row++){
        //print spaces, then print stars, then after that print \n
        int i=0;
        for( i=0;i<(s-row);i++){
            printf(" ");
        }
        for(i=1;i<=row;i++){
            printf("*");
            if(i<row){
                printf(" ");
            }
        }
        printf("\n");

    }
}


int main(){
    int type,s;
    printf("Triangle (0), or Squre(1), or Pyramid(2)");
    scanf("%d",&type);
    printf("\nsize to use in the strcture?");
    scanf("%d",&s);
    printf("\n");
    
    if (type==0){
        triangle(s);
    }
    else if(type==1){
        square(s);
    }
    else if(type==2){
        pyramid(s);
    }
}