def min_cost(positions)
  (positions.min..positions.max).map do |target|
    positions.map { (_1 - target).abs }.sum
  end.min
end

p min_cost([16, 1, 2, 0, 4, 2, 7, 1, 2, 14]) # 37
p min_cost(File.read('7.input').split(/,/).map(&:to_i)) # 356179
