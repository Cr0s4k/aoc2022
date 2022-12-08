input = File.read("in.txt")

# part 1

part1 = input
  .split("\n\n")
  .map do |x|
    x
      .split("\n")
      .reject { |y| y == "" }
      .sum(&.to_i)
  end
  .max

p part1

# part 2

part2 = input
  .split("\n\n")
  .map do |x|
    x
      .split("\n")
      .reject { |y| y == "" }
      .sum(&.to_i)
  end
  .sort!
  .[-3, 3]
  .sum

p part2
