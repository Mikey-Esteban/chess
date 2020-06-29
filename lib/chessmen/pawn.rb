class Pawn
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'pawn'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    p "In Pawn.move_valid Instance method!"
    diff = end_square[1].to_i - start_square[1].to_i

    return false if start_square[0] != end_square[0]
    return diff == 1 if self.color == 'white'
    return diff == -1 if self.color == 'black'
  end

  def pawn_take_valid?(start_square, end_square)
    p "In Pawn.pawn_take_valid Instance method!"
    column_diff = end_square[0].ord - start_square[0].ord
    row_diff = end_square[1].to_i - start_square[1].to_i

    return false unless column_diff == 1 || column_diff == -1
    return row_diff == 1 if self.color == 'white'
    return row_diff == -1 if self.color == 'black'
  end
end
