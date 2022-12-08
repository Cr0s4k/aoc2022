input = File.read("in.txt")

# part 1

def fully_contains?(pair1 : Tuple(Int32, Int32), pair2 : Tuple(Int32, Int32)) : Bool
  pair1[0] <= pair2[0] && pair1[1] >= pair2[1]
end

def overlap?(pair1 : Tuple(Int32, Int32), pair2 : Tuple(Int32, Int32)) : Bool
  fully_contains?(pair1, pair2) || fully_contains?(pair2, pair1)
end

def get_pairs(x : String) : Tuple(Tuple(Int32, Int32), Tuple(Int32, Int32))
  ranges = x.split(",")

  pair1 = ranges[0].split("-")
  pair1 = {pair1[0].to_i, pair1[1].to_i}

  pair2 = ranges[1].split("-")
  pair2 = {pair2[0].to_i, pair2[1].to_i}

  {pair1, pair2}
end

p1 = input
  .split("\n")
  .reject { |x| x == "" }
  .count { |x| get_pairs(x).try { |y| overlap?(y[0], y[1])} }

p p1

# part 2

def overlap_at_all?(pair1 : Tuple(Int32, Int32), pair2 : Tuple(Int32, Int32)) : Bool
  (pair1[0] <= pair2[1] && pair1[1] >= pair2[0]) || (pair2[0] <= pair1[1] && pair2[1] >= pair1[0])
end

p2 = input
  .split("\n")
  .reject { |x| x == "" }
  .count { |x| get_pairs(x).try { |y| overlap_at_all?(y[0], y[1])} }

p p2
