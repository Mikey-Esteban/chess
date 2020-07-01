class Pawn
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'pawn'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    # p "In Pawn.move_valid Instance method!"
    diff = end_square[1].to_i - start_square[1].to_i

    return "Pawn cant make a non vertical move!" if start_square[0] != end_square[0]
    if self.color == 'white'
      return "#{self.color} pawn can only move up" unless diff == 1
    elsif self.color == 'black'
      return "#{self.color} pawn can only move down" unless diff == -1
    end

    true
  end

  def pawn_take_valid?(start_square, end_square)
    # p "In Pawn.pawn_take_valid Instance method!"
    column_diff = end_square[0].ord - start_square[0].ord
    row_diff = end_square[1].to_i - start_square[1].to_i

    return "Pawn needs to move one diagonal" unless column_diff == 1 || column_diff == -1
    if self.color == 'white'
      return "#{self.color} Pawn can't move down" unless row_diff == 1
    elsif self.color == 'black'
      return "#{self.color} Pawn can't move up" unless row_diff == -1
    end

    true
  end
end
