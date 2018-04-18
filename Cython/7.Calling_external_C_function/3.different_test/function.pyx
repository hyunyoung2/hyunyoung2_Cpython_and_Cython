cdef extern from "add.c":
    int sum_function(int a, int b) 

cdef extern from "substraction.c":
    int substraction_function(int a, int b)


def sum(int a, int b):
    print("sum function is called!")
    return sum_function(a, b)

def substraction(int a, int b):
    print("substraction function is called!")
    return substraction_function(a, b)


