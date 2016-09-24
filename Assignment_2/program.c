/** 
    Assignment: C Coding 1
    Author Simon Rüegg
**/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int FillTable(int[],int);
void PrintReverseTable(int[],int);

int main(){
    int a[10];
    int size = FillTable(a, 10);
    PrintReverseTable(a, size);
    return EXIT_SUCCESS;
}

int FillTable (int a[], int max){
    int i=0;
    char choice;
    do{
        printf("Enter numeric value for table entry #%d: ", i+1);
        if(scanf(" %d", &a[i]) <= 0){
            fprintf(stderr, "Values must be positive numbers.\n");
            exit(EXIT_FAILURE);
        }
        if(i<max){
            printf("Do you want to enter another value? (y/n): ");
            scanf(" %c", &choice);
        }
        i++;
    }while(choice == 'y' && i<max);

    return i;
}


void PrintReverseTable(int a[], int max){
    for(int i=max-1; i>=0; i--){
        printf("%d\n", a[i]);
    }
}
