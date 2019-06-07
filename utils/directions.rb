require './coord'

module Directions

  DIRS = [
    :n,
    :e,
    :s,
    :w
  ]

  ROTATED = {
    n: :e,
    e: :s,
    s: :w,
    w: :n
  }

  KB2DIR = {
    82 => :n,
    79 => :e,
    81 => :s,
    80 => :w
  }

  INCREMENT = {
    n: Coord.new(-1,  0),
    e: Coord.new( 0,  1),
    s: Coord.new( 1,  0),
    w: Coord.new( 0, -1)
  }

  OPPOSITE = {
    n: :s,
    e: :w,
    s: :n,
    w: :e
  }

end