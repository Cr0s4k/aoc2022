# typed: true
# frozen_string_literal: true

input = File.read('in.txt')

shape_points = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

rules = {
  'X' => {
    'A' => 3,
    'B' => 0,
    'C' => 6
  },
  'Y' => {
    'A' => 6,
    'B' => 3,
    'C'=> 0
  },
  'Z' => {
    'A' => 0,
    'B' => 6,
    'C' => 3
  }
}

def calc_points(play, rules, shape_points)
  play => [opponent, you]
  rules[you][opponent] + shape_points[you]
end

def part1(input, rules, shape_points)
  part1 = input
  .split("\n")
  .map do |x|
    x
      .split(" ")
      .then do |y| calc_points(y, rules, shape_points) end
  end
  .sum
end

p part1(input, rules, shape_points)

rules = {
  'X' => {
    'A' => 'Z',
    'B' => 'X',
    'C' => 'Y'
  },
  'Y' => {
    'A' => 'X',
    'B' => 'Y',
    'C'=> 'Z'
  },
  'Z' => {
    'A' => 'Y',
    'B' => 'Z',
    'C' => 'X'
  }
}

result_points = {
  'X' => 0,
  'Y' => 3,
  'Z' => 6
}

def calc_points2(play, rules, shape_points, result_points)
  play => [opponent, move]
  you = rules[move][opponent]
  result_points[move] + shape_points[you]
end

def part2(input, rules, shape_points, result_points)
  part1 = input
  .split("\n")
  .map do |x|
    x
      .split(" ")
      .then do |y| calc_points2(y, rules, shape_points, result_points) end
  end
  .sum
end

p part2(input, rules, shape_points, result_points)