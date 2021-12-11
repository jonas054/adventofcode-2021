require './6a'

@cache = {}

# Returns the number of fish that will be spawned by the given deadline (number
# of days) by a fish with the given number of days left until it spawns another
# fish. This number includes all decendants and the original fish itself.
def family_count(deadline, days_till_spawn)
  @cache[deadline * 10 + days_till_spawn] ||= begin
    result = 1
    while deadline > days_till_spawn
      deadline -= days_till_spawn
      result += family_count(deadline, 9)
      days_till_spawn = 7
    end
    result
  end
end

# example = [3, 4, 3, 1, 2]
# (0..100).each do |deadline|
#   old_result = fish_count(deadline, example)
#   new_result = example.map { |days| family_count(deadline, days) }.sum
#   if new_result == old_result
#     green "OK after #{deadline} days (#{old_result} fish)"
#   else
#     green deadline => old_result
#     warning deadline => new_result
#     puts
#     raise 'Bad'
#   end
# end

p INPUT.map { |days| family_count(256, days) }.sum
