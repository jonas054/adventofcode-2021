Vector = Struct.new(:x, :y, :z)

class Vector # :nodoc:
  def +(other)
    Vector.new(x + other.x, y + other.y, z + other.z)
  end

  def -(other)
    Vector.new(x - other.x, y - other.y, z - other.z)
  end

  def apply_sign(a, b, c)
    Vector.new(a * x, b * y, c * z)
  end

  def manhattan_distance_to(other)
    (x - other.x).abs + (y - other.y).abs + (z - other.z).abs
  end
end

def Vector(x, y, *z) # rubocop:disable Naming/MethodName
  z.empty? ? Vector.new(x, y, 0) : Vector.new(x, y, *z)
end
