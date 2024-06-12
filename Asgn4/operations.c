
#include <stdio.h>

int addnums(int x, int y){
    int sum = x + y;
    printf("Result: %d", sum);
    return sum;
}

int subnums(int x, int y){
    int difference = x - y;
    printf("Result: %d", difference);
    return difference;
}

int multnums(int x, int y){
    int product = x * y;
    printf("Result: %d", product);
    return product;
}

int divnums(int x, int y){
    int quotient = x / y;
    printf("Result: %d", quotient);
    return quotient;
}

int andnums(int x, int y){
    int and_answer = x & y;
    printf("Result: %d", and_answer);
    return and_answer;
}

int ornums(int x, int y){
    int or_answer = x | y;
    printf("Result: %d", or_answer);
    return or_answer;
}

int xornums(int x, int y){
    int xor_answer = x ^ y;
    printf("Result: %d", xor_answer);
    return xor_answer;
}

int lshiftnums(int x, int y){
    int lshift_result = x << y;
    printf("Result: %d", lshift_result);
    return lshift_result;
}


unsigned int unsignedrshiftnums(unsigned int x, int y){
    unsigned int unsigned_rshift_result = x >> y;
    printf("Result: %u", unsigned_rshift_result);
    return unsigned_rshift_result; 
}



