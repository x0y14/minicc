#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "引数の個数が正しくありません\n");
        return 1;
    }

    printf(".section .text:\n");
    printf("  global _start\n");
    printf("_start:\n");
    printf("  mov r1 %d\n", atoi(argv[1]));
    printf("  mov r0 0\n");
    printf("  syscall\n");
    return 0;
}