def main(input)
  @bits = format('%0*b', input.length * 4, input.to_i(16))
  @index = 0
  read_packet
end

def read_packet
  version = read_int(3)
  type_id = read_int(3)
  if type_id == 4
    read_literal
  else
    length_type_id = read_int(1)
    if length_type_id == 0
      length_in_bits = read_int(15)
      start = @index
      version += read_packet while @index < start + length_in_bits
    else
      read_int(11).times { version += read_packet }
    end
  end
  version
end

def read_int(nr_of_bits)
  read_bits(nr_of_bits).to_i(2)
end

def read_bits(nr_of_bits)
  result = @bits[@index, nr_of_bits]
  @index += nr_of_bits
  result
end

def read_literal
  result = ''
  result << read_bits(4) while read_int(1) == 1
  result << read_bits(4)
  result.to_i(2)
end

main('D2FE28')
main('38006F45291200')
main('EE00D40C823060')
p main('8A004A801A8002F478') # 16
p main('620080001611562C8802118E34') # 12
p main('C0015000016115A2E0802F182340') # 23
p main('A0016C880162017C3686B18A3D4780') # 31
p main(File.read('16.input').chomp) # 989
