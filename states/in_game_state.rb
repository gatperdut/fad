class InGameState

  attr_accessor :current

  def initialize(window)
    @window = window

    @current = :place_entry_room
  end

  def handle_input(id)
    case @current
    when :place_entry_room
      placer.handle_input(id)
    when :place_ordinary_room

    else
      error_out
    end
  end

  def draw
    case @current
    when :place_entry_room
      map.draw
      key_listing.draw
    when :place_ordinary_room
      map.draw
      key_listing.draw
    else
    end
  end

  private

  def map
    @window.map
  end

  def key_listing
    @window.key_listing
  end

  def placer
    map.placer
  end

  def error_out
    throw('UNKNOWN IN-GAME STATE!')
  end

end