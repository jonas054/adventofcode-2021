example = <<~TEXT
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
TEXT

def total_risk(matrix)
  low_points = []
  matrix.each_with_index do |row, y|
    row.each_with_index do |point, x|
      low_points << point if adjacents(matrix, x, y).all? { _1 > point }
    end
  end
  low_points.map(&:succ).sum
end

def adjacents(matrix, x, y)
  row = matrix[y]
  adjacents = []
  adjacents << row[x - 1] if x > 0
  adjacents << row[x + 1] if x < row.length - 1
  adjacents << matrix[y - 1][x] if y > 0
  adjacents << matrix[y + 1][x] if y < matrix.length - 1
  adjacents
end

raise unless total_risk(example.lines.map { _1.chomp.chars.map(&:to_i) }.to_a) == 15

p total_risk(File.read('9.input').lines.map { _1.chomp.chars.map(&:to_i) }.to_a) # 545
