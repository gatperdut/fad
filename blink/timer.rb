class Timer

  attr_reader :t

  def initialize
    reset
  end

  def reset
    @t = 0.0
  end

  def update
    @t = @t + 0.05
  end

end