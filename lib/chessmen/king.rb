class King
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'king'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    p "In King.move_valid Instance method!"
    column_diff = (end_square[0].ord - start_square[0].ord).abs
    row_diff = (end_square[1].to_i - start_square[1].to_i).abs

    return "King cant move that far away!" if column_diff > 1 || row_diff > 1
  end

end
