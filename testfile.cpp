#include "testfile.hpp"

int arr[1];
int v;

int sum(int a, int b) {
  for(int i = 0; i < 2; i++) {
    v = arr[i];
  }
  return a + b;
}

int diff(int a, int b) {
  return a - b;
}