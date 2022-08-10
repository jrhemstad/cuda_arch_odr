#cuda_arch_odr Test

Testing the behavior of linking TU's containing the same kernel compiled with different architectures.

Given two TUs, `a.cu` and `b.cu`, where they invoke the same kernel but each is compiled with distinct archictures, which kernel is found when attempting to ODR-use it? 

