def fish_count(days, state)
  state = state.dup
  (1..days).each do |_day|
    new_fish = []
    state.count(0).times { new_fish << 8 }
    state.map! { |n| n == 0 ? 6 : n - 1 }
    state += new_fish
  end
  state.length
end

INPUT = File.read('6.input').split(/,/).map(&:to_i)
p fish_count(80, INPUT) if $PROGRAM_NAME == __FILE__
