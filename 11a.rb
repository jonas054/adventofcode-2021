def main(text)
  matrix = text.lines.map { _1.chomp.chars.map(&:to_i) }
  flash_count = 0
  100.times do
    increment(matrix)
    flash(matrix) while matrix.flatten.any? { _1 == 10 }
    flash_count += matrix.flatten.count(0)
  end
  flash_count
end

def increment(matrix)
  matrix.each { |row| row.each_index { |x| row[x] += 1 } }
end

def flash(matrix)
  matrix.each_with_index do |row, y|
    row.each_index { |x| flash_cell(matrix, x, y) if row[x] == 10 }
  end
end

def flash_cell(matrix, x, y)
  [-1, 0, 1].each do |dy|
    [-1, 0, 1].each do |dx|
      next if dx == 0 && dy == 0

      y2 = y + dy
      next if y2 < 0 || y2 >= matrix.length

      x2 = x + dx
      next if x2 < 0 || x2 >= matrix[y].length

      matrix[y2][x2] += 1 unless [0, 10].include?(matrix[y2][x2])
    end
  end
  matrix[y][x] = 0
end

EXAMPLE = <<~TEXT.freeze
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
TEXT

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 1656
  p main(File.read('11.input')) # 1608
end
