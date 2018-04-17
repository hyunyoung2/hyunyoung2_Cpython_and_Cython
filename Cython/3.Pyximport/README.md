# pyximport

If your module doesn't require any extra C library or a special build setup, then you can use the pyximport module, originally developed by Paul Prescod, to load .pyx files directly on import, without having to run your **setup.py** file each time you change your code.

Let's do it 

First, make the cython code as follows:

The file name is hello.pyx
```python 
in hellow.pyx file 
print("Hellow world!")
```

Finally without having to run **setup.py**, import the Cython extension with **pyximport**

```python
$ python3 
Python 3.5.2 (default, Nov 23 2017, 16:37:01) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pyximport; pyximport.install()
(None, <pyximport.pyximport.PyxImporter object at 0x7ff03ce27ac8>)
>>> import hellow
Hello world!
```

## Reference 

  [Cython tutorial's pyximport](http://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html#pyximport-cython-compilation-for-developers)
