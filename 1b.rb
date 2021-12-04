result = File.read('1.input').split.map(&:to_i).each_cons(4).count do |a, b, c, d|
  [a, b, c].sum < [b, c, d].sum
end
p result # 1611
