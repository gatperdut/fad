class Coord

  attr_accessor :y
  attr_accessor :x

  def initialize(y, x)
    @y = y
    @x = x
  end

  def +(coord)
    Coord.new(@y + coord.y, @x + coord.x)
  end

end