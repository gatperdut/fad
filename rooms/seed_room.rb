require './rooms/room'

class SeedRoom < Room

  def initialize(window, raw)
    super(window, raw)

    @coord = Coord.new(map.size.y, map.size.x / 2)
  end

  def can_rotate?
    false
  end

end