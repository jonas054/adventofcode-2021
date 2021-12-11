example = <<~TEXT
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
TEXT

def main(input)
  matrix = input.lines.map { _1.chomp.chars.map(&:to_i) }
  low_points(matrix).map { |x, y| basin_size(matrix, x, y) }.sort.last(3).reduce(:*)
end

def low_points(matrix)
  result = []
  matrix.each_with_index do |row, y|
    row.each_with_index do |point, x|
      adjacents = find_adjacents(matrix, x, y)
      result << [x, y] if adjacents.map { matrix[_2][_1] }.all? { _1 > point }
    end
  end
  result
end

def basin_size(matrix, low_x, low_y)
  basin = [[low_x, low_y]]
  loop do
    new_locations = basin.map { find_adjacents(matrix, _1, _2) }
                         .flatten(1)
                         .uniq
                         .reject { matrix[_2][_1] == 9 } - basin
    break if new_locations.empty?

    basin += new_locations
  end
  basin.size
end

def find_adjacents(matrix, x, y)
  adjacents = []
  adjacents << [x - 1, y] if x > 0
  adjacents << [x + 1, y] if x < matrix[y].length - 1
  adjacents << [x, y - 1] if y > 0
  adjacents << [x, y + 1] if y < matrix.length - 1
  adjacents
end

raise unless main(example) == 1134

p main(File.read('9.input'))
