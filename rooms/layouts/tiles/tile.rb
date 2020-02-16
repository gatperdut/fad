require './coord'
require './utils/directions'

class Tile

  attr_accessor :layout
  attr_accessor :overlapping
  attr_reader :code
  attr_reader :coord

  include Directions

  def initialize(layout, y, x, code)
    @layout = layout

    @coord = Coord.new(y, x)

    @code = code
  end

  def is_at?(coord)
    @coord == coord
  end

  def adjacent_tile(direction)
    @layout.tile_at(@coord + Directions::INCREMENT[direction])
  end

  def n_boundary
    100 + @coord.y * 30 + room.coord.y * 30
  end

  def s_boundary
    n_boundary + 30
  end

  def w_boundary
    100 + @coord.x * 30 + room.coord.x * 30
  end

  def e_boundary
    w_boundary + 30
  end

  def draw(color)
    overlapping = !window.map.placer.nil? && window.map.placer.overlaps.include?(self)

    draw_filling(overlapping ? 0xFFFF0000 : color)

    draw_edge
  end

  def draw_filling(color)
    window.draw_rect(w_boundary, n_boundary, 30, 30, color)
  end

  def draw_edge
    Directions::DIRS.each do |direction|
      is_wall = is_wall?(direction)

      color = 0xFFAAAAAA

      thickness = is_wall ? -2..2 : 1..1

      vertices = Directions::WALL_VERTICES[direction]
      x1 = send("#{vertices[0]}_boundary")
      y1 = send("#{vertices[1]}_boundary")
      x2 = send("#{vertices[2]}_boundary")
      y2 = send("#{vertices[3]}_boundary")

      increment = Directions::INCREMENT[direction]

      thickness.each do |i|
        window.draw_line(x1 + i * increment.x, y1 + i * increment.y, color, x2 + i * increment.x, y2 + i * increment.y, color)
      end
    end
  end

  def remove_self
    @layout.remove_tile(self)
  end

  def is_wall?(direction)
    adjacent_tile(direction).nil?
  end

  def world_coord
    room.coord + @coord
  end

  def room
    @layout.room
  end

  def window
    room.window
  end

end
