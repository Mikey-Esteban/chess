class Bishop 
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'bishop'
    @position = position
    @color = color
  end
end
