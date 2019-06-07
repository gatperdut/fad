require './room'
require './raws'
require './placer'

class Map

  attr_reader :rooms
  attr_reader :placer

  def initialize(window)
    @window = window

    @w = 20
    @h = 30

    @raws = Raws.new

    @rooms = [
      Room.new(@window, @raws.data['11'], 15, 10),
      Room.new(@window, @raws.data['14'],  8,  5)
    ]

    @placer = Placer.new(@rooms[1])

    @placer.start_placing(@rooms[0].layout.dock_tiles[1])
  end

  def needs_redraw?
    @rooms.any? { |room| room.needs_redraw? } || @placer.needs_redraw?
  end

  def draw
    draw_grid
    draw_rooms
    @placer.draw
  end

  def draw_grid
    for w in 0..(@w - 1) do
      for h in 0..(@h - 1) do
        utx = 100 + w * 30
        uty = 100 + h * 30
        @window.draw_line(utx, uty, 0xFF888888, utx + 30, uty, 0xFF888888)
        @window.draw_line(utx, uty, 0xFF888888, utx, uty + 30, 0xFF888888)
        @window.draw_line(utx + 30, uty, 0xFF888888, utx + 30, uty + 30, 0xFF888888)
        @window.draw_line(utx, uty + 30, 0xFF888888, utx + 30, uty + 30, 0xFF888888)
      end
    end
  end

  def draw_rooms
    @rooms[0].draw
  end

end