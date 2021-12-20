require './16a'

def read_packet
  read_int(3)
  type_id = read_int(3)
  if type_id == 4
    read_literal
  else
    sub = []
    length_type_id = read_int(1)
    if length_type_id == 0
      length_in_bits = read_int(15)
      start = @index
      sub << read_packet while @index < start + length_in_bits
    else
      read_int(11).times { sub << read_packet }
    end
    calculate(type_id, sub)
  end
end

def calculate(type_id, sub)
  case type_id
  when 0 then sub.sum
  when 1 then sub.inject(:*)
  when 2 then sub.min
  when 3 then sub.max
  when 5, 6, 7 then compare(type_id, sub)
  end
end

def compare(type_id, sub)
  a, b = sub
  fulfilled = case type_id
              when 5 then a > b
              when 6 then a < b
              when 7 then a == b
              end
  fulfilled ? 1 : 0
end

p main('C200B40A82') # 3
p main('04005AC33890') # 54
p main('880086C3E88112') # 7
p main('CE00C43D881120') # 9
p main('D8005AC2A8F0') # 1
p main('F600BC2D8F') # 0
p main('9C005AC2F8F0') # 0
p main('9C0141080250320F1802104A08') # 1
p main(File.read('16.input').chomp) # 7936430475134
