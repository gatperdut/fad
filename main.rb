require 'gosu'

require './state'
require './chargen'
require './map'
require './menu'
 
class Window < Gosu::Window

  attr_reader :state
  attr_reader :chargen
  attr_reader :map

  def initialize(width=2000, height=1200, fullscreen=false)
    super
    self.caption = 'FAD'

    @state = State.new(self)

    @chargen = Chargen.new(self)

    @menu = Menu.new(self)

    @map = Map.new(self)

    @scene_ready = false
  end

  def font(size)
    Gosu::Font.new(self, 'media/thieving-mice.ttf', size)
  end

  def image(path)
    Gosu::Image.new(path, tileable: true)
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
    !@scene_ready || @map.needs_redraw? || @chargen.needs_redraw?
  end

  def draw
    case @state.current
    when :CHARGEN
      @chargen.draw
      @menu.draw
    when :PLAYING
      @map.draw
      @menu.draw
      
    when :PLACING
      @map.draw
      @menu.draw
    else
      throw('UNKNOWN STATE!')
    end
    @scene_ready = true
  end
end

window = Window.new
window.show
