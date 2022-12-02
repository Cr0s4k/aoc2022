# frozen_string_literal: true

input = File.read('in.txt')

# part 1

part1 = input
  .split("\n\n")
  .map do |x|
    x
      .split("\n")
      .map { |y| Integer(y, exception: false) }
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
      .map { |y| Integer(y, exception: false) }
      .sum
  end
  .sort
  .slice(-3, 3)
  .sum

p part2
