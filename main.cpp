
#include <cstdio>

extern int A();
extern int B();

int main() {
  int a = A();
  int b = B();
  printf("A: %d B: %d %s \n", a, b, (a == b) ? "FAIL" : "SUCCESS");
}
