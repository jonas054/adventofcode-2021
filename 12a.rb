EXAMPLE1 = <<~TEXT.freeze
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
TEXT

EXAMPLE2 = <<~TEXT.freeze
  dc-end
  HN-start
  start-kj
  dc-start
  dc-HN
  LN-dc
  HN-end
  kj-sa
  kj-HN
  kj-dc
TEXT

EXAMPLE3 = <<~TEXT.freeze
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
TEXT

def main(input)
  @table = Hash.new([])
  input.lines.each do |line|
    from, to = line.chomp.split('-')
    @table[from] += [to]
    @table[to] += [from]
  end

  find_paths('start', []).length
end

def find_paths(from, visited)
  return ['end'] if from == 'end'

  visited += [from] if from.downcase == from

  allowed_next_nodes(@table[from], visited).map do |to|
    find_paths(to, visited).map { [from, _1].join(',') }
  end.flatten(1)
end

def allowed_next_nodes(nodes, visited)
  nodes - visited
end

if $PROGRAM_NAME == __FILE__
  p main(EXAMPLE1) # 10
  p main(EXAMPLE2) # 19
  p main(EXAMPLE3) # 226
  p main(File.read('12.input')) # 3887
end
