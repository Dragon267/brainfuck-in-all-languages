local data = {}
local p = 1
local s = ""

function process(loc)
  local t = loc
  while t <= #s do
    local c = s:sub(t, t)
    if c == "+" then
      data[p] = (data[p] or 0) + 1
    elseif c == "-" then
      data[p] = (data[p] or 0) - 1
    elseif c == ">" then
      p = p + 1
    elseif c == "<" then
      p = p - 1
    elseif c == "," then
      io.write("Input: ")
      local cc = io.read(1):byte()
      data[p] = cc
    elseif c == "." then
      io.write(string.char(data[p] or 0))
    elseif c == "[" then
      t = process(t + 1)
    elseif c == "]" and (data[p] or 0) ~= 0 then
      if (data[p] or 0) ~= 0 then
        return process(loc)
      end
      return t
    end
    t = t + 1
  end
  return #s
end

data = {}
p = 1
local fileName = arg[1]
local file = io.open(fileName, "r")

if file then
  s = file:read("*all")
  process(1)
  file:close()
else
  print("Failed to open the file.")
end

