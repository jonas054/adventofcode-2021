MIRROR = {
  ')' => '(',
  '}' => '{',
  ']' => '[',
  '>' => '<',
  '(' => ')',
  '{' => '}',
  '[' => ']',
  '<' => '>'
}.freeze

SCORING_A = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

def parse(chunk)
  stack = []
  chunk.chars.each do |char|
    case char
    when '(', '{', '[', '<' then stack.push(char)
    when ')', '}', ']', '>' then return char if MIRROR[char] != stack.pop
    end
  end
  stack.empty? ? :valid : :incomplete
end

def valid?(chunk)
  parse(chunk) == :valid
end

def score_for(text)
  text.lines
      .map(&:chomp)
      .map { parse(_1) }
      .select { _1.is_a?(String) }
      .map { SCORING_A[_1] }
      .sum
end

if $PROGRAM_NAME == __FILE__
  assert valid?('()')
  assert valid?('[]')
  assert valid?('([])')
  assert valid?('{()()()}')
  assert valid?('<([{}])>')
  assert valid?('[<>({}){}[([])<>]]')
  assert valid?('(((((((((())))))))))')

  assert !valid?('(]')
  assert !valid?('{()()()>')
  assert !valid?('(((()))}')
  assert !valid?('<([]){()}[{}])')

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
  assert score_for(example) == 26_397
  p score_for(File.read('10.input')) # 311895
end
