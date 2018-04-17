from distutils.core import setup
from Cython.Build import cythonize

setup(
    name = "My prime app",
    ext_modules = cythonize(["prime.pyx",	# Cython cod file with primes() function 
			  "prime_python_cy.py"],   # Python code file with primes_python function
                          annotate=True),  # accepts a glob pattern
    
)
