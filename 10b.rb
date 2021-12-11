require './10a'

SCORING_B = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }.freeze

def main(input)
  scores = input.lines
                .map(&:chomp)
                .select { parse(_1) == :incomplete }
                .map { score_for(autocomplete(_1)) }
                .sort
  scores[scores.length / 2]
end

def score_for(text)
  text.chars.inject(0) { |total, char| total * 5 + SCORING_B[char] }
end

def autocomplete(chunk)
  stack = []
  chunk.chars.each do |char|
    case char
    when '(', '{', '[', '<' then stack.push(char)
    when ')', '}', ']', '>' then stack.pop
    end
  end
  stack.reverse.map { MIRROR[_1] }.join
end

example = <<~TEXT
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
TEXT

p main(example) # 288957
p main(File.read('10.input')) # 2904180541
