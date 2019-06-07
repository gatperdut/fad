require 'gosu'

require './state'
require './map'
 
class Window < Gosu::Window

  attr_reader :map

  def initialize(width=1000, height=1200, fullscreen=false)
    super
    self.caption = 'FAD'

    @state = State.new(self)

    @map = Map.new(self)

    @scene_ready = false
  end

  def update

  end

  def button_down(id)
    close if id == Gosu::KbEscape

    @state.handle_input(id)
  end

  def needs_cursor?
    true
  end

  def needs_redraw?
    !@scene_ready || @map.needs_redraw?
  end

  def draw
    @map.draw
    @scene_ready = true
  end
end

window = Window.new
window.show
