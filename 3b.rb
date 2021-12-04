def process(&block)
  data = File.read('3.input').lines.map { _1.chomp.chars }
  (0...data[0].length).each do |bit_pos|
    select_rows(data, bit_pos, &block)
    break if data.size == 1
  end
  data.flatten.join.to_i(2)
end

def select_rows(data, bit_pos)
  zeroes, ones = %w[0 1].map { |value| data.map { _1[bit_pos] }.count(value) }
  data.select! { _1[bit_pos].to_i == yield(zeroes > ones) }
end

# 482500
p process { |more_zeroes| more_zeroes ? 0 : 1 } *
  process { |more_zeroes| more_zeroes ? 1 : 0 }
