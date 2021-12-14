EXAMPLE = <<~TEXT.freeze
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
TEXT

def main(input)
  chain = nil
  rules = {}

  input.lines.each do |line|
    case line
    when /\w{3,}/
      chain = $&
    when /(\w+) -> (\w+)/
      rules[$1] = $2
    end
  end

  counts = calculate(chain, rules)
  counts.max - counts.min
end

def calculate(chain, rules)
  10.times do
    new_chain = chain[0]
    chain.chars.each_cons(2) do |a, b|
      new_chain << rules["#{a}#{b}"] << b
    end
    chain = new_chain
  end

  chain.chars.group_by(&:to_s).map { _2.length }
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE) # 1588
  p main(File.read('14.input')) # 2590
end
