#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
  assert(argc == 3);
  const char *from = argv[1]; // binary
  const char *to = argv[2];   // text

  FILE *fp = fopen(from, "rb");
  assert(fp);
  size_t siz = 0;
  assert(fseek(fp, 0, SEEK_END) != -1);
  siz = ftell(fp);
  uint8_t *content = (uint8_t *)malloc(sizeof(uint8_t) * (siz + 4));
  rewind(fp);
  assert(fread(content, sizeof(uint8_t) * siz, 1, fp) == 1);
  fclose(fp);

  int nowsiz = 4 * ((siz + 3) / 4);
  for (int i = siz; i < nowsiz; i++)
    content[i] = 0;

  fp = fopen(to, "w");
  assert(fp);
  fprintf(fp, "@0\n");
  FILE *fdis[4];
  char *tmp = (char *)malloc(sizeof(char) * (strlen(to) + 2));
  assert(tmp);
  strcpy(tmp, to);
  char *num = tmp + strlen(to);
  *num = *(num-1); num--;
  *num = *(num-1); num--;
  *num = *(num-1); num--;
  *num = *(num-1); num--;
  for (int j = 0; j < 4; j++) {
    *num = j + '0';
    fdis[j] = fopen(tmp, "w");
    fprintf(fdis[j], "@0\n");
  }
  free(tmp);
  for (int i = 0; i < nowsiz; i += 4) {
    fprintf(fp, "%02x%02x%02x%02x\n", content[i+3], content[i+2], content[i+1], content[i]);
    for (int j = 0; j < 4; j++)
      fprintf(fdis[j], "%02x\n", content[i+j]);
  }
  free(content);
  for (int j = 0; j < 4; j++)
    fclose(fdis[j]);
  fclose(fp);
  return 0;
}
