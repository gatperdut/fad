module MainKeyListing

  def draw_welcome_page
    
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