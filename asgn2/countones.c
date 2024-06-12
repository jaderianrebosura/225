#include <stdio.h>

int main(void) {
    unsigned int userNum;
    int count = 0;
    char userInput = 'y'; 
    

    printf("Welcome to the CountOnes program. \n");

    while (userInput == 'y') {
        printf("\nPlease enter a number: ");
        scanf(" %u", &userNum);

        while (userNum != 0) {
            if (userNum & 1) {
                count += 1;
            }
            userNum >>= 1;
        } 
        printf("The number of bits set is: %d\n", count);
        printf("Continue (y/n)?: ");
        scanf(" %c", &userInput);  
        count = 0;
    }
    printf("Exiting \n");
    return 0; 
}





