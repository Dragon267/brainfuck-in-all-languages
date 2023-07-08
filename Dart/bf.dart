import 'dart:io';

List<int> data = List<int>.filled(30000, 0);
String s = '';
int p = 0;

int process(int loc) {
  int t = loc;
  while (t < s.length) {
    String c = s[t];
    if (c == '+') data[p]++;
    if (c == '-') data[p]--;
    if (c == '>') p++;
    if (c == '<') p--;
    if (c == '.') stdout.write(String.fromCharCode(data[p]));
    if (c == ',') data[p] = stdin.readByteSync();
    if (c == '[') t = process(t + 1);
    if (c == ']' && data[p] != 0) {
      if (data[p] != 0) {
        return process(loc);
      }
      return t;
    }
    t++;
  }
  return s.length;
}

void main(List<String> arguments) {
  String filePath = '${Directory.current.path}/${arguments[0]}';
  s = File(filePath).readAsStringSync();
  process(0);
}

