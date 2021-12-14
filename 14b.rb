require './14a'

def calculate(chain, rules)
  pair_count = chain.chars.each_cons(2).map { [_1.join, 1] }.to_h

  40.times do
    new_count = Hash.new(0)
    pair_count.each do |pair, occurences|
      inserted_char = rules[pair] or next
      ["#{pair[0]}#{inserted_char}",
       "#{inserted_char}#{pair[1]}"].each { new_count[_1] += occurences }
    end
    pair_count = new_count
  end

  count_chars(pair_count, chain[0], chain[-1])
end

def count_chars(pair_count, leftmost, rightmost)
  char_count = Hash.new(0)
  pair_count.each { |pair, occurences| pair.chars.each { char_count[_1] += occurences } }
  [leftmost, rightmost].each { char_count[_1] += 1 }
  char_count.map { _2 / 2 }
end

p main(EXAMPLE) # 2188189693529
p main(File.read('14.input')) # 2875665202438
