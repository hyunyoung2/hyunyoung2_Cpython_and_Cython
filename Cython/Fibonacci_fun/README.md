# Fibonacci Fun 

This is for practice for Cython extension 

Firts, Let's make **fib.pyx** For Extension module 

```python3
from __future__ import print_function

def fib(n):
    """Print the Fibonacci series up to n."""
    a, b = 0, 1
    while b < n:
        print(b, end=' ')
        a, b = b, a + b

    print()
```

After it, In this case, we have to make **setup.py** like this: 
 
```python3 
from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize("fib.pyx"),
)
```

Run the following command on prompt: 

> python setup.py build_ext --inplace

The following is the result of running the command above 

```shell
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Fibonacci_fun on git:master x [20:01:00] 
$ ./run.sh 
running build_ext
building 'fib' extension
creating build
creating build/temp.linux-x86_64-3.5
x86_64-linux-gnu-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I/home/hyunyoung2/Labs/Konltk/Cython/env/include -I/usr/include/python3.5m -c fib.c -o build/temp.linux-x86_64-3.5/fib.o
x86_64-linux-gnu-gcc -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-functions -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-Bsymbolic-functions -Wl,-z,relro -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 build/temp.linux-x86_64-3.5/fib.o -o /home/hyunyoung2/Labs/Konltk/Cython/Fibonacci_fun/fib.cpython-35m-x86_64-linux-gnu.so
```



Finally, check if it works as python extension module 

```python
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Fibonacci_fun [18:20:30] 
$ python3 
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import fib
>>> fib.fib(200)
1 1 2 3 5 8 13 21 34 55 89 144 
```

## Reference 

 - [Cython's Tutorial about Fibonacci fun for Extension module](http://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html)
