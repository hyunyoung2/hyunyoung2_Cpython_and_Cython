from distutils.core import setup, Extension

setup(name="test",  version="1.0",\
     ext_modules=[Extension("spam", ["Example_of_Python_C_API.c"])])
