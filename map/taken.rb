class Taken

  def initialize(window)
    @window = window

    @grid = []
  end

  def setup_grid
    @window.map.size.y.times do |y|
      @grid[y] = []
      @window.map.size.x.times do |x|
        @grid[y][x] = false
      end
    end
  end

  def height
    @grid.length
  end

  def width
    @grid[0].length
  end

  def add(room)
    coord = room.coord

    room.layout.height.times do |y|
      room.layout.width.times do |x|
        @grid[coord.y + y][coord.x + x] = true unless room.layout.void?(y, x)
      end
    end
  end

  def taken_at(coord)
    @grid[coord.y][coord.x]
  end

  def overlaps?(room)
    result = false

    room.layout.height.times do |y|
      room.layout.width.times do |x|
        tile_relative_coord = Coord.new(y, x)
        tile_world_coord = room.coord + Coord.new(y, x)

        next unless @window.map.within_boundaries?(tile_world_coord)

        if !room.layout.void?(y, x) && taken_at(tile_world_coord)
          room.layout.tile_at(tile_relative_coord).overlapping = true
          result = true
        end
      end
    end

    result
  end

end
