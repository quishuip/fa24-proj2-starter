#include<stdio.h>
int dot(int *a0,int*a1,int la2,int s0a3,int s1a4);
void matmul(int*a0,int a1,int a2,int*a3,int a4,int a5,int*a6);
void main(){
    int i,j;
    int a0[]={1,2,3,4,5,6,7,8,9};
    int a3[]={3,2,1,6,5,4,9,8,7};
    int a6[9]={0};
    int a1=3,a2=3,a5=3,a4=3;
    //printf("%d",dot(a0,a3,3,2,2));
    matmul(a0,a1,a2,a3,a4,a5,a6);
    for(i=0;i<3;i++){
        for(j=0;j<3;j++){
            printf("%d ",*(a6+i*3+j));
        }
        printf("\n");
    }
}

int dot(int *a0,int*a1,int la2,int s0a3,int s1a4){
    int i,res=0;
    for(i=0;i<la2;i++){
        res+=(*a0)*(*a1);
        a0+=s0a3;
        a1+=s1a4;
    }
    return res;
}

void matmul(int*a0,int a1,int a2,int*a3,int a4,int a5,int*a6){
    int i,j;
    for (i=0;i<a1;i++){
        for(j=0;j<a5;j++){
            *(a6+i*a5+j)=dot(a0+i*a2,a3+j,a2,1,a5);
        }
    }
}