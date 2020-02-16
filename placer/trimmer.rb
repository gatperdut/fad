class Trimmer

  def initialize(window)
    @window = window

    @visited = nil
  end

  def trim(room, dock_tile)
    room.layout.all_tiles.each do |tile|
      tile.remove_self unless @window.map.within_boundaries?(tile.world_coord)
    end

    explore_launch(dock_tile)

    (room.layout.all_tiles - @visited).each do |tile|
      tile.remove_self
    end
  end

  def explore_launch(dock_tile)
    @visited = []
    explore_tile(dock_tile)
  end

  def explore_tile(tile)
    return if @visited.include?(tile)

    @visited << tile

    Directions::DIRS.each do |direction|
      adjacent_tile = tile.adjacent_tile(direction)
      explore_tile(adjacent_tile) unless adjacent_tile.nil?
    end
  end

end
