from libc.math cimport sin

cdef double f(double x):
   print("f function")
   return sin(x*x)

# If cython does not provide, 
cdef extern from "math.h":
   double sin(double x)

cdef extern from "math.h":
   cpdef double cos(double x)

def call_f(double x):
   return f(x)

def call_sin(double x):
   print("math.h")
   return sin(x)
