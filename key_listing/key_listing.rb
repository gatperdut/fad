require './key_listing/main_key_listing'
require './key_listing/in_game_key_listing'

class KeyListing

  include MainKeyListing
  include InGameKeyListing

  def initialize(window)
    @window = window

    @font = @window.font(50)

    @images = {
      frame:     @window.image('media/parchment.png'),
      kb_arrows: @window.image('media/kb_arrows.png'),
      G:         @window.image('media/G.png'),
      R:         @window.image('media/R.png'),
      C:         @window.image('media/C.png'),
      esc:       @window.image('media/esc.png'),
      enter:     @window.image('media/enter.png')
    }
  end

  def draw
    draw_frame
    send("draw_#{main_state.current}")
  end

  def draw_frame
    @images[:frame].draw(1200, 200, 0, 0.7, 0.7)
  end

  def main_state
    @window.main_state
  end

  def in_game_state
    @window.in_game_state
  end

  def map
    @window.map
  end

  def placer
    map.placer
  end

end