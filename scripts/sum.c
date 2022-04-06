#include <stdio.h>
#include <stdlib.h>


int is_num_integer(const char *s)
{
    while (*s) {
        if (*s<'0' || *s>'9') return 0;
        *s++;
    }
    // return 1 if all chars are digits
    return 1;
}

int main(int argc, char * argv[]) 
{     
    int sum;	

    if (argc != 3) 
    {
        printf("Enter only two arguments..\n");
        return 1;
    }  

    if( is_num_integer(argv[1]) == 0 || is_num_integer(argv[2]) == 0)
    {
        printf("Please enter only integer numbers..\n");
        return 2;
    }    

    // atoi: convert string to integer
    sum = atoi(argv[1]) + atoi(argv[2]); 
    printf("%d\n", sum);  

    return 0;
}
