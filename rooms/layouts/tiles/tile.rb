require 'pry'
require './coord'

class Tile

  attr_accessor :overlapping
  attr_reader :code
  attr_reader :coord

  def initialize(layout, y, x, code)
    @layout = layout

    @coord = Coord.new(y, x)

    @code = code

    @overlapping = false
  end

  def is_at?(y, x)
    @coord.y == y && coord.x == x
  end

  def north_boundary
    100 + @coord.y * 30 + room.coord.y * 30
  end

  def south_boundary
    north_boundary + 30
  end

  def west_boundary
    100 + @coord.x * 30 + room.coord.x * 30
  end

  def east_boundary
    west_boundary + 30
  end

  def draw(color)
    draw_filling(@overlapping ? 0xFFFF0000 : color)
    draw_edge
    draw_walls
  end

  def draw_filling(color)
    window.draw_rect(west_boundary, north_boundary, 30, 30, color)
  end

  def draw_edge
    color = 0xFFCCCCCC
    window.draw_line(west_boundary, north_boundary, color, east_boundary, north_boundary, color)
    window.draw_line(west_boundary, north_boundary, color, west_boundary, south_boundary, color)
    window.draw_line(east_boundary, north_boundary, color, east_boundary, south_boundary, color)
    window.draw_line(west_boundary, south_boundary, color, east_boundary, south_boundary, color)
  end

  def draw_walls

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
