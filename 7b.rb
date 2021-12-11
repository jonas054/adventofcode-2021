def min_cost(positions)
  range = (positions.min..positions.max)
  range.map { |target| positions.map { (1..(_1 - target).abs).sum }.sum }.min
end

p min_cost([16, 1, 2, 0, 4, 2, 7, 1, 2, 14])
p min_cost(File.read('7.input').split(/,/).map(&:to_i))
