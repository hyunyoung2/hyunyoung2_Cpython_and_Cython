from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

ext_modules=[
    Extension("sin",
              sources=["sin.pyx"],
              libraries=["m"] # Unix-like specific
    )
]

setup(
  name = "sin",
  ext_modules = cythonize(ext_modules)
)
