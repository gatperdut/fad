require 'gosu'

require './states/main_state'
require './states/in_game_state'
require './welcome_page'
require './character_generation'
require './encounter_generator'
require './map'
require './key_listing/key_listing'
 
class Window < Gosu::Window

  attr_reader :main_state
  attr_reader :in_game_state
  attr_reader :welcome_page
  attr_reader :character_generation
  attr_reader :map
  attr_reader :key_listing

  def initialize(width=2000, height=1200, fullscreen=false)
    super
    self.caption = 'FAD'

    @main_state = MainState.new(self)

    @in_game_state = InGameState.new(self)

    @welcome_page = WelcomePage.new(self)

    @character_generation = CharacterGeneration.new(self)

    @encounter_generator = EncounterGenerator.new(self)

    @key_listing = KeyListing.new(self)

    @map = Map.new(self)
    @map.load_raws

    @main_state.switch_to(:welcome_page)

    @scene_ready = false

    @font = font(30, Gosu::default_font_name)
  end

  def font(size, name='media/thieving-mice.ttf')
    Gosu::Font.new(self, name, size)
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
    draw_state_names

    @main_state.draw

    @scene_ready = true
  end

  private

  def draw_state_names
    @font.draw_text(@main_state.current, 10, 10, 0, 1.0, 1.0, 0xFFFFFFFF)

    @font.draw_text(@in_game_state.current, 10, 1170, 0, 1.0, 1.0, 0xFFFFFFFF)
  end
end

window = Window.new
window.show
