
#include <cstdio>

// For conveience, forward declare functions instead of needing extra headers
int A();
int B();

int main() {
  int a = A();
  int b = B();
  printf("A: %d B: %d %s \n", a, b, (a == b) ? "FAIL" : "SUCCESS");
}
