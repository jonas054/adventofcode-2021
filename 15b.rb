require './15a'

def grow_matrix
  original_height = @matrix.length
  original_width = @matrix[0].length
  (4 * original_height).times { @matrix << next_risk_level(@matrix[-original_height]) }
  @matrix.each { |row| 4.times { row.concat(next_risk_level(row[-original_width..])) } }
end

def next_risk_level(row) = row.map { _1 == 9 ? 1 : _1 + 1 }

p(main(EXAMPLE) { grow_matrix }) # 315
p(main(File.read('15.input')) { grow_matrix }) # 2976
