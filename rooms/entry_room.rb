require './rooms/room'

class EntryRoom < Room

  def initialize(window, raw)
    super(window, raw)

    set_coord
  end

  private

  def set_coord
    0.upto(@layout.height - 1) do |y|
      0.upto(@layout.width - 1) do |x|
        if @layout.sym(y, x) == :x
          @coord = Coord.new(map.size.y - 1 - y, map.size.x / 2 - x)
          break
        end
      end
    end

    throw ('Entry room with no entry tile!') if @coord.nil?
  end

end