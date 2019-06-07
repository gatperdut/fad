require './character'
require './utils/classes'

class Chargen

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Classes

  def initialize(window)
    @window = window

    @characters = []

    @frame = @window.image("media/portraits/frame.png")

    @font = @window.font(50)

    @needs_redraw = false

    generate
  end

  def generate
    @characters.clear

    1.upto(4) do |n|
      @characters << Character.new(@window, Classes::ALL.sample)
    end

    @needs_redraw = true
  end

  def draw
    0.upto(1) do |y|
      0.upto(1) do |x|
        character = @characters[y * 2 + x]

        character.portrait.draw(200 + x * 400, 240 + y * 500, 0, 1.0, 1.0)
        @frame.draw(185 + x * 400, 220 + y * 500, 0, 0.89, 0.89)

        @font.draw_text("#{character.name}", 200 + x * 400, 400 + y * 500, 0, 1.0, 1.0, 0xFF888888)
        @font.draw_text("#{character.klass} Lvl #{character.level}", 170 + x * 400, 450 + y * 500, 0, 1.0, 1.0, 0xFF888888)
      end
    end

    @needs_redraw = false
  end

  def handle_input(id)
    generate if id == Gosu::KbG
  end

end