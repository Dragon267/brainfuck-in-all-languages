<?php

$data = array_fill(0, 30000, 0);
$p = 0;
$s = "";

function process_brainfuck($loc) {
  global $data, $p, $s;

  $t = $loc;
  while ($t < strlen($s)) {
    $c = $s[$t];
    if ($c == '+') { $data[$p]++; }
    if ($c == '-') { $data[$p]--; }
    if ($c == '>') { $p++; }
    if ($c == '<') { $p--; }
    if ($c == '.') { echo chr($data[$p]); }
    if ($c == '[') { $t = process_brainfuck($t + 1); }
    if ($c == ']' && $data[$p] != 0) {
      if ($data[$p] != 0) return process_brainfuck($loc);
      return $t;
    }
    $t++;
  }
  return strlen($s);
}

$filePath = $argv[1];
$content = file_get_contents($filePath);
if ($content === false) {
  echo "Error reading file: $filePath";
  return;
}
$s = $content;
process_brainfuck(0);

?>

