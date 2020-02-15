require './rooms/layouts/tiles/floor_tile'
require './rooms/layouts/tiles/dock_tile'
require './utils/directions'

class Layout

  include Directions

  attr_accessor :room
  attr_reader :dock_tiles
  attr_reader :floor_tiles

  def initialize(window, room, raw)
    @window = window
    @room = room
    @raw = raw

    @dock_tiles = []
    @floor_tiles = []
    fill_tiles
  end

  def height
    @raw.length
  end

  def width
    @raw[0].length
  end

  def all_tiles
    @dock_tiles + @floor_tiles
  end

  def fill_tiles
    0.upto(height - 1) do |h|
      0.upto(width - 1) do |w|
        code = sym(h, w)
        if Directions::DIRS.include?(code)
          @dock_tiles << DockTile.new(self, h, w, code)
        elsif code != :v
          @floor_tiles << FloorTile.new(self, h, w, code)
        end
      end
    end
  end

  def filled_out?
    result = true

    0.upto(height - 1) do |h|
      result = false if @raw[h].length != width
    end

    result
  end

  def draw
    all_tiles.each do |tile|
      tile.draw
    end
  end

  def fitting_dock_tile(dock_tile)
    @dock_tiles.find do |my_dock_tile|
      my_dock_tile.fits_with(dock_tile)
    end
  end

  def unconnected_dock_tiles
    @dock_tiles.select do |dock_tile|
      dock_tile.connection.nil?
    end
  end

  def rotate
    new_raw = []

    0.upto(width - 1) do |w|
      new_raw << []
      (height - 1).downto(0) do |h|
        value = DIRS.include?(sym(h, w)) ? Directions::ROTATED[sym(h, w)].to_s : sym(h, w)
        new_raw[w] << value
      end
    end

    @raw = new_raw

    @dock_tiles.clear
    @floor_tiles.clear
    fill_tiles
  end

  def clear_overlapping
    all_tiles.each do |tile|
      tile.overlapping = false
    end
  end

  def tile_at(y, x)
    all_tiles.find do |tile|
      tile.is_at?(y, x)
    end
  end

  def color(y, x)
    return 0xFF888888 unless DIRS.include?(sym(y, x))

    return 0xFF008800
  end

  def sym(y, x)
    @raw[y][x].to_sym
  end

  def void?(y, x)
    sym(y, x) == :v
  end

end
