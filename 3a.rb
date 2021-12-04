result = File.read('3.input').lines.map { _1.chomp.chars }.transpose.map do |digits|
  digits.group_by(&:to_s).sort_by { _2.length }
end

p [1, 0].map { |ix| result.map { _1[ix][0] }.join.to_i(2) }.inject(:*)
