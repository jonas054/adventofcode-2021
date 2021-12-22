EXAMPLE = <<~TEXT.freeze
  [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
  [[[5,[2,8]],4],[5,[[9,9],0]]]
  [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
  [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
  [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
  [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
  [[[[5,4],[7,7]],8],[[8,3],8]]
  [[9,3],[[9,9],[6,[4,9]]]]
  [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
  [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
TEXT

def main(input)
  numbers = input.lines.map(&:chomp)
  numbers[0, 2] = add(numbers[0], numbers[1]) while numbers.length > 1
  numbers[0]
end

def add(a, b) = reduce("[#{a},#{b}]")

def reduce(n)
  parts = parse(n)
  loop do
    next if explode_leftmost(parts)
    next if split_leftmost(parts)

    break
  end
  parts.join
end

def explode_leftmost(parts)
  level = 0
  parts.each_with_index do |elem, ix|
    level += 1 if elem == '['
    level -= 1 if elem == ']'
    next unless level > 4 && pair_of_digits?(parts, ix)

    explode(parts, ix)
    return true
  end
  false
end

def pair_of_digits?(parts, ix)
  parts[ix] == '[' && parts[ix + 2] == ',' && parts[ix + 4] == ']'
end

def explode(parts, ix)
  explode_one_side(parts, ix + 1, ix.downto(0))
  explode_one_side(parts, ix + 3, (ix + 4)..parts.length)
  parts[ix, 5] = 0
end

def explode_one_side(parts, value_ix, search_range)
  destination_ix = search_range.find { parts[_1].is_a?(Integer) } or return

  parts[destination_ix] += parts[value_ix]
end

def split_leftmost(parts)
  parts.each_with_index do |elem, ix|
    if elem.is_a?(Integer) && elem >= 10
      parts[ix, 1] = ['[', parts[ix] / 2, ',', (parts[ix] + 1) / 2, ']']
      return true
    end
  end
  false
end

def magnitude(parts, ix = 0)
  return magnitude(parse(parts)).first if parts.is_a?(String)

  if parts[ix] == '['
    left, right, ix = left_and_right(parts, ix)
    [3 * left + 2 * right, ix]
  else
    [parts[ix], ix + 1]
  end
end

def left_and_right(parts, ix)
  left, ix = magnitude(parts, ix + 1)
  right, ix = magnitude(parts, ix + 1)
  [left, right, ix + 1]
end

def parse(n) = n.scan(/\d+|./).map { _1 =~ /\d/ ? _1.to_i : _1 }

def check(actual, expected)
  raise "Expected #{expected} but was #{actual}" unless actual == expected
end

if $PROGRAM_NAME == __FILE__
  check main(<<~TEXT), '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'
    [[[[4,3],4],4],[7,[[8,4],9]]]
    [1,1]
  TEXT

  check main(<<~TEXT), '[[[[1,1],[2,2]],[3,3]],[4,4]]'
    [1,1]
    [2,2]
    [3,3]
    [4,4]
  TEXT

  check main(<<~TEXT), '[[[[3,0],[5,3]],[4,4]],[5,5]]'
    [1,1]
    [2,2]
    [3,3]
    [4,4]
    [5,5]
  TEXT

  check main(<<~TEXT), '[[[[5,0],[7,4]],[5,5]],[6,6]]'
    [1,1]
    [2,2]
    [3,3]
    [4,4]
    [5,5]
    [6,6]
  TEXT

  check main(<<~TEXT), '[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]'
    [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
    [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
    [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
    [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
    [7,[5,[[3,8],[1,4]]]]
    [[2,[2,2]],[8,[8,1]]]
    [2,9]
    [1,[[[9,3],9],[[9,0],[0,7]]]]
    [[[5,[7,4]],7],1]
    [[[[4,2],2],6],[8,7]]
  TEXT

  check magnitude('[[1,2],[[3,4],5]]'), 143
  check magnitude('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'), 1384
  check magnitude('[[[[1,1],[2,2]],[3,3]],[4,4]]'), 445
  check magnitude('[[[[3,0],[5,3]],[4,4]],[5,5]]'), 791
  check magnitude('[[[[5,0],[7,4]],[5,5]],[6,6]]'), 1137
  check magnitude('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]'), 3488

  p magnitude(main(EXAMPLE)) # 4140
  p magnitude(main(File.read('18.input'))) # 3051
end
