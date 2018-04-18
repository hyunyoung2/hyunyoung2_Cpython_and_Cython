from distutils.core import setup
from distutils.extension import Extension 
from Cython.Build import cythonize

ext_modules = [Extension("Cpython_version", sources=["Cpython_version.pyx"])]

setup(
   name = "version check",
   ext_modules = cythonize(ext_modules)
)
     
