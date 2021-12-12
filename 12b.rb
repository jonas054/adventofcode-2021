require './12a'

def allowed_next_nodes(nodes, visited)
  has_duplicates = visited.any? { visited.count(_1) > 1 }
  nodes.reject { has_duplicates && visited.include?(_1) || _1 == 'start' }
end

p main(EXAMPLE1) # 36
p main(EXAMPLE2) # 103
p main(EXAMPLE3) # 3509
p main(File.read('12.input')) # 104834
