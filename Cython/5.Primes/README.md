# Primes

This is another example Extension module with Cython. 

Let's **prime.pyx** which is return the number of primes that you want. 


First's see the **prime.pyx** from [Cython Tutorial](http://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html#primes)


```python
def primes(int nb_primes):
    cdef int n, i, len_p
    cdef int p[1000]
    if nb_primes > 1000:
        nb_primes = 1000

    len_p = 0  # The current number of elements in p.
    n = 2
    while len_p < nb_primes:
        # Is n prime?
        for i in p[:len_p]:
            if n % i == 0:
                break

        # If no break occurred in the loop, we have a prime.
        else:
            p[len_p] = n
            len_p += 1
        n += 1

    # Let's return the result in a python list:
    result_as_list  = [prime for prime in p[:len_p]]
    return result_as_list
``` 

As you can see the code above, it starts out just like a normal function definition, except that the parameter nb_primes is declared to be of type **int**. This menas that the object passed will converted to a C integer(or a **TypeError** will be raised if it can't be).

**cdef** statement to define some local C variable, i.e. you can use static typing using **cdef** like do programming on C language.

Check if the prim module works as extension module with **import pyximport; pyximport.install()**

```python
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Primes [21:47:40] 
$ python3
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pyximport; pyximport.install()
(None, <pyximport.pyximport.PyxImporter object at 0x7f56bdc83ac8>)
>>> import prime
>>> prime.primes(10)
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
```

Additionally, If you want to check how much works Cython have save you from, pass the **annotate=True** to **cythonize()**, it will produce a HTML file. 

In this case, **prime.html** is created. So if you check the file on your browser. 

you would fine out white and yellow part, white part means there is no interaction with python.

But The darker the yellow is, the more python interaction ther is in the lin. 

you would fine out white and yellow part, white part means there is no interaction with python.

But The darker the yellow is, the more python interaction ther is in the line.

## Futher Let's compare Cython file to pure python compling with Cython

First, let's make **primes_python(nb_primes)** function like this:

```python
def primes_python(nb_primes):
    p = []
    n = 2
    while len(p) < nb_primes:
        # Is n prime?
        for i in p:
            if n % i == 0:
                break

        # If no break occurred in the loop
        else:
            p.append(n)
        n += 1
    return p
```

After it, Let's compile it above with Cython like this:

```python
from distutils.core import setup
from Cython.Build import cythonize

setup(
    name = "My prime app",
    ext_modules = cythonize(["prime.pyx",       # Cython cod file with primes() function 
                          "primes_python.py"],   # Python cod efile with primes_python function
                          annotate=True),  # accepts a glob pattern

) 
```

To compile, enter the command below:

> python3 setup.py build_ext --inplace

Finally, If you compare two programs whether or not the output is the same  like this :

```python
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Primes [13:11:54] 
$ python3 
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import prime
>>> import prime_python_cy
>>> import prime_python
>>> prime.primes(100) == prime_python_cy.prime_python(100)
True
>>> prime.primes(100) == prime_python.prime_python(100)
True
```

prime is Cython, and prime_python_cy is pure python code compiling with Cython. 

prime_python is pure python code not compiling with cython. 

As you can see the result above is the same. 

But the speed is different like this:

```shell
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Primes [13:19:47] C:1
$ python -m timeit -s "from prime import primes" "primes(1000)"
1000 loops, best of 3: 1.61 msec per loop
(env) 
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Primes [13:19:57] 
$ python -m timeit -s "from prime_python import prime_python" "prime_python(1000)"
10 loops, best of 3: 30.1 msec per loop
(env) 
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/Primes [13:20:02] 
$ python -m timeit -s "from prime_python_cy import prime_python" "prime_python(1000)"
10 loops, best of 3: 18.8 msec per loop
(env) 
```
  
Key point to focus on the measurement of each executable speed is as follows:

The cythonize version of primes python is 2 times fater than python one without changing a single line of code. The Cython version is 30 times faster than the Python version!

## cythonize(["prime.pyx"],annotate=True]

Cython has a way to visualise where interaction with Python object and Python's C-API is taking place. For this source, pass the **annotate=True** parameter to cythonize(). It produces a HTML file. Let's see

![](https://raw.githubusercontent.com/hyunyoung2/hyunyoung2.github.io/master/img/Image/NaturalLanguageProcessing/NLPLabs/Konltk_NLP/Cython/2018-04-18-Prime/Annotate.png)

If a line is white, it means that the code generated doesn't interatct with python, So will run as fast as normal C code. The darker the yellow, the more Python interaction there is in that line. 

Those yellow lines will usually operate on Python object, rasie exceptions, or do other kind of higher-level operations than what can easily be translated into simple and fast c code. The function declaration and return use the Python interpreter so it makes sense for those lines to be yellow. for the list comprehension, it involves the creation of a Python object. 

As you can see the number of line is 15(if n % i ==0 :), that is yellow because some check happens there. 

That is division checks at runtime, just python does.  

## \_\_pycache\_\_


If you import so file, \_\_pycache\_\_ doesn't appear, 

But If you import *.py, then \_\_pycache\_\_ appear.

Let's you have files like thefollowing

```shell
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/5.Primes on git:master x [20:57:59] 
$ ll
total 384K
drwxrwxr-x 3 hyunyoung2 hyunyoung2 4.0K  4월 17 20:57 build
-rw-rw-r-- 1 hyunyoung2 hyunyoung2 100K  4월 10 13:11 prime.c
-rwxrwxr-x 1 hyunyoung2 hyunyoung2  69K  4월 17 20:57 prime.cpython-35m-x86_64-linux-gnu.so
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  23K  4월 10 13:11 prime.html
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  281  4월 10 13:10 prime_python_cy.py
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  281  4월 10 13:09 prime_python.py
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  635  4월  9 21:13 prime.pyx
-rw-rw-r-- 1 hyunyoung2 hyunyoung2 5.3K  4월 17 20:13 README.md
-rwxr-xr-x 1 hyunyoung2 hyunyoung2   81  4월  9 21:54 run.sh
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  341  4월 17 20:57 setup.py
```

Then on python interpreter, If you type in like this:

```python
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/5.Primes on git:master x [21:27:16] 
$ python3
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import prime
>>> import prime_python_cy
>>> import prime_python
>>> 
```

after finishing the python interpreter, check the dir on the place 

```shell
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/Cython/5.Primes on git:master x [21:32:46] C:148
$ ll
total 388K
drwxrwxr-x 3 hyunyoung2 hyunyoung2 4.0K  4월 17 21:27 build
-rw-rw-r-- 1 hyunyoung2 hyunyoung2 100K  4월 10 13:11 prime.c
-rwxrwxr-x 1 hyunyoung2 hyunyoung2  69K  4월 17 21:27 prime.cpython-35m-x86_64-linux-gnu.so
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  23K  4월 10 13:11 prime.html
-rw-rw-r-- 1 hyunyoung2 hyunyoung2 131K  4월 17 21:20 prime_python_cy.c
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  23K  4월 17 21:20 prime_python_cy.html
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  281  4월 17 21:19 prime_python_cy.py
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  281  4월 10 13:09 prime_python.py
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  635  4월  9 21:13 prime.pyx
drwxrwxr-x 2 hyunyoung2 hyunyoung2 4.0K  4월 17 21:27 __pycache__
-rw-rw-r-- 1 hyunyoung2 hyunyoung2 5.3K  4월 17 20:13 README.md
-rwxr-xr-x 1 hyunyoung2 hyunyoung2   81  4월  9 21:54 run.sh
-rw-rw-r-- 1 hyunyoung2 hyunyoung2  341  4월 17 21:26 setup.py
```

As you can see the result above, \_\_pycache\_\_ appears. 


Let's see a little about \_\_pycache\_\_, 

Python stores the compoiled bytecode in that directory so that future import can use it directly rather than having to parse and compile the source again.

## Reference 

  - [Cython Tutorial's primes](http://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html#primes)
  - [Cython Tutorial's type conversion](http://cython.readthedocs.io/en/latest/src/userguide/language_basics.html#type-conversion)
  - [Cython Tutorial's memory allocation](http://cython.readthedocs.io/en/latest/src/tutorial/memory_allocation.html#memory-allocation)
  - [stackoverflow of \_\_pycache\_\_](https://stackoverflow.com/questions/16869024/what-is-pycache)
