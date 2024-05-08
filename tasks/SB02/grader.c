#include <stdio.h>
#include "SB02.h"

int main() {
    int n;
    while (scanf("%d", &n) == 1) {
        printf("%d\n", factorial(n));
    }
    return 0;
}