require './utils/directions'

class Placer

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Directions

  def initialize(room)
    @room = room

    @arrow_codes = {
      82 => 'up',
      79 => 'right',
      81 => 'down',
      80 => 'left'
    }

    @dock = nil

    @needs_redraw = false
  end

  def handle_input(id)
    @room.move(Directions::KB2DIR[id]) if Directions::KB2DIR.include?(id)

    @room.rotate if id == Gosu::KB_R

    validate

    @needs_redraw = true
  end

  def start_placing(dock)
    @dock = dock
    @dock.start_blinking
  end

  def validate
    puts @dock.destination
  end

  def draw
    @room.draw

    @needs_redraw = !!@dock
  end

end