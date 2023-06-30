package Java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class bf {
    private static int[] data = new int[30000];
    private static int p = 0;
    private static String s;

    private static int process(int loc) {
        int t = loc;
        while (t < s.length()) {
            char c = s.charAt(t);
            if (c == '+') data[p]++;
            if (c == '-') data[p]--;
            if (c == '>') p++;
            if (c == '<') p--;
            if (c == ',') {
                try {
                    int cc = System.in.read();
                    data[p] = cc;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (c == '.') System.out.printf("%c", (char) data[p]);
            if (c == '[') t = process(t + 1);
            if (c == ']' && data[p] != 0) {
                if (data[p] != 0) return process(loc);
                return t;
            }
            t++;
        }
        return s.length();
    }

    public static void main(String[] args) {
        String fileName = args[0];
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(fileName));
            StringBuilder builder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
            }
            s = builder.toString();
            process(0);
        } catch (IOException e) {
            System.out.println("Failed to open the file.");
        }
    }
}

