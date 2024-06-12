#include <stdio.h>
#include "operations.h"


int main(void) {
    int x; 
    int y;
    int operationChoice; 
    int count = 0;
    int condition = 0;
    char userInput = 'y';


    printf("Welcome to the Calculator program. \n");
    printf("Operations - 1:add 2:subtract 3: multiply 4:divide 5:and 6:or 7:xor 8:1shift 9:rshift \n");

    while (condition == 0) {
        printf("\nNumber of operations performed: %d", count);
        
        printf("\nEnter number: ");
        scanf(" %d", &x);
        printf("Enter second number: ");
        scanf(" %d", &y);

        printf("Select operation: ");
        scanf(" %d", &operationChoice);

        if (operationChoice == 1){
            addnums(x,y);
        } else if (operationChoice == 2){
            subnums(x,y);
        } else if (operationChoice == 3){
            multnums(x,y);
        } else if (operationChoice == 4){
            divnums(x,y);
        } else if (operationChoice == 5){
            andnums(x,y);
        } else if (operationChoice == 6){
            ornums(x,y);
        } else if (operationChoice == 7){
            xornums(x,y);
        } else if (operationChoice == 8){
            lshiftnums(x,y);
        } else if (operationChoice == 9){
            unsignedrshiftnums(x,y);
        } else {
            printf("Invalid Operation");
        }
        printf("\nContinue (y/n)?: ");
        scanf(" %c", &userInput);  

        if (userInput == 'n') {
            break;
        }
        count += 1; 


    }
    printf("\nNumber of operations performed: %d\n", count);
    printf("Exiting... \n");
    return 0;

}



