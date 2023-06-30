using System;
using System.IO;

class bf {
    static int[] data = new int[30000];
    static int p = 0;
    static string s = "";

    static void Main(string[] args) {
        string filePath = args[0];
        string content = File.ReadAllText(filePath);
        s = content;
        ProcessBrainfuck(0);
    }

    static int ProcessBrainfuck(int loc) {
        int t = loc;
        while (t < s.Length) {
            char c = s[t];
            if (c == '+') data[p]++;
            if (c == '-') data[p]--;
            if (c == '>') p++;
            if (c == '<') p--;
            if (c == '.') Console.Write(Convert.ToChar(data[p]));
            if (c == '[') t = ProcessBrainfuck(t + 1);
            if (c == ']' && data[p] != 0) {
                if (data[p] != 0) return ProcessBrainfuck(loc);
                return t;
            }
            t++;
        }
        return s.Length;
    }
}

