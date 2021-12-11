board = Hash.new(0)

def each_in_order(a, b)
  Range.new(*[a, b].sort).each { yield _1 }
end

File.read('5.input').lines.each do |line|
  next unless line =~ /(\d+),(\d+) -> (\d+),(\d+)/

  x1, y1, x2, y2 = [$1, $2, $3, $4].map(&:to_i)

  if x1 == x2
    each_in_order(y1, y2) { board[[x1, _1]] += 1 }
  elsif y1 == y2
    each_in_order(x1, x2) { board[[_1, y1]] += 1 }
  else
    x1, x2, y1, y2 = x2, x1, y2, y1 if x1 > x2
    sign = y2 > y1 ? 1 : -1
    (x1..x2).each { board[[_1, y1 + ((_1 - x1) * sign)]] += 1 }
  end
end

p(board.count { _2 >= 2 }) # 17787
