class MainState

  attr_accessor :current

  def initialize(window)
    @window = window
    @current = :character_generation
  end

  def handle_input(id)
    case @current
    when :welcome_page

    when :character_generation
      character_generation.handle_input(id)
    when :in_game
      in_game_state.handle_input(id)
    else
      throw('UNKNOWN STATE!')
    end
  end

  def draw
    case @current
    when :welcome_page

    when :character_generation
      character_generation.draw
      key_listing.draw
    when :in_game
      in_game_state.draw
    else
      throw('UNKNOWN STATE!')
    end
  end

  def character_generation
    @window.character_generation
  end

  def key_listing
    @window.key_listing
  end

  def map
    @window.map
  end

  def in_game_state
    @window.in_game_state
  end

  def placer
    map.placer
  end

end