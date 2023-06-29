import sys
import os

data = [0] * 30000
s = ""
p = 0

def process(loc):
    global p
    t = loc;
    while (t < len(s)):
        c = s[t]
        if (c == '+'): data[p] += 1
        if (c == '-'): data[p] -= 1
        if (c == '>'): p += 1;
        if (c == '<'): p -= 1;
        if (c == '.'): print(chr(data[p]), end='')
        if (c == '['): t = process(t + 1)
        if c == ']' and data[p] != 0:
            if data[p] != 0:
                return process(loc);
            return t;
        t += 1
    return len(s)

s = open(os.getcwd() + "/" + sys.argv[1], 'r').read()
process(0)
