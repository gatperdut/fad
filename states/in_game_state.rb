class InGameState

  attr_accessor :current

  def initialize(window)
    @window = window

    @current = nil
  end

  def handle_input(id)
    case @current
    when :place_seed_room

    when :place_entry_room
      
    when :place_ordinary_room
      placer.handle_input(id)
    when :choose_next_dock
      dock_chooser.handle_input(id)
    when :face_encounter
      switch_to(:choose_next_dock, { room: map.rooms.last })
    else
      error_out
    end
  end

  def draw
    case @current
    when :place_seed_room
      map.draw
      key_listing.draw
    when :place_entry_room
      map.draw
      key_listing.draw
    when :place_ordinary_room
      map.draw
      key_listing.draw
    when :choose_next_dock
      map.draw
      key_listing.draw
    when :face_encounter
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

  def switch_to_place_seed_room(params)
    @window.map.place_seed_room
    switch_to(:choose_next_dock, { room: map.rooms.last })
  end

  def switch_to_place_entry_room(params)
    @window.map.place_entry_room
    switch_to(:face_encounter, { room: map.rooms.last })
  end

  def switch_to_place_ordinary_room(params)
    @window.map.place_ordinary_room(params[:dock])
  end

  def switch_to_choose_next_dock(params)
    @window.map.choose_next_dock(params[:room])
  end

  def switch_to_face_encounter(params)

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

  def dock_chooser
    map.dock_chooser
  end

  def error_out
    throw("UNKNOWN IN-GAME STATE #{@current}!")
  end

end