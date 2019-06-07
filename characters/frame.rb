class Frame

  def initialize(window, character)
    @window = window

    @character = character

    @frame = @window.image("media/portraits/frame.png")

    @font = @window.font(50)
  end

  def text_center(font, center, y, text, color)
    w = font.text_width(text)

    x = center - w / 2

    font.draw_text(text, x, y, 0, 1.0, 1.0, color)
  end

  def draw(y, x)
    @character.portrait.draw(200 + x * 400, 240 + y * 500, 0, 1.0, 1.0)
    @frame.draw(185 + x * 400, 220 + y * 500, 0, 0.89, 0.89)

    text_center(@font, 280 + x * 400, 400 + y * 500, "#{@character.name}", 0xFF888888)
    text_center(@font, 280 + x * 400, 450 + y * 500, "#{@character.klass.to_s.capitalize} Lvl #{@character.level}", 0xFF888888)
  end

end