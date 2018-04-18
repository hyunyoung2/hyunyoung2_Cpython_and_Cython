cdef extern from "add.c":
    int sum_function(int a, int b) 

cdef extern from "substraction.c":
    int substraction_function(int a, int b)
