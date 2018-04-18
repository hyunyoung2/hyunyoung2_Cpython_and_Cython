# Python3's Building Python with C or C++

If you want make extension module with C or C++ above python 3.x, 

First You have to include **Python.h** on top of your c source file which gives you access to the internal Python API used to hook your module into interpreter. it is call CPython C-API.

Before including **python.h**, check if you have installed python3-dev with apt like **sudo apt install python3-dev**

Then You need to connect c source file to python. Normally The signature of the C implementation of your function always takes one of the following three times:

```c
static PyObject *MyFunction( PyObject *self, PyObject *args );

static PyObject *MyFunctionWithKeywords(PyObject *self,
                                 PyObject *args,
                                 PyObject *kw);

static PyObject *MyFunctionWithNoArgs( PyObject *self );
```

i.e. You need to define python module function, its c function usually are named by combination the Python module and function names together like this :

```c 
static PyObject *module_func(PyObject *self, PyObject *args) {
   /* Do your stuff here. */
   Py_RETURN_NONE;
}
```

The following example :

```c
static PyObject * spam_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    return PyLong_FromLong(sts);
}
```


Second, you need to define method structure like this :

```c
struct PyMethodDef {
   char *ml_name;
   PyCFunction ml_meth;
   int ml_flags;
   char *ml_doc;
};
```

-  ml_name − This is the name of the function as the Python interpreter presents when it is used in Python programs.

-  ml_meth − This must be the address to a function that has any one of the signatures described in previous seection.

-  ml_flags − This tells the interpreter which of the three signatures ml_meth is using.

   -  This flag usually has a value of METH_VARARGS.

   -  This flag can be bitwise OR'ed with METH_KEYWORDS if you want to allow keyword arguments into your function.

   -  This can also have a value of METH_NOARGS that indicates you do not want to accept any arguments.

- ml_doc − This is the docstring for the function, which could be NULL if you do not feel like writing one.


The following is example.


```c 
static PyMethodDef SpamMethods[] = {
    ...
    {"system",  spam_system, METH_VARARGS,
     "Execute a shell command."},
    ...
    {NULL, NULL, 0, NULL}        /* Sentinel */
};
```

As you can see above thing, this method table needs to be terminated a sentinel that consists of NULL and 0 Value for the appropriate members.

Third, you need to define module table in python3 like this :

```c
static struct PyModuleDef spammodule = {
   PyModuleDef_HEAD_INIT,
   "spam",   /* name of module */
   spam_doc, /* module documentation, may be NULL */
   -1,       /* size of per-interpreter state of the module,
                or -1 if the module keeps state in global variables. */
   SpamMethods
};
```

This struction must be passed to the interpreter in the module's initialization function. the initialization function must be named PyInit_name(), where name is the name of the module, and should be the only non-static item defined in the module file: 

Finally, You need to define PyInit function like this :

```c
PyMODINIT_FUNC PyInit_spam(void)
{
    return PyModule_Create(&spammodule);
}
```

Be careful of the final function, PyInit_function have to use PyModule_Create(&module_table) in python3


But If you want to use multi-phase initialization as Python source distribution as **Modules/xxmodule.c** like this : 

```c
static struct PyModuleDef xxmodule = {
    PyModuleDef_HEAD_INIT,
    "xx",
    module_doc,
    0,
    xx_methods,
    xx_slots,
    NULL,
    NULL,
    NULL
};

/* Export function for the module (*must* be called PyInit_xx) */

PyMODINIT_FUNC
PyInit_xx(void)
{
    return PyModuleDef_Init(&xxmodule);
}
```

This is using **PyModuleDef_Init(&xxmodule)** and look at module table, xxmodule,above.


From now on, just see an example. 

```c 
## In Example_of_Python_C_API.c
#include <Python.h>

static PyObject *SpamError;


static PyObject *
spam_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    if (sts < 0) {
        PyErr_SetString(SpamError, "System command failed");
        return NULL;
    }
    return PyLong_FromLong(sts);
}

static PyMethodDef SpamMethods[] = {
    {"system",  spam_system, METH_VARARGS,
     "Execute a shell command."},

    {NULL, NULL, 0, NULL}        /* Sentinel */
};

static char spam_doc [] =
   "helloworld( ): Any message you want to put here!!\n";

static struct PyModuleDef spammodule = {
   PyModuleDef_HEAD_INIT,
   "spam",   /* name of module */
   spam_doc, /* module documentation, may be NULL */
   -1,       /* size of per-interpreter state of the module,
                or -1 if the module keeps state in global variables. */
   SpamMethods
};

PyMODINIT_FUNC
PyInit_spam(void)
{
    PyObject *m;

    m = PyModule_Create(&spammodule);
    if (m == NULL)
        return NULL;

    SpamError = PyErr_NewException("spam.error", NULL, NULL);
    Py_INCREF(SpamError);
    PyModule_AddObject(m, "error", SpamError);
    return m;
}

```

> python3 setup.py build_ext \-\-inplace

The following is the result of the command above 

```shell
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/CPython/Python3/exception on git:master x [22:27:45] 
$ ./run.sh 
running build_ext
building 'spam' extension
creating build
creating build/temp.linux-x86_64-3.5
x86_64-linux-gnu-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I/home/hyunyoung2/Labs/Konltk/Cython/env/include -I/usr/include/python3.5m -c Example_of_Python_C_API.c -o build/temp.linux-x86_64-3.5/Example_of_Python_C_API.o
x86_64-linux-gnu-gcc -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-functions -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-Bsymbolic-functions -Wl,-z,relro -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 build/temp.linux-x86_64-3.5/Example_of_Python_C_API.o -o /home/hyunyoung2/Labs/Konltk/CPython/Python3/exception/spam.cpython-35m-x86_64-linux-gnu.so
(env) 
```

Let's see setup.py 

```python
from distutils.core import setup, Extension

setup(name="test",  version="1.0",\
     ext_modules=[Extension("spam", ["Example_of_Python_C_API.c"])])
``` 

The following is the result using **spam.so** file to import like this:

```python
# hyunyoung2 @ hyunyoung2-desktop in ~/Labs/Konltk/CPython/Python3/exception on git:master x [22:29:55] 
$ python3
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import spam
>>> spam.system("ls -1")
build
Example_of_Python_C_API.c
README.md
run.sh
setup.py
spam.cpython-35m-x86_64-linux-gnu.so
0
```

# Reference 

 - [Tutorial](https://www.tutorialspoint.com/python/python_further_extensions.htm)
 - [python 3.5 building python with c or c++](https://docs.python.org/3.5/extending/extending.html)
 - [An example for python extension module](https://github.com/python/cpython/blob/master/Modules/xxmodule.c)
 - [Youtube](https://www.youtube.com/watch?v=bfmslcTKriw)
