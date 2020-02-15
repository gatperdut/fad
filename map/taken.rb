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

  def taken_at(y, x)
    @grid[y][x]
  end

  def within_boundaries?(y, x)
    return false if y < 0

    return false if x < 0

    return false if y >= height

    return false if x >= width

    true
  end

  def overlaps?(room)
    coord = room.coord

    result = false

    room.layout.height.times do |y|
      room.layout.width.times do |x|
        next unless within_boundaries?(coord.y + y, coord.x + x)

        if !room.layout.void?(y, x) && taken_at(coord.y + y, coord.x + x)
          room.layout.tile_at(y, x).overlapping = true
          result = true
        end
      end
    end

    result
  end

end
