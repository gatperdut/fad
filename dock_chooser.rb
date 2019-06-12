class DockChooser

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  def initialize(window, room)
    @window = window

    @room = room

    @dock_index = 0

    set_dock

    @dock.start_blinking
  end

  def handle_input(id)
    finish_choosing if id == Gosu::KbReturn

    cycle_dock if id == can_cycle? && Gosu::KbC

    @needs_redraw = true
  end

  def can_cycle?
    @room.layout.dock_tiles.length > 1
  end

  def cycle_dock
    @dock.stop_blinking

    @dock_index = (@dock_index + 1) % @room.layout.dock_tiles.length

    set_dock

    @dock.start_blinking
  end

  def finish_choosing
    case @room.class.to_s.to_sym
    when :SeedRoom
      in_game_state.switch_to(:place_entry_room, { dock: @dock })
    else
      in_game_state.switch_to(:place_ordinary_room, { dock: @dock })
    end
  end

  def draw
    @needs_redraw = false
  end

  private

  def set_dock
    @dock = @room.layout.dock_tiles[@dock_index]
  end

  def in_game_state
    @window.in_game_state
  end

end