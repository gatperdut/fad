require './rooms/layouts/tiles/tile'

class FloorTile < Tile

  def initialize(layout, y, x, code)
    super(layout, y, x, code)
  end

  def draw
    super(0xFF666666)
  end

end
