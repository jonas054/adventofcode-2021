example = <<~TEXT
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
TEXT

def main(input, single_fold)
  @matrix = []
  @max_x = @max_y = 0
  input.lines.map(&:chomp).each do |line|
    process(line)
    break if single_fold && line =~ /fold/
  end
  output
  count
end

def process(line)
  case line
  when /(\d+),(\d+)/
    store_point($1.to_i, $2.to_i)
  when /fold along y=(\d+)/
    middle_y = $1.to_i
    fold(@max_x, middle_y) { |x, y| @matrix.dig(2 * middle_y - y, x) }
    @max_y /= 2
  when /fold along x=(\d+)/
    middle_x = $1.to_i
    fold(middle_x, @max_y) { |x, y| @matrix.dig(y, 2 * middle_x - x) }
    @max_x /= 2
  end
end

def store_point(x, y)
  @max_x, @max_y = [@max_x, x].max, [@max_y, y].max
  set(x, y, '#')
end

def fold(to_x, to_y)
  (0..to_y).each do |dest_y|
    (0..to_x).each do |dest_x|
      set(dest_x, dest_y, yield(dest_x, dest_y))
    end
  end
end

def set(x, y, value)
  @matrix[y] ||= []
  @matrix[y][x] ||= value
end

def output
  @matrix.each_with_index do |row, y|
    break if y > @max_y

    row ||= []
    row += [nil] * (@max_x + 1 - row.length) if row.length < @max_x + 1
    puts row[0..@max_x].map { _1 || ' ' }.join
  end
end

def count
  c = 0
  (0..@max_y).each do |y|
    (0..@max_x).each do |x|
      @matrix[y] ||= []
      c += 1 if @matrix[y][x] == '#'
    end
  end
  c
end

if $PROGRAM_NAME == __FILE__
  p main(File.read('13.input'), true) # 671
  p main(example, true) # 17
end
