#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  char *test = malloc(sizeof(char) + 1);
  test = "1\0";
  printf("Testing %s\n", test);

  return 0;
}
