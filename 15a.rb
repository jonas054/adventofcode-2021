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
  @lowest_risk_from = {}
  lowest_risk_from(0, 0)
end

def lowest_risk_from(x, y)
  @lowest_risk_from[[x, y]] ||= begin
    max_x = @matrix[0].length - 1
    max_y = @matrix.length - 1
    next_steps = [[x + 1, y], [x, y + 1]].reject { _1 > max_x || _2 > max_y }
    if next_steps.empty?
      0
    else
      next_steps.map { @matrix[_2][_1] + lowest_risk_from(_1, _2) }.min
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 40
  p main(File.read('15.input')) # 741
end
