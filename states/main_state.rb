class MainState

  attr_accessor :current

  def initialize(window)
    @window = window
    @current = nil
  end

  def handle_input(id)
    case @current
    when :welcome_page
      switch_to(:character_generation)
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
      welcome_page.draw
    when :character_generation
      character_generation.draw
      key_listing.draw
    when :in_game
      in_game_state.draw
    else
      throw('UNKNOWN STATE!')
    end
  end

  def switch_to(new_state)
    @current = new_state
    send("switch_to_#{new_state}")
  end

  private


  def switch_to_welcome_page

  end

  def switch_to_character_generation
    character_generation.generate
  end

  def switch_to_in_game
    in_game_state.switch_to(:place_entry_room, {})
  end

  def welcome_page
    @window.welcome_page
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