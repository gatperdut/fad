require './utils/directions'

class Placer

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw
  
  attr_reader :valid
  alias_method :valid?, :valid

  attr_reader :running
  alias_method :running?, :running

  include Directions

  def initialize(window)
    @window = window

    @dock = nil

    @room = nil

    @needs_redraw = false

    @running = false
  end

  def handle_input(id)
    @room.move(Directions::KB2DIR[id]) if Directions::KB2DIR.include?(id)

    finish_placing if @valid && id == Gosu::KbReturn

    @room.rotate if id == Gosu::KbR

    validate

    @needs_redraw = true
  end

  def start_placing(dock, room)
    @dock = dock
    @room = room

    @dock.start_blinking

    @needs_redraw = true

    @running = true

    validate
  end

  def finish_placing
    @dock.stop_blinking

    @window.map.rooms << @room
    in_game_state.switch_to(:face_encounter, { room: @room })

    @dock.connected = true

    @room.fit_for(@dock).connected = true

    @running = false
  end

  def validate
    @valid = !!@room.fit_for(@dock)
  end

  def draw
    @room.draw

    @needs_redraw = false
  end

  private

  def in_game_state
    @window.in_game_state
  end

end