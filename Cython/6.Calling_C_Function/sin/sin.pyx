from libc.math cimport sin

cdef double f(double x):
    return sin(x*x)

# For the function above, cdef double f(double x):
def sin_f(double x):
    print("f function called!")
    return f(x)

cpdef double f1(double x):
    return sin(x*x)        
