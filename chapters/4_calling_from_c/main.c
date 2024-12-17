#include <stdio.h>
#include <inttypes.h>

uint64_t asm_func();
void print_binary(uint64_t);

int main() {
  uint64_t result = asm_func();
  printf("SGN: %" PRId64 "\n", (int64_t) result);   // 64-bit number
  printf("DEC: %" PRIu64 "\n", result);             // 32-bit Decimal Number
  printf("HEX: %" PRIx64 "\n", result);             // 32-bit Hexadecimal Number
  print_binary(result);                             // 64-bit binary representation
  return 0;
}

void print_binary(uint64_t number) {
  char str[64];

  for(int i = 63; i >= 0; i--) {
    if(number & 1 > 0) str[i] = '1';
    else str[i] = '0';
    number = number >> 1;
  }

  printf("BIN: ");

  for(int i = 0; i < 64; i++) {
    printf("%c", str[i]);
    if(i % 8 == 7) printf(" ");
  }

  printf("\n");
}
