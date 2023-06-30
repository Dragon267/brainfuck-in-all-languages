data = Array.new(30000, 0)
p = 0
s = ""

def process_brainfuck(loc, data, p, s)
  t = loc
  while t < s.length do
    c = s[t]
    if c == '+'
      data[p] += 1
    elsif c == '-'
      data[p] -= 1
    elsif c == '>'
      p += 1
    elsif c == '<'
      p -= 1
    elsif c == '.'
      print data[p].chr
    elsif c == '['
      t = process_brainfuck(t + 1, data, p, s)
    elsif c == ']' && data[p] != 0
      if data[p] != 0
        return process_brainfuck(loc, data, p, s)
      end
      return t
    end
    t += 1
  end
  return s.length
end

filePath = ARGV[0]
File.open(filePath, 'r') do |file|
  s = file.read
  process_brainfuck(0, data, p, s)
end

