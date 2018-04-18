from c_function cimport sum_function, substraction_function

def sum(int a, int b):
    print("sum function is called!")
    return sum_function(a, b)

def substraction(int a, int b):
    print("substraction function is called!")
    return substraction_function(a, b)


