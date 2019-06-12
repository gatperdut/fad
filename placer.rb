require './utils/directions'

class Placer

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw
  attr_reader :valid
  alias_method :valid?, :valid

  include Directions

  def initialize(window, dock, room)
    @window = window

    @dock = dock

    @room = room

    @needs_redraw = true

    validate
  end

  def handle_input(id)
    @room.move(Directions::KB2DIR[id]) if Directions::KB2DIR.include?(id)

    finish_placing if @valid && id == Gosu::KbReturn

    @room.rotate if id == Gosu::KbR

    validate

    @needs_redraw = true
  end

  def finish_placing
    @window.map.rooms << @room
    in_game_state.switch_to(:place_ordinary_room, { room: @room })
  end

  def validate
    @valid = @room.fits_with(@dock)
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