class Rook
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'rook'
    @position = position
    @color = color
  end
end
