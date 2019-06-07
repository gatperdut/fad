require './coord'
require './utils/directions'

class Room

  attr_reader :window
  attr_reader :layout
  attr_reader :coord
  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Directions

  def initialize(window, raw, y, x)
    @window = window
    @layout = Layout.new(self, raw)

    @coord = Coord.new(y, x)

    @needs_redraw = false
  end

  def draw
    @layout.draw

    @needs_redraw = false
  end

  def fits_with(dock_tile)
    @layout.fits_with(dock_tile)
  end

  def rotate
    @layout.rotate

    @needs_redraw = true
  end

  def move(dir)
    @coord = @coord + Directions::INCREMENT[dir]
  end

end