require './characters/frame'
require './characters/character'
require './utils/classes'

class CharacterGeneration

  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Classes

  def initialize(window)
    @window = window

    @frames = []

    @needs_redraw = false

    generate
  end

  def generate
    @frames.clear

    1.upto(4) do |n|
      character = Character.new(@window, Classes::ALL.sample)
      @frames << Frame.new(@window, character)
    end

    @needs_redraw = true
  end

  def draw
    0.upto(1) do |y|
      0.upto(1) do |x|
        @frames[y * 2 + x].draw(y, x)
      end
    end

    @needs_redraw = false
  end

  def accept
    main_state.current = :in_game

    @needs_redraw = true
  end

  def handle_input(id)
    generate if id == Gosu::KbG

    accept if id == Gosu::KbReturn
  end

  def main_state
    @window.main_state
  end

end