EXAMPLE = <<~TEXT.freeze
  ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##\
  #..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###\
  .######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#.\
  .#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#.....\
  .#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#..\
  ...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.....\
  ..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

  #..#.
  #....
  ##..#
  ..#..
  ..###
TEXT

class Image
  attr_writer :default_pixel

  def initialize(lines)
    @lines = lines
  end

  def grow
    result = ['_' * (width + 2)]
    @lines.each { |_row| result << result[0].dup }
    Image.new(result + [result[0].dup])
  end

  def key(x, y)
    x_range = (x - 1)..(x + 1)
    bits = get(x_range, y - 1) + get(x_range, y) + get(x_range, y + 1)
    bits.tr('.#', '01').to_i(2)
  end

  def get(x_range, y)
    x_range.map { |x| inside?(x, y) ? @lines[y][x] : @default_pixel }.join
  end

  def inside?(x, y) = x >= 0 && x < width && y >= 0 && y < height
  def set(x, y, value) = @lines[y][x] = value
  def height = @lines.length
  def width = @lines[0].length
  def count = @lines.inject(0) { |acc, elem| elem.count('#') + acc }
end

def enhance(image, algorithm)
  new_image = image.grow
  new_image.height.times do |y|
    new_image.width.times { |x| new_image.set(x, y, algorithm[image.key(x - 1, y - 1)]) }
  end
  new_image
end

def main(input, repetitions)
  algorithm = input.lines.first.chomp
  image = Image.new(input.lines[2..].map(&:chomp))

  (repetitions / 2).times do
    image.default_pixel = '.'
    image = enhance(image, algorithm)
    image.default_pixel = algorithm[0]
    image = enhance(image, algorithm)
  end
  image.count
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE, 2) # 35
  p main(File.read('20.input'), 2) # 5391
end
