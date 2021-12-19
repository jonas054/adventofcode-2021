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

DIRECTIONS = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

def main(input)
  @matrix = input.lines.map {_1.chomp.chars.map(&:to_i) }
  yield if block_given?
  paths = {}
  path_forward_of_lowest_risk(0, 0, paths)
  total_risk = { [max_x, max_y] => 0 }
  paths.each_key { |pos| total_risk[pos] = total_level(paths[pos]) }
  print 'correcting'
  print '.' while correct(total_risk)
  puts
  path = find_final_path(0, 0, total_risk)
  # output(path)
  total_level(path)
end

def correct(total_risk)
  any_changes = false
  total_risk.each_key do |x, y|
    DIRECTIONS.map { |dx, dy| [x + dx, y + dy] }
              .select { inside?(_1, _2) }
              .each do |other_x, other_y|
      other = @matrix[other_y][other_x] + total_risk[[other_x, other_y]]
      next unless other < total_risk[[x, y]]

      total_risk[[x, y]] = other
      any_changes = true
    end
  end
  any_changes
end

def path_forward_of_lowest_risk(start_x, start_y, paths)
  return [] if start_x == max_x && start_y == max_y

  cached = paths[[start_x, start_y]] and return cached

  best_x, best_y = next_step_forward(start_x, start_y).min_by do |x, y|
    @matrix[y][x] + total_level(path_forward_of_lowest_risk(x, y, paths))
  end
  paths[[start_x, start_y]] = [[best_x, best_y]] +
                              path_forward_of_lowest_risk(best_x, best_y, paths)
end

def find_final_path(start_x, start_y, total_risk)
  return [] if start_x == max_x && start_y == max_y

  positions = DIRECTIONS.map { |dx, dy| [start_x + dx, start_y + dy] }
                        .select { inside?(_1, _2) }

  best_x, best_y = positions.min_by { |x, y| @matrix[y][x] + total_risk[[x, y]] }
  [[best_x, best_y]] + find_final_path(best_x, best_y, total_risk)
end

def next_step_forward(x, y) = [[x + 1, y], [x, y + 1]].select { inside?(_1, _2) }
def inside?(x, y) = (0..max_x).cover?(x) && (0..max_y).cover?(y)
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
  p main(EXAMPLE) # 40
  p main(File.read('15.input')) # 741
end
