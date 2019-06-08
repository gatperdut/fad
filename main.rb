require 'gosu'

require './states/main_state'
require './states/in_game_state'
require './character_generation'
require './map'
require './key_listing/key_listing'
 
class Window < Gosu::Window

  attr_reader :main_state
  attr_reader :in_game_state
  attr_reader :character_generation
  attr_reader :map
  attr_reader :key_listing

  def initialize(width=2000, height=1200, fullscreen=false)
    super
    self.caption = 'FAD'

    @main_state = MainState.new(self)

    @in_game_state = InGameState.new(self)

    @character_generation = CharacterGeneration.new(self)

    @key_listing = KeyListing.new(self)

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

    @main_state.handle_input(id)
  end

  def needs_cursor?
    true
  end

  def needs_redraw?
    !@scene_ready || @map.needs_redraw? || @character_generation.needs_redraw?
  end

  def draw
    @main_state.draw

    @scene_ready = true
  end
end

window = Window.new
window.show
