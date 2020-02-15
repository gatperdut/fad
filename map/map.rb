require './map/taken'
require './rooms/ordinary_room'
require './rooms/entry_room'
require './raws'
require './placer'
require './coord'

class Map

  attr_reader :rooms
  attr_reader :placer
  attr_reader :size
  attr_reader :taken

  def initialize(window)
    @window = window

    @size = Coord.new(30, 21)

    @rooms = []

    @placer = nil

    @taken = Taken.new(@window)
  end

  def load_raws
    @ordinary_raws = Raws.new('data/ordinary_rooms.json')
    @entry_raws = Raws.new('data/entry_rooms.json')
  end

  def add_room(room)
    @rooms << room

    @taken.add(room)
  end

  def place_entry_room
    throw 'There can only be 1 entry room and it must be the first!' unless @rooms.length.zero?

    new_room = EntryRoom.new(@window, @entry_raws.data[[1, 2, 3].sample.to_s])

    add_room(new_room)
  end

  def place_ordinary_room(destination_room)
    throw 'An entry room must be added before any ordinary rooms!' if @rooms.length.zero?

    room = OrdinaryRoom.new(@window, @ordinary_raws.data[['11', '12', '13', '14'].sample], 15, 10)

    @placer = Placer.new(@window, room, destination_room)
  end

  def cull_invalidated_docks
    also connect other pairs of docks which may happen to get connected as well!
  end

  def needs_redraw?
    @rooms.any? { |room| room.needs_redraw? } || (!@placer.nil? && @placer.needs_redraw?)
  end

  def draw
    draw_grid
    draw_rooms
    @placer.draw unless @placer.nil?
  end

  def draw_grid
    for w in 0..(@size.x - 1) do
      for h in 0..(@size.y - 1) do
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
    @rooms.each do |room|
      room.draw
    end
  end

end
