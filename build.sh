#!/bin/bash

static_linker_test(){
   echo "Static Linker w/ $1"
   nvcc -c -arch=sm_52 $1 a.cu
   nvcc -c -arch=sm_70 $1 b.cu
   nvcc -c main.cpp
   nvcc -o test_static main.o a.o b.o 
   ./test_static
   echo ""
}

static_linker_test "-DTEST_ANNOTATION=static" 
static_linker_test "-DTEST_ANNOTATION=inline" 
static_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANNOTATION=static" 
static_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANNOTATION=inline"
static_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANON_NS"
static_linker_test "-DTEST_ANON_NS"

dynamic_linker_test(){
   echo "Dynamic Linker w/ $1"
   nvcc -shared -Xcompiler -fPIC -arch=sm_52 $1 -o a.so a.cu
   nvcc -shared -Xcompiler -fPIC -arch=sm_70 $1 -o b.so b.cu
   nvcc -c main.cpp
   nvcc -o test_dyanmic main.o a.so b.so 
   ./test_dyanmic
   echo ""
}

dynamic_linker_test "-DTEST_ANNOTATION=static" 
dynamic_linker_test "-DTEST_ANNOTATION=inline" 
dynamic_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANNOTATION=static" 
dynamic_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANNOTATION=inline"
dynamic_linker_test "-DKERNEL_ANNOTATION=static -DTEST_ANON_NS"
dynamic_linker_test "-DTEST_ANON_NS"
