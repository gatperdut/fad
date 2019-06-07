class State

  attr_accessor :current

  def initialize(window)
    @window = window
    @current = :CHARGEN
  end

  def handle_input(id)
    case @current
    when :PLACING
      placer.handle_input(id)
    when :CHARGEN
      chargen.handle_input(id)
    else
      throw('UNKNOWN STATE!')
    end
  end

  def chargen
    @window.chargen
  end

  def map
    @window.map
  end

  def placer
    map.placer
  end

end