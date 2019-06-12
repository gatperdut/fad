require './coord'
require './utils/directions'

class Room

  attr_reader :window
  attr_reader :layout
  attr_reader :coord
  attr_reader :needs_redraw
  alias_method :needs_redraw?, :needs_redraw

  include Directions

  def initialize(window, raw)
    @window = window
    @layout = Layout.new(self, raw)

    @needs_redraw = false
  end

  def draw
    @layout.draw

    @needs_redraw = false
  end

  def fit_for(dock_tile)
    @layout.fit_for(dock_tile)
  end

  def seed_room?
    self.class.to_s.to_sym == :SeedRoom
  end

  def entry_room?
    self.class.to_s.to_sym == :EntryRoom
  end

  def ordinary_room?
    self.class.to_s.to_sym == :OrdinaryRoom
  end

  protected

  def map
    @window.map
  end

end