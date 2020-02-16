class Trimmer

  def initialize(window, dock_tile)
    @window = window

    @dock_tile = dock_tile

    @visited = []
  end

  def call
    trim_out_of_boundaries

    floorize_invalidated_docks

    trim_overlapping_tiles

    trim_unconnected_tiles
  end

  def trim_out_of_boundaries
    room.layout.all_tiles.each do |tile|
      tile.remove_self unless @window.map.within_boundaries?(tile.world_coord)
    end
  end

  def floorize_invalidated_docks
    docks_to_floorize = []

    @window.map.rooms.each do |room|
      room.layout.dock_tiles.each do |dock|
        next unless dock.connection.nil?

        needs_floorizing = !@window.map.within_boundaries?(dock.dest_coord)

        needs_floorizing = true if !needs_floorizing && @window.map.taken.taken_at(dock.dest_coord) && dock.connection.nil?

        docks_to_floorize << dock if needs_floorizing
      end
    end

    docks_to_floorize.each do |dock|
      dock.turn_to_floor
    end
  end

  def trim_overlapping_tiles
    @window.map.placer.overlaps.each do |tile|
      tile.remove_self
    end
  end

  def trim_unconnected_tiles
    explore_tile(@dock_tile)

    (room.layout.all_tiles - @visited).each do |tile|
      tile.remove_self
    end
  end

  def explore_tile(tile)
    return if @visited.include?(tile)

    @visited << tile

    Directions::DIRS.each do |direction|
      adjacent_tile = tile.adjacent_tile(direction)
      explore_tile(adjacent_tile) unless adjacent_tile.nil?
    end
  end

  def room
    @dock_tile.layout.room
  end

end
