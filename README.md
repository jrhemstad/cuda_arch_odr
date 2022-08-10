# cuda_arch_odr Test

Testing the behavior of linking TU's containing the same kernel compiled with different architectures.

Given two TUs, `a.cu` and `b.cu`, where they invoke the same kernel but each is compiled with distinct archictures, which kernel is found when attempting to ODR-use it?

The answer appears to be very complicated and depends on a relationship among:
- Static vs Dynamic linking
- Internal vs External kernel linkage 
- Internal vs External linkage of function ODR-using the kernel
- static vs anonymous namespace used for internal linkage!?

Naively, you might expect simply marking the kernel to have internal linkage by annotating it with `static` would resolve the issue, but it *does not*. 
It appears to also depend on the linkage of the enclosing function.


| Works? |  Linker | kernel() annotation | test()  | test() anon namespace |
|:------:|:-------:|:-------------------:|:-------:|:---------------------:|
|        |  Static |                     |  static |           N           |
|        |  Static |                     |  inline |           N           |
|    Y   |  Static |        static       |  static |           N           |
|        |  Static |        static       |  inline |           N           |
|    Y   |  Static |        static       |         |           Y           |
|        |  Static |                     |         |           Y           |
|    Y   | Dynamic |                     |  static |           N           |
|        | Dynamic |                     |  inline |           N           |
|    Y   | Dynamic |        static       |  static |           N           |
|        | Dynamic |        static       |  inline |           N           |
|    Y   | Dynamic |        static       |         |           Y           |
|    Y   | Dynamic |                     |         |           Y           |

## Usage

See the `build.sh` script which builds/runs the experiment under the various scenarios described in the table.