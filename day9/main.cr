require "complex"

input = File.read("./in.txt")

def are_neightbours?(a : Complex, b : Complex) : Bool
  deltas = [-1.to_c, 1.to_c, -1.i, 1.i, 0.to_c, Complex.new(-1, -1), Complex.new(-1, 1), Complex.new(1, -1), Complex.new(1, 1)]
  deltas.any? {|x| a + x == b }
end

head = Complex.new(0, 0)
last_head_pos = 0.to_c
tail = Complex.new(0, 0)
count = Set{tail}

instructions = input
	.split("\n")
	.map { |x|
  		x
  			.split(" ")
  .try {|y| {y[0], y[1].to_i}}
	}

instructions.each {|x|
	i = 1
  while i <= x[1]
    last_head_pos = head

    case x[0]
    when "U"
      head = head + Complex.new(1, 0)
    when "D"
      head = head + Complex.new(-1, 0)
    when "L"
      head = head + Complex.new(0, -1)
    else
    	head = head + Complex.new(0, 1)
  	end

  if !are_neightbours?(head, tail)
    tail = last_head_pos
    count.add(tail)
  end

    i += 1
  end
}

p "head: #{head}"
p "tail: #{tail}"

p count.size

instructions.each {|x|
	i = 1
  while i <= x[1]
    last_head_pos = head

    case x[0]
    when "U"
      head = head + Complex.new(1, 0)
    when "D"
      head = head + Complex.new(-1, 0)
    when "L"
      head = head + Complex.new(0, -1)
    else
    	head = head + Complex.new(0, 1)
  	end

  if !are_neightbours?(head, tail)
    tail = last_head_pos
    count.add(tail)
  end

    i += 1
  end
}