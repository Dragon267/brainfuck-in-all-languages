#include <stdio.h>
#include <string.h>

int data[30000], p = 0;
char s[30000];

int process(int loc) {
  int t = loc;
  while (t < strlen(s)) {
    char c = s[t];
    if (c == '+') data[p]++;
    if (c == '-') data[p]--;
    if (c == '>') p++;
    if (c == '<') p--;
    if (c == ',') {
      char cc;
      scanf("%c", &cc);
      data[p] = (int)cc;
    }
    if (c == '.') printf("%c", (char)data[p]);
    if (c == '[') t = process(t + 1);
    if (c == ']' && data[p] != 0) {
      if (data[p] != 0) return process(loc);
      return t;
    }
    t++;
  }
  return strlen(s);
}

int main(int argc, char* argv[]) {
  memset(data, 0, sizeof(data));
  char* fileName = argv[1];
  FILE* file = fopen(fileName, "r");

  if (file != NULL) {
    fread(s, sizeof(char), sizeof(s), file);
    process(0);
    fclose(file);
  } else printf("Failed to open the file.");
  return 0;
}

