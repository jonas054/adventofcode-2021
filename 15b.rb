EXAMPLE = <<~TEXT.freeze
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
TEXT

def main(input)
  @matrix = input.lines.map {_1.chomp.chars.map(&:to_i) }
  grow_matrix
  @path_of_lowest_risk = {}
  path = path_of_lowest_risk(0, 0)
  output(path)
  total_level(path)
end

def grow_matrix
  original_height = @matrix.length
  original_width = @matrix[0].length
  (4 * original_height).times { @matrix << next_risk_level(@matrix[-original_height]) }
  @matrix.each { |row| 4.times { row.concat(next_risk_level(row[-original_width..])) } }
end

def path_of_lowest_risk(start_x, start_y)
  @path_of_lowest_risk[[start_x, start_y]] ||= begin
    next_steps = [[start_x + 1, start_y],
                  [start_x, start_y + 1]].reject { _1 > max_x || _2 > max_y }
    if next_steps.empty?
      []
    else
      best_x, best_y = next_steps.min_by do |x, y|
        @matrix[y][x] + total_level(path_of_lowest_risk(x, y))
      end
      [[best_x, best_y]] + path_of_lowest_risk(best_x, best_y)
    end
  end
end

def next_risk_level(row) = row.map { _1 == 9 ? 1 : _1 + 1 }
def max_x = @matrix[0].length - 1
def max_y = @matrix.length - 1
def total_level(points) = points.map { @matrix[_2][_1] }.sum

def output(path)
  @matrix.each_with_index do |row, y|
    row.each_with_index do |value, x|
      print(path.include?([x, y]) || [x, y] == [0, 0] ? Rainbow(value).yellow : value)
    end
    puts
  end
end

if $PROGRAM_NAME == __FILE__
  puts "total=#{main(EXAMPLE)}" # 315
  p main(File.read('15.input')) # 2990 (too high)
end
