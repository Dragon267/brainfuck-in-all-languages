const fs = require('fs');

let data = new Array(30000).fill(0);
let p = 0;
let s = "";

function process_brainfuck(loc) {
  let t = loc;
  while (t < s.length) {
    let c = s[t];
    if (c == '+') { data[p]++; }
    if (c == '-') { data[p]--; }
    if (c == '>') { p++; }
    if (c == '<') { p--; }
    if (c == '.') { process.stdout.write(String.fromCharCode(data[p])); }
    if (c == '[') { t = process_brainfuck(t + 1); }
    if (c == ']' && data[p] != 0) {
      if (data[p] != 0) return process_brainfuck(loc);
      return t;
    }
    t++;
  }
  return s.length;
}

const filePath = process.argv[2];
fs.readFile(filePath, 'utf8', (err, content) => {
  if (err) {
    console.error(err);
    return;
  }
  s = content;
  process_brainfuck(0);
});


