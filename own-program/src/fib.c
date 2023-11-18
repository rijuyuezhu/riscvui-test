#include <stdio.h>
#include "dummy.h"
#define N 20

int f[N+1];

int main() {
  f[0] = 0;
  f[1] = 1;
  for (int i = 2; i <= N; i++)
    f[i] = f[i-1] + f[i-2];
  return f[N];
}
