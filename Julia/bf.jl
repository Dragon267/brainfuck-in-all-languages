data = zeros(Int, 30000)
global p = 1
global s = ""

function process(loc)
    t = loc
    while t <= length(s)
        c = s[t]
        if c == '+'
            data[p] += 1
        elseif c == '-'
            data[p] -= 1
        elseif c == '>'
            global p += 1
        elseif c == '<'
            global p -= 1
        elseif c == ','
            cc = read(stdin, Char)
            data[p] = Int(cc)
        elseif c == '.'
            print(Char(data[p]))
        elseif c == '['
            t = process(t + 1)
        elseif c == ']' && data[p] != 0
            if data[p] != 0
                return process(loc)
            end
            return t
        end
        t += 1
    end
    return length(s)
end

function main(a, b)
    global data, s
    fill!(data, 0)
    fileName = b[1]
    file = open(fileName)

    if file !== nothing
        s = read(file, String)
        process(1)
        close(file)
    else
        println("Failed to open the file.")
    end
    return 0
end

args = ARGS
main(length(args), args)

