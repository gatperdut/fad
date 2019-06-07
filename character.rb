require './utils/names'

class Character

  attr_reader :klass
  attr_reader :level
  attr_reader :name
  attr_reader :portrait

  include Names

  def initialize(window, klass)
    @window = window

    @klass = klass

    @level = 1

    @name = Names::LIST[klass].sample

    @portrait = @window.image("media/portraits/#{klass}_#{[1, 2].sample}.png")
  end

end