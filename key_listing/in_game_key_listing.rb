module InGameKeyListing

  def draw_place_seed_room

  end

  def draw_place_entry_room

  end

  def draw_place_ordinary_room
    @images[:kb_arrows].draw(1300, 330, 0, 0.5, 0.5)
    @font.draw_text('Move room', 1450, 350, 0, 1.0, 1.0, 0xFF222222)

    @images[:R].draw(1330, 440, 0, 0.5, 0.5)
    @font.draw_text('Rotate', 1450, 445, 0, 1.0, 1.0, 0xFF222222)

    @images[:enter].draw(1295, 600, 0, 0.1, 0.1)
    @font.draw_text('Accept', 1455, 630, 0, 1.0, 1.0, placer.valid? ? 0xFF222222 : 0xFF888888)

    @images[:esc].draw(1330, 730, 0, 0.5, 0.5)
    @font.draw_text('Cancel', 1450, 730, 0, 1.0, 1.0, 0xFF222222)
  end

  def draw_choose_next_dock
    @images[:C].draw(1330, 530, 0, 0.5, 0.5)
    @font.draw_text('Cycle exit', 1450, 535, 0, 1.0, 1.0, dock_chooser.can_cycle? ? 0xFF222222 : 0xFF888888)

    @images[:enter].draw(1295, 600, 0, 0.1, 0.1)
    @font.draw_text(dock_chooser.seed_room? ? 'Enter dungeon' : 'Accept', 1455, 630, 0, 1.0, 1.0, 0xFF222222)
  end

  def draw_face_encounter
    @font.draw_text('TO-DO', 1450, 620, 0, 1.0, 1.0, 0xFF222222)
  end

end