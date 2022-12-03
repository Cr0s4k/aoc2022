# frozen_string_literal: true
require 'set'

input = File.read('in.txt')

def make_hash(str)
  str
    .split("")
    .reduce({}) { |acc, x|
      acc[x] = true
      acc
    }
end

def is_upper?(char)
  char.ord >= 65 && char.ord <= 90
end

def get_priority(rucksack)
  middle = rucksack.length / 2
  hash = make_hash(rucksack[0..middle - 1])

  char = rucksack[middle..]
    .split("")
    .find {|x| hash[x]}

  return char.ord - 38 if is_upper?(char)

  char.ord - 96
end

p1 = input
  .split("\n")
  .map { |x| get_priority(x) }
  .sum

p p1

# part 2

def get_priority_from_group(group)
  hash1 = make_hash(group[0])
  hash2 = make_hash(group[1])

  char = group[2]
    .split("")
    .find {|x| hash1[x] && hash2[x]}

  return char.ord - 38 if is_upper?(char)

  char.ord - 96
end

p2 = input
  .split("\n")
  .each_slice(3)
  .to_a()
  .map { |x| get_priority_from_group(x) }
  .sum

p p2
