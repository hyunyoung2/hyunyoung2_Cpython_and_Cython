from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize 

ext_modules = [Extension("operator", ["function.pyx"])]

setup(
    name="sum and substraction function",
    ext_modules = cythonize(ext_modules)
)

