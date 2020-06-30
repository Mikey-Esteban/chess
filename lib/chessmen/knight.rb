class Knight
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'knight'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    p "In Knight.move_valid Instance method!"
    column_diff =  (end_square[0].ord - start_square[0].ord).abs
    return "knight cant make this column move" if column_diff < 1 || column_diff > 2
    row_diff = (end_square[1].to_i - start_square[1].to_i).abs
    return "knight cant make this row move" if row_diff < 1 || row_diff > 2
    p column_diff
    p row_diff

    return "knight cant make this overall move" unless row_diff == 1 if column_diff == 2
    return "knight cant make this overall move" unless row_diff == 2 if column_diff == 1
    true
  end
end
