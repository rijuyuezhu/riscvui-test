#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
  assert(argc == 2);
  FILE *fr = fopen(argv[1], "r");
  assert(fr);

  char *tmp = (char *)malloc(strlen(argv[1]) + 2);
  strcpy(tmp, argv[1]);
  char *end = tmp + strlen(tmp);
  *end = *(end-1); --end;
  *end = *(end-1); --end;
  *end = *(end-1); --end;
  *end = *(end-1); --end;
  FILE *fw[4];
  for (int j = 0; j < 4; j++) {
    *end = j + '0';
    fw[j] = fopen(tmp, "w");
    assert(fw[j]);
  }
  free(tmp);
  uint32_t now;
  char buf[128];
  while (fscanf(fr, "%s", buf) == 1) {
    if (buf[0] == '@') {
      sscanf(buf, "@%x", &now);
      for (int j = 0; j < 4; j++)
        fprintf(fw[j], "@%x\n", now);
    } else {
      sscanf(buf, "%x", &now);
      uint8_t *byte = (uint8_t *)&now;
      for (int j = 0; j < 4; j++)
        fprintf(fw[j], "%02x\n", byte[j]);
    }
  }
  fclose(fr);
  for (int j = 0; j < 4; j++)
    fclose(fw[j]);
  return 0;
}
