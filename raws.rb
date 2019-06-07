require 'json'

require './layout'

class Raws

  attr_reader :data

  def initialize
    file = File.read('data/rooms.json')
    @data= JSON.parse(file)

    validate
  end

  private

  def validate
    @data.each do |key, raw|
      valid = true
      print "Loading raw room #{key} ... "
      first_width = raw[0].length
      0.upto(raw.length - 1) do |h|
        valid = false if raw[h].length != first_width
      end
      if valid
        puts "#{raw.length}x#{first_width} OK."
      else
        puts "WRONG FORMAT!"
      end
    end
  end


end