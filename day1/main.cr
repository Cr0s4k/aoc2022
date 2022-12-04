input = File.read("in.txt")

# part 1

part1 = input
  .split("\n\n")
  .map do |x|
    x
      .split("\n")
      .reject { |x| x == "" }
      .map { |y| y.to_i }
      .sum
  end
  .max

p part1

# part 2

part2 = input
  .split("\n\n")
  .map do |x|
    x
      .split("\n")
      .reject { |x| x == "" }
      .map { |y| y.to_i }
      .sum
  end
  .sort
  .[-3, 3]
  .sum
  
p part2
