use std::env;
use std::fs;
use std::io;

fn process_brainfuck(data: &mut Vec<i32>, p: &mut usize, s: &str, loc: usize) -> usize {
    let mut t = loc;
    let chars: Vec<char> = s.chars().collect();
    while t < chars.len() {
        let c = chars[t];
        if c == '+' { data[*p] = data[*p].wrapping_add(1); }
        if c == '-' { data[*p] = data[*p].wrapping_sub(1); }
        if c == '>' { *p += 1; }
        if c == '<' { *p -= 1; }
        if c == '.' { print!("{}", data[*p] as u8 as char); }
        if c == ',' {
            let mut input = String::new();
            io::stdin().read_line(&mut input).expect("Failed to read input");
            data[*p] = input.chars().next().unwrap() as i32;
        }
        if c == '[' { t = process_brainfuck(data, p, s, t + 1); }
        if c == ']' && data[*p] != 0 {
            if data[*p] != 0 { return process_brainfuck(data, p, s, loc); }
            return t;
        }
        t += 1;
    }
    return chars.len();
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let file_path = &args[1];
    if let Ok(content) = fs::read_to_string(file_path) {
        let mut data = vec![0; 30000];
        let mut p = 0;
        let s = content.trim();
        process_brainfuck(&mut data, &mut p, s, 0);
    }
}

