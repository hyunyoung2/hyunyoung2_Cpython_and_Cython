from libc.stdlib cimport atoi

cdef parse_charptr_to_py_int(char* s):
    assert s is not NULL, "byte string value is NULL"
    return atoi(s)   # note: atoi() has no error detection!

def atoi_cython(char *s):
    print("parse_charptr_to_py_int fucntion called!")
    return parse_charptr_to_py_int(s)


from cpython.version cimport PY_VERSION_HEX

# print version >= 3.2 final ?
print(PY_VERSION_HEX >= 0x030200F0)


from libc.math cimport sin

cdef double f(double x):
    return sin(x*x)

def sin_f(double x):
    print("f function called!")
    return f(x)

cdef extern from "math.h":
    double sin(double x)

def math_sin(double x):
    print("extern function sin called!")
    return sin(x)


cdef extern from "math.h":
    cpdef double cos(double x)

def math_cos(double x):
    print("cpdef double cos function!")
    return cos(x)
