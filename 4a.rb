require './4'

def main
  play { |boards, nr| winner = boards.find { bingo?(_1) } and return score(winner, nr) }
end

p main # 55770
