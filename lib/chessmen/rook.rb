class Rook
  attr_accessor :position, :name, :color, :has_moved

  def initialize(position, color)
    @name = 'rook'
    @position = position
    @color = color
    @has_moved = false
  end

  def move_valid?(start_square, end_square)
    # p "In Rook.move_valid Instance method!"
    column_diff =  start_square[0] != end_square[0] if start_square[0] != end_square[0]
    row_diff = start_square[1] != end_square[1] if start_square[1] != end_square[1]
    diagonal = column_diff && row_diff
    return "#{self.name} cant make a diagonal move" if diagonal

    @has_moved = true
    true
  end

  def check_next_square(start_square, end_square)
    # p "In Rook.check_next_square Instance method!"
    row_diff = start_square[1] != end_square[1] if start_square[1] != end_square[1]
    column_diff =  start_square[0] != end_square[0] if start_square[0] != end_square[0]
    next_square = "  "
    # p "next square before: #{next_square}"
    if row_diff
      next_square[1] = (end_square[1].to_i - 1).to_s if start_square[1] < end_square[1]
      next_square[1] = (end_square[1].to_i + 1).to_s if start_square[1] > end_square[1]
      next_square[0] = end_square[0]
    elsif column_diff
      next_square[0] = (end_square[0].ord - 1).chr if start_square[0].ord < end_square[0].ord
      next_square[0] = (end_square[0].ord + 1).chr if start_square[0].ord > end_square[0].ord
      next_square[1] = end_square[1]
    end
    next_square
  end
end
