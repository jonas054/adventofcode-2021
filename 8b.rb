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

# Returns all the inputs that have the given number of segments.
def inputs_with_segments(input, segments)
  input.select { _1.length == segments }.map { _1.chars.sort }
end

# Selects the choices whose segments overlap all the segments of a known number.
def overlapping(choices, known)
  choices.select { _1 & known == known }
end

def count(data)
  inputs, outputs = data.split(' | ').map(&:split)
  one = inputs_with_segments(inputs, 2).flatten
  four = inputs_with_segments(inputs, 4).flatten
  six = inputs_with_segments(inputs, 6) -
        overlapping(inputs_with_segments(inputs, 6), one)
  nine = overlapping(inputs_with_segments(inputs, 6), four)
  three = overlapping(inputs_with_segments(inputs, 5), one)
  two_or_five = inputs_with_segments(inputs, 5) - three
  two = two_or_five.reject { (_1 - four).length == 2 }
  table = {
    inputs_with_segments(inputs, 6) - six - nine => 0,
    [one] => 1,
    two => 2,
    three => 3,
    [four] => 4,
    two_or_five - two => 5,
    six => 6,
    inputs_with_segments(inputs, 3) => 7,
    inputs_with_segments(inputs, 7) => 8,
    nine => 9
  }
  outputs.map { table[[_1.chars.sort]].to_s }.join.to_i
end

raise unless example.lines.map { count(_1) }.sum == 61_229

p File.read('8.inputs').lines.map { count(_1) }.sum # 1070188
