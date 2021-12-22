example = <<~TEXT
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
TEXT

def count(data)
  @inputs, outputs = data.split(' | ').map(&:split)
  table = figure_out
  outputs.map { table[[_1.chars.sort]].to_s }.join.to_i
end

def figure_out # rubocop:disable Metrics/AbcSize
  one = inputs_with_segments(2).flatten
  three = overlapping(5, one)
  two_or_five = inputs_with_segments(5) - three
  four = inputs_with_segments(4).flatten
  two = two_or_five.reject { (_1 - four).length == 2 }
  six = inputs_with_segments(6) - overlapping(6, one)
  nine = overlapping(6, four)
  {
    inputs_with_segments(6) - six - nine => 0,
    [one] => 1,
    two => 2,
    three => 3,
    [four] => 4,
    two_or_five - two => 5,
    six => 6,
    inputs_with_segments(3) => 7,
    inputs_with_segments(7) => 8,
    nine => 9
  }
end

# Selects the choices whose segments overlap all the segments of a known number.
def overlapping(nr_of_segments, known)
  inputs_with_segments(nr_of_segments).select { _1 & known == known }
end

# Returns all the inputs that have the given number of segments.
def inputs_with_segments(nr_of_segments)
  @inputs.select { _1.length == nr_of_segments }.map { _1.chars.sort }
end

raise unless example.lines.map { count(_1) }.sum == 61_229

p File.read('8.input').lines.map { count(_1) }.sum # 1070188
