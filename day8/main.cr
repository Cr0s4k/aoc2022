def on_edge?(matrix, i, j) : Bool
  (j - 1) == -1 ||
	(i - 1) == -1 ||
	(j + 1) == matrix[0].size ||
    (i + 1) == matrix.size
end

enum Side
  Top
  Left
  Right
  Bottom
end

def visible_from(side : Side, matrix, i, j) : Bool
  return true if on_edge?(matrix, i, j)

  case side
  when Side::Top
    return (0..i - 1).to_a.all? {|x| matrix[x][j] < matrix[i][j]}
  when Side::Bottom
    return (i + 1..matrix.size - 1).to_a.all? {|x| matrix[x][j] < matrix[i][j]}
  when Side::Left
    return (0..j - 1).to_a.all? {|x| matrix[i][x] < matrix[i][j]}
  else
    return (j + 1..matrix[0].size - 1).to_a.all? {|x| matrix[i][x] < matrix[i][j]}
  end
end

def visible?(matrix, i, j) : Bool
  visible_from(Side::Top, matrix, i, j) ||
    visible_from(Side::Bottom, matrix, i, j) ||
    visible_from(Side::Left, matrix, i, j) ||
    visible_from(Side::Right, matrix, i, j)
end

input = File.read("./in.txt")

matrix = input
	.split("\n")
	.map { |x| x.split("").map(&.to_i) }

i = 0
j = 0
count = 0

while i < matrix.size
  while j < matrix[i].size
    count = count + 1 if visible?(matrix, i, j)
    
    j = j + 1
  end
  j = 0
  i = i + 1
end

p count

# Part 2

def calc_score_for_side(side : Side, matrix, i, j) : Int32
  count = 0
   case side
  when Side::Top
    x = i - 1
    while x >= 0
      count += 1
      return count if matrix[x][j] >= matrix[i][j]
      x -= 1
    end
  when Side::Bottom
    x = i + 1
    while x <= matrix.size - 1
      count += 1
      return count if matrix[x][j] >= matrix[i][j]
      x += 1
    end
  when Side::Left
    x = j - 1
    while x >= 0
      count += 1
      return count if matrix[i][x] >= matrix[i][j]
      x -= 1
    end
  else
    x = j + 1
    while x <= matrix[0].size - 1
      count += 1
      return count if matrix[i][x] >= matrix[i][j]
      x += 1
    end
  end

  return count
end

def calc_score(matrix, i, j) : Int32
  calc_score_for_side(Side::Top, matrix, i, j) *
  calc_score_for_side(Side::Bottom, matrix, i, j) *
  calc_score_for_side(Side::Left, matrix, i, j) *
  calc_score_for_side(Side::Right, matrix, i, j)
end

i = 0
j = 0
count = 0
scores = [] of Int32

while i < matrix.size
  while j < matrix[i].size
    score = calc_score(matrix, i, j)
    scores.push(score)
    
    j = j + 1
  end
  j = 0
  i = i + 1
end

p scores.max
