#pragma once

#include <cstdio>

#ifndef KERNEL_ANNOTATION
#define KERNEL_ANNOTATION
#endif

#ifndef TEST_ANNOTATION
#define TEST_ANNOTATION
#endif


template <typename T>
KERNEL_ANNOTATION __global__ void kernel(){}


#if defined(TEST_ANON_NS)
namespace{
#endif

TEST_ANNOTATION int test(){
   cudaFuncAttributes attrs;
   cudaFuncGetAttributes(&attrs, reinterpret_cast<void *>(kernel<void>));
   return attrs.ptxVersion*10;
}

#if defined(TEST_ANON_NS)
} // anonymous
#endif
