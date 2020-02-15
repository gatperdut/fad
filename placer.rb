require './utils/directions'

class Placer

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw
  attr_reader :valid
  alias_method :valid?, :valid

  include Directions

  def initialize(window, placing_room, destination_room)
    @window = window

    @placing_room = placing_room

    @destination_room = destination_room

    @destination_dock = nil

    @dock_index = 0

    set_dock

    @dock.start_blinking

    @needs_redraw = true

    validate
  end

  def handle_input(id)

    @placing_room.move(Directions::KB2DIR[id]) if Directions::KB2DIR.include?(id)


    cycle_dock if id == Gosu::KbC

    @placing_room.rotate if id == Gosu::KbR

    @placing_room.layout.clear_overlapping

    validate

    finish_placing if @valid && id == Gosu::KbReturn

    @needs_redraw = true
  end

  def cycle_dock
    @dock.stop_blinking

    @dock_index = (@dock_index + 1) % @destination_room.layout.unconnected_dock_tiles.length

    set_dock

    @dock.start_blinking
  end

  def finish_placing
    @window.map.add_room(@placing_room)

    @dock.stop_blinking

    @dock.connected = true
    @destination_dock.connected = true

    in_game_state.switch_to(:place_ordinary_room, { destination_room: @placing_room })
  end

  def validate
    @destination_dock = @placing_room.fitting_dock_tile(@dock)

    overlaps = @window.map.taken.overlaps?(@placing_room)

    @valid = !@destination_dock.nil? && !overlaps
  end

  def draw
    @placing_room.draw

    @needs_redraw = false
  end

  private

  def in_game_state
    @window.in_game_state
  end

  def set_dock
    @dock = @destination_room.layout.unconnected_dock_tiles[@dock_index]
  end

end
