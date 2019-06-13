class Party

  attr_reader :room

  def initialize(window)
    @window = window

    @characters = []

    @room = nil

    @tile = nil

    @image = @window.image("media/party.png")
  end

  def move_to(room)
    @room = room
    
    @tile = room.layout.floor_tiles.sample

    @tile = room.layout.dock_tiles.sample if @tile.nil?
  end

  def draw
    @image.draw(@tile.west_boundary, @tile.north_boundary, 0, 0.2, 0.2)
  end

end