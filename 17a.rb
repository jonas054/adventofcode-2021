require './vector'

def main(input)
  run(input).max
end

def run(input)
  input =~ /target area: x=(\d+)\.\.(\d+), y=(-\d+)\.\.(-\d+)/
  x0, x1, y0, y1 = Regexp.last_match[1..4].map(&:to_i)

  (1..x1).to_a.product((y0..y0.abs).to_a).map do |x_speed, y_speed|
    shoot(Vector(x_speed, y_speed), x0..x1, y0..y1)
  end.compact
end

def shoot(speed, target_x_range, target_y_range)
  pos = Vector(0, 0)
  max_y = 0
  loop do
    pos += speed
    max_y = [pos.y, max_y].max
    speed -= Vector(speed.x / speed.x.abs, 0) unless speed.x == 0
    speed -= Vector(0, 1)
    break if passed?(pos, target_x_range, target_y_range)
    return max_y if target_x_range.cover?(pos.x) && target_y_range.cover?(pos.y)
  end
end

def passed?(pos, target_x_range, target_y_range)
  pos.x > target_x_range.max || pos.y < target_y_range.min
end

if $PROGRAM_NAME == __FILE__
  p main('target area: x=20..30, y=-10..-5') # 45
  p main('target area: x=143..177, y=-106..-71') # 5565
end
