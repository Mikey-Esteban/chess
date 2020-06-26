class Chessmen
end

class Pawn < Chessmen
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
  end

  def move
    @position[1] = (@position[1].to_i + 1).to_s if @color == 'white'
    @position[1] = (@position[1].to_i - 1).to_s if @color == 'black'
  end
end
