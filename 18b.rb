require './18a'

def find_largest(input)
  numbers = input.lines.map(&:chomp)
  numbers.permutation(2).to_a.map { |a, b| magnitude(main([a, b].join("\n"))) }.max
end

p find_largest(EXAMPLE) # 3993
p find_largest(File.read('18.input')) # 4812
