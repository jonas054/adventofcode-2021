require './19a'

def main(input)
  nr_of_beacons(input)
  @scanners.values.combination(2).map { _1.manhattan_distance_to(_2) }.max
end

p main(EXAMPLE) # 3621
p main(File.read('19.input')) # 12204
