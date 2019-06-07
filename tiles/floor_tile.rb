require './tiles/tile'

class FloorTile < Tile

  def initialize(layout, y, x, code)
    super(layout, y, x, code)
  end

  def draw
    super(0xFF888888)
  end

end