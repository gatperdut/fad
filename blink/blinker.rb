require './blink/timer'

class Blinker


  def initialize
    @timer = Timer.new

    reset
  end

  def start
    @running = true
  end

  def stop
    @running = false
    @timer.reset
    @output = 1.0
  end
  alias_method :reset, :stop

  def blink
    if @running
      @timer.update
      @output = (Math.sin(@timer.t) + 1.0) / 2.0
    end
  end

  def modulated_color(r, g, b)
    Gosu::Color.new(0xFF, r * @output, g * @output, b * @output)
  end

end