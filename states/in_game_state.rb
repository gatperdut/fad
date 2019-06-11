class InGameState

  attr_accessor :current

  def initialize(window)
    @window = window

    @current = nil
  end

  def handle_input(id)
    case @current
    when :place_entry_room
      
    when :place_ordinary_room
      placer.handle_input(id)
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

  def switch_to(new_state, params)
    @current = new_state
    send("switch_to_#{new_state}", params)
  end

  private

  def switch_to_place_entry_room(params)
    @window.map.place_entry_room
    switch_to(:place_ordinary_room, { destination_room: @window.map.rooms.last })
  end

  def switch_to_place_ordinary_room(params)
    @window.map.place_ordinary_room(params[:destination_room])
  end

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