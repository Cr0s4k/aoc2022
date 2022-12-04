input = File.read("in.txt")

def make_hash(str)
  str
    .split("")
    .each_with_object({} of String => Bool) do |x, acc|
      acc[x] = true
    end
end

def upper?(char : Char)
  char.ord >= 65 && char.ord <= 90
end

def get_priority(rucksack) : Int32
  middle = (rucksack.size / 2).to_i
  hash = make_hash(rucksack.byte_slice(0, middle))

  letter = rucksack.byte_slice(middle)
    .split("")
    .find { |x| hash.fetch(x, nil) }

  raise "error" if !letter

  char = letter.char_at(0)

  return char.ord - 38 if upper?(char)

  char.ord - 96
end

p1 = input
  .split("\n")
  .reject { |x| x == "" }
  .map { |x| get_priority(x) }
  .sum

p p1

# part 2

def get_priority_from_group(group)
  hash1 = make_hash(group[0])
  hash2 = make_hash(group[1])

  letter = group[2]
    .split("")
    .find { |x| hash1.fetch(x, nil) && hash2.fetch(x, nil) }

  raise "error" if !letter
  
  char = letter.char_at(0)

  return char.ord - 38 if upper?(char)

  char.ord - 96
end

p2 = input
  .split("\n")
  .reject { |x| x == ""}
  .each_slice(3)
  .to_a
  .map { |x| get_priority_from_group(x) }
  .sum

p p2
