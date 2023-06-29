package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

var data [30000]int
var p int
var s string

func processBrainfuck(loc int) int {
	t := loc
	for t < len(s) {
		c := s[t]
		if c == '+' { data[p]++ }
		if c == '-' { data[p]-- }
		if c == '>' { p++ }
		if c == '<' { p-- }
		if c == '.' { fmt.Print(string(data[p])) }
    if c == ',' { var ch rune; fmt.Scanf("%c", &ch); data[p] = int(ch); }
		if c == '[' { t = processBrainfuck(t + 1) }
		if c == ']' && data[p] != 0 {
			if data[p] != 0 { return processBrainfuck(loc) }
			return t
		}
		t++
	}
	return len(s)
}

func main() {
	filePath := os.Args[1]
	content, err := ioutil.ReadFile(filePath)
	if err != nil {
		fmt.Println(err)
		return
	}
	s = string(content)
	processBrainfuck(0)
}

