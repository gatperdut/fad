require './rooms/seed_room'
require './rooms/ordinary_room'
require './rooms/entry_room'
require './raws'
require './placer'
require './dock_chooser'
require './coord'

class Map

  attr_reader :rooms
  attr_reader :placer
  attr_reader :dock_chooser
  attr_reader :size

  def initialize(window)
    @window = window

    @size = Coord.new(30, 21)

    @rooms = []

    @placer = nil

    @dock_chooser = nil
  end

  def load_raws
    @seed_raws = Raws.new('data/seed_rooms.json')
    @entry_raws = Raws.new('data/entry_rooms.json')
    @ordinary_raws = Raws.new('data/ordinary_rooms.json')
  end

  def place_seed_room
    throw 'There can only be 1 seed room and it must be the first!' unless @rooms.length.zero?

    @rooms << SeedRoom.new(@window, @seed_raws.data['1'])
  end

  def place_entry_room(dock)
    throw 'There can only be 1 entry room and it must be the first!' unless @rooms.length == 1

    room = EntryRoom.new(@window, @entry_raws.data[[1, 2, 3].sample.to_s])

    @placer = Placer.new(@window, dock, room)
  end

  def place_ordinary_room(dock)
    throw 'An entry room must be added before any ordinary rooms!' if @rooms.length.zero?

    room = OrdinaryRoom.new(@window, @ordinary_raws.data[['11', '12', '13', '14'].sample], 15, 10)

    @placer = Placer.new(@window, dock, room)
  end

  def choose_next_dock(room)
    @dock_chooser = DockChooser.new(@window, room)
  end

  def needs_redraw?
    @rooms.any? { |room| room.needs_redraw? } || (!@placer.nil? && @placer.needs_redraw?) || (!@dock_chooser.nil? && @dock_chooser.needs_redraw?)
  end

  def draw
    draw_grid
    draw_rooms
    @placer.draw unless @placer.nil?
    @dock_chooser.draw unless @dock_chooser.nil?
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