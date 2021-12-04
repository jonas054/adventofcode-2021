aim = pos = 0
File.read('2.input').lines.map(&:split).each do |direction, amount|
  amount = amount.to_i
  case direction
  when 'forward' then pos += Complex(amount, amount * aim)
  when 'down'    then aim += amount
  when 'up'      then aim -= amount
  end
end
p pos.real * pos.imag
