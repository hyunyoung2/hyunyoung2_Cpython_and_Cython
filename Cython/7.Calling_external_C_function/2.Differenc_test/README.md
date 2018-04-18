# Different way

Let's only have **add.c** , **c_function.pxd** , **function.pyx** and **substraction.c**. 

So Let's see the **c_function.pxd** and **function.pyx**

```python
## In function.pyx
from c_function cimport sum_function, substraction_function

def sum(int a, int b):
    print("sum function is called!")
    return sum_function(a, b)

def substraction(int a, int b):
    print("substraction function is called!")
    return substraction_function(a, b)

## In C_function.pxd
cdef extern from "add.c":
    int sum_function(int a, int b)

cdef extern from "substraction.c":
    int substraction_function(int a, int b)
``` 

As you can notice, the thing above don't use header file, They are including directly from **.c** file. 

be care of make **.so** file at the time. 

Let's see **setup.py**

```python
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

ext_modules = [Extension("operator", ["function.pyx"])]

setup(
    name="sum and substraction function",
    ext_modules = cythonize(ext_modules)
)
```

In here, the source part is only one, **function.pyx**
