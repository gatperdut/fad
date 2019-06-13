class DockChooser

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  attr_reader :running
  alias_method :running?, :running

  def initialize(window)
    @window = window

    @room = nil

    @dock = nil

    @dock_index = -1

    @running = false
  end

  def handle_input(id)
    finish_choosing if id == Gosu::KbReturn

    cycle_dock if can_cycle? && id == Gosu::KbC

    @needs_redraw = true
  end

  def can_cycle?
    @room.layout.unconnected_dock_tiles.length > 1
  end

  def cycle_dock
    @dock.stop_blinking

    @dock_index = (@dock_index + 1) % @room.layout.unconnected_dock_tiles.length

    set_dock

    @dock.start_blinking
  end

  def start_choosing(room)
    @room = room

    @dock_index = 0

    set_dock

    @dock.start_blinking

    @running = true
  end

  def finish_choosing
    @dock.stop_blinking

    if seed_room?
      in_game_state.switch_to(:place_entry_room, { })
    else
      in_game_state.switch_to(:place_ordinary_room, { dock: @dock })
    end

    @running = false
  end

  def seed_room?
    @room.seed_room?
  end

  def entry_room?
    @room.entry_room?
  end

  def ordinary_room?
    @room.ordinary_room?
  end

  def draw
    @needs_redraw = false
  end

  private

  def set_dock
    @dock = @room.layout.unconnected_dock_tiles[@dock_index]
  end

  def in_game_state
    @window.in_game_state
  end

end