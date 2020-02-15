require './coord'
require './utils/directions'

class Room

  attr_reader :window
  attr_reader :layout
  attr_reader :coord
  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Directions

  def initialize(window, raw)
    @window = window
    @layout = Layout.new(@window, self, raw)

    @needs_redraw = false
  end

  def draw
    @layout.draw

    @needs_redraw = false
  end

  def fitting_dock_tile(dock_tile)
    @layout.fitting_dock_tile(dock_tile)
  end

  protected

  def map
    @window.map
  end

end
