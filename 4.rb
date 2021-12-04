def play
  drawn_numbers, boards = read_input
  drawn_numbers.each do |nr|
    mark(boards, nr)
    yield(boards, nr)
  end
end

def read_input
  input = File.read('4.input').lines.map { _1.chomp.split }

  [drawn_numbers(input), read_boards(input)]
end

def drawn_numbers(input) = input[0][0].split(/,/).map(&:to_i)

def read_boards(input)
  input[2..].reject(&:empty?)
            .each_with_index
            .group_by { _2 / 5 }
            .values
            .map { |v| v.map(&:first).map { |row| row.map(&:to_i) } }
end

def mark(boards, drawn_number)
  boards.flatten(1).each { |row| ix = row.index(drawn_number) and row[ix] = nil }
end

def bingo?(board) = [board, board.transpose].any? { _1.any?(&:none?) }

def score(board, last_drawn_number) = board.flatten.compact.sum * last_drawn_number
