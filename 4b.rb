require './4'

def main
  play do |boards, nr|
    boards.reject! { bingo?(_1) } if boards.size > 1
    return score(boards[0], nr) if boards.size == 1 && bingo?(boards[0])
  end
end

p main # 2980
