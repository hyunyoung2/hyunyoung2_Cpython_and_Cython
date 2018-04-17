#!/usr/bin/env bash 

gcc -Wall -c add.c
gcc -Wall -c substraction.c
gcc -Wall -c main.c
gcc -Wall  main.o add.o substraction.o -o ./main_two_ways


./main_two_ways
