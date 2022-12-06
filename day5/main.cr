input = File.read("./in.txt")

record Instruction, quantity : Int32, from : Int32, to : Int32

def parseInstructions(str : String) : Array(Instruction)
  str
    .split("\n")
    .map { |x|
      result = /move (.+) from (.+) to (.+)/.match(x)

      quantity = result.try &.[1]
      from = result.try &.[2]
      to = result.try &.[3]

      raise("error") if !quantity || !from || !to

      Instruction.new quantity.to_i, from.to_i - 1, to.to_i - 1
    }
end

def parse_crates(str : String) : Array(Array(String))
  lines = str
    .split("\n")

  base = lines.last
  arr_size = base.split(/\s+/).reject { |x| x==""}.last

  raise("error") if !arr_size

  stacks = [] of Array(String) 
  arr_size.to_i.times {
    stacks.push([] of String)
  }

  lines[0..-2]
    .reverse
    .reduce(stacks) { |acc, x|
      x
        .split("")
        .each_slice(4)
        .map { |x| x[1] }
        .each_with_index { |x, i|
          acc[i].push(x) if x != " "
        }

      acc
    }
end

def solve1(input) : String
  splited_input = input.split("\n\n")

  instructions = parseInstructions(splited_input[1])
  crates = parse_crates(splited_input[0])

  instructions.each { |x|
    x.quantity.times {
      last = crates[x.from].pop()
      crates[x.to].push(last)
    }
  }

  crates.map { |x| x.last }.join("")
end

p1 = solve1(input)

p p1

def solve2(input) : String
  splited_input = input.split("\n\n")

  instructions = parseInstructions(splited_input[1])
  crates = parse_crates(splited_input[0])

  instructions.each { |x|
    to_remove_from = crates[x.from][-x.quantity..]
    crates[x.to].concat(to_remove_from)
    crates[x.from] = crates[x.from][0..-x.quantity - 1]
  }

  crates.map { |x| x.last }.join("")
end

p2 = solve2(input)

p p2
