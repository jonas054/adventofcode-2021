require './17a'

def main(input)
  run(input).count
end

p main('target area: x=20..30, y=-10..-5') # 112
p main('target area: x=143..177, y=-106..-71') # 2118
