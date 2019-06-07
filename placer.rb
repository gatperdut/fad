require './utils/directions'

class Placer

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw
  attr_reader :valid
  alias_method :valid?, :valid

  include Directions

  def initialize(room)
    @room = room

    @dock = nil

    @needs_redraw = false

    @valid = false
  end

  def handle_input(id)
    @room.move(Directions::KB2DIR[id]) if Directions::KB2DIR.include?(id)

    finish_placing if @valid && id == Gosu::KbReturn

    @room.rotate if id == Gosu::KbR

    validate

    @needs_redraw = true
  end

  def start_placing(dock)
    @dock = dock
    @dock.start_blinking
  end

  def finish_placing
    puts "DONE"
  end

  def validate
    @valid = @room.fits_with(@dock)
  end

  def draw
    @room.draw

    @needs_redraw = !!@dock
  end

end