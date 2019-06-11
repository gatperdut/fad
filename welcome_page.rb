class WelcomePage

  def initialize(window)
    @window = window

    @font = @window.font(50)
  end

  def draw
    @font.draw_text('Four Against Darkness', 750, 640, 0, 1.0, 1.0, 0xFF222222)
  end

end