require './tiles/tile'
require './blink/blinker'
require './utils/directions'

class DockTile < Tile

  include Directions

  def initialize(layout, y, x, code)
    super(layout, y, x, code)

    @blinker = Blinker.new
  end

  DIRS.each do |dir|
    define_method("#{dir}?") do
      @code == dir
    end
  end

  def draw
    @blinker.blink
    color = @blinker.modulated_color(0x88, 0x88, 0x88)
    super(color)
    send("draw_connection_#{@code}")
  end

  def start_blinking
    @blinker.start
  end

  def stop_blinking
    @blinker.stop
  end

  def connection_color
    @blinker.modulated_color(0xFF, 0x00, 0x00)
  end

  def draw_connection_n
    window.draw_rect(west_boundary, north_boundary - 1, 30, 4, connection_color)
  end

  def draw_connection_e
    window.draw_rect(east_boundary - 3, north_boundary, 4, 30, connection_color)
  end

  def draw_connection_s
    window.draw_rect(west_boundary, south_boundary - 3, 30, 4, connection_color)
  end

  def draw_connection_w
    window.draw_rect(west_boundary - 1, north_boundary, 4, 30, connection_color)
  end

  def destination
    room.coord + Directions::INCREMENT[@code]
  end

end