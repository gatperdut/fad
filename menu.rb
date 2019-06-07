class Menu

  def initialize(window)
    @window = window

    @font = @window.font(50)

    @images = {
      frame:     @window.image('media/parchment.png'),
      kb_arrows: @window.image('media/kb_arrows.png'),
      G:         @window.image('media/G.png'),
      R:         @window.image('media/R.png'),
      esc:       @window.image('media/esc.png'),
      enter:     @window.image('media/enter.png')
    }
  end

  def draw
    draw_frame
    send("draw_#{state.current}")
  end

  def draw_frame
    @images[:frame].draw(1200, 80, 0, 0.7, 0.7)
  end

  def draw_PLACING
    @images[:kb_arrows].draw(1300, 250, 0, 0.5, 0.5)
    @font.draw_text('Move room', 1450, 270, 0, 1.0, 1.0, 0xFF222222)

    @images[:R].draw(1330, 400, 0, 0.5, 0.5)
    @font.draw_text('Rotate', 1450, 400, 0, 1.0, 1.0, 0xFF222222)

    @images[:enter].draw(1300, 490, 0, 0.1, 0.1)
    @font.draw_text('Accept', 1450, 520, 0, 1.0, 1.0, placer.valid? ? 0xFF222222 : 0xFF888888)

    @images[:esc].draw(1330, 620, 0, 0.5, 0.5)
    @font.draw_text('Cancel', 1450, 620, 0, 1.0, 1.0, 0xFF222222)
  end

  def draw_CHARGEN
    @images[:G].draw(1330, 300, 0, 0.5, 0.5)
    @font.draw_text('Generate', 1450, 300, 0, 1.0, 1.0, 0xFF222222)

    @images[:enter].draw(1300, 490, 0, 0.1, 0.1)
    @font.draw_text('Accept', 1450, 520, 0, 1.0, 1.0, 0xFF222222)
  end

  def state
    @window.state
  end

  def map
    @window.map
  end

  def placer
    map.placer
  end

end