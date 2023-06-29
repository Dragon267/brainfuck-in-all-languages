#include <iostream>
#include <fstream>

int data[30000], p = 0;
std::string s;

int process(int loc) {
  int t = loc;
  while (t < s.size()) {
    char c = s[t];
    if (c == '+') data[p]++;
    if (c == '-') data[p]--;
    if (c == '>') p++;
    if (c == '<') p--;
    if (c == '.') std::printf("%c", char(data[p]));
    if (c == '[') t = process(t + 1);
    if (c == ']' && data[p] != 0) {
      if (data[p] != 0) return process(loc);
      return t;
    }
    t++;
  }
  return s.size();
}

int main(int a, char* b[]) {
	std::memset(data, 0, sizeof(data));
  std::string fileName = b[1];
  std::ifstream file(fileName);

  if (file.is_open()) {
      s = std::string((std::istreambuf_iterator<char>(file)), (std::istreambuf_iterator<char>()));
      process(0);
      file.close();
  } else printf("Failed to open the file.");
  return 0;
}
