class State

  def initialize(window)
    @window = window
    @current = :PLACING
  end

  def handle_input(id)
    case @current
    when :PLACING
      placer.handle_input(id)
    else
      throw('UNKNOWN STATE!')
    end
  end

  def map
    @window.map
  end

  def placer
    map.placer
  end

end