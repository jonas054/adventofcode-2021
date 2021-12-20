Vector = Struct.new(:x, :y)

class Vector # :nodoc:
  def +(other)
    Vector.new(x + other.x, y + other.y)
  end

  def -(other)
    Vector.new(x - other.x, y - other.y)
  end
end

def Vector(x, y) # rubocop:disable Naming/MethodName
  Vector.new(x, y)
end
