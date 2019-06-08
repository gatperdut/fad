module MainKeyListing

  def draw_welcome_page
    @images[:kb_arrows].draw(1300, 370, 0, 0.5, 0.5)
    @font.draw_text('Move room', 1450, 390, 0, 1.0, 1.0, 0xFF222222)

    @images[:R].draw(1330, 520, 0, 0.5, 0.5)
    @font.draw_text('Rotate', 1450, 520, 0, 1.0, 1.0, 0xFF222222)

    @images[:enter].draw(1300, 610, 0, 0.1, 0.1)
    @font.draw_text('Accept', 1450, 640, 0, 1.0, 1.0, placer.valid? ? 0xFF222222 : 0xFF888888)

    @images[:esc].draw(1330, 740, 0, 0.5, 0.5)
    @font.draw_text('Cancel', 1450, 740, 0, 1.0, 1.0, 0xFF222222)
  end

  def draw_character_generation
    @images[:G].draw(1330, 440, 0, 0.5, 0.5)
    @font.draw_text('Generate', 1450, 440, 0, 1.0, 1.0, 0xFF222222)

    @images[:enter].draw(1300, 590, 0, 0.1, 0.1)
    @font.draw_text('Accept', 1450, 620, 0, 1.0, 1.0, 0xFF222222)
  end

  def draw_in_game
    send("draw_#{in_game_state.current}")
  end

end