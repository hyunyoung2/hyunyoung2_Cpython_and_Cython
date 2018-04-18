from distutils.core import setup
from distutils.extension import Extension 
from Cython.Build import cythonize

ext_modules = [Extension("catoi", sources=["catoi.pyx"])]

setup(
   name = "atoi",
   ext_modules = cythonize(ext_modules)
)
     
