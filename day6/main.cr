input = File.read("./in.txt")

def are_all_diff?(chars : Array(String)) : Bool
  set = chars.to_set
  set.size == chars.size
end

def solve(input, diff_chars_count : Int32) : Int32
  chars = input.split("")

  i = 0
  while (i + diff_chars_count - 1 < chars.size) && !are_all_diff?(chars[i..i + diff_chars_count - 1])
    i = i + 1
  end

  i + diff_chars_count
end

p1 = solve(input, 4)

p p1

p2 = solve(input, 14)

p p2
