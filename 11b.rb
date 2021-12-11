require './11a'

def main_11b(text)
  matrix = text.lines.map { _1.chomp.chars.map(&:to_i) }
  (1..).each do |step|
    increment(matrix)
    flash(matrix) while matrix.flatten.any? { _1 == 10 }
    return step if matrix.flatten.all? { _1 == 0 }
  end
end

p main_11b(EXAMPLE) # 195
p main_11b(File.read('11.input')) # 214
