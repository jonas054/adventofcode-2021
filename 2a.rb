pos = 0
File.read('2.input').lines.map(&:split).each do |direction, amount|
  amount = amount.to_i
  case direction
  when 'forward' then pos += amount
  when 'down'    then pos += Complex(0, amount)
  when 'up'      then pos -= Complex(0, amount)
  end
end
p pos.real * pos.imag # 2120749
