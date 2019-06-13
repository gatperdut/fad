class IdleState

  attr_reader :current

  def initialize(window)
    @window = window
    @current = nil
  end

  def handle_input(id)
    case @current
    when :general_menu
      in_game_state.switch_to(:choose_next_dock, { }) if id == Gosu::KbV
    else
      error_out
    end
  end

  def draw
    case @current
    when :general_menu
      map.draw
      key_listing.draw
    else
      error_out
    end
  end

  def switch_to(new_state, params)
    @current = new_state
    send("switch_to_#{new_state}", params)
  end

  private

  def switch_to_general_menu(params)

  end

  def map
    @window.map
  end

  def in_game_state
    @window.in_game_state
  end

  def error_out
    throw("UNKNOWN IDLE STATE #{@current}!")
  end

end