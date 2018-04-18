#include <stdio.h>
#include "add.h" 
#include "substraction.h"


int main(){
   int test_a = 2;
   int test_b = 3;
   int result = 0;


   result = sum_function(test_a, test_b);   
   printf("the result of sum_function : %d\n", result);

   result = substraction_function(test_a, test_b);
   printf("the result of substraction : %d\n", result);
   return 0;
}
