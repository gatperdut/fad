require './rooms/room'
require './utils/directions'

class OrdinaryRoom < Room

  def initialize(window, raw, y, x)
    super(window, raw)

    @coord = Coord.new(y, x)
  end

  def rotate
    @layout.rotate

    @needs_redraw = true
  end

  def move(dir)
    @coord = @coord + Directions::INCREMENT[dir]
  end

  def can_rotate?
    true
  end

end