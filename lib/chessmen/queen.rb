class Queen
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'queen'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    # THIS IS THE DIAGONAL SECTION
    # p "In Queen.move_valid Instance method!"
    start_square[1] == end_square[1] ? same_row = true : same_row = false
    start_square[0] == end_square[0] ? same_column = true : same_column = false

    if (!same_row && !same_column)
      # p "Checking proper Queen diagonal move!"
      column_diff =  (end_square[0].ord - start_square[0].ord).abs
      row_diff = (end_square[1].to_i - start_square[1].to_i).abs
      delta = column_diff - row_diff

      delta == 0 ? result = 1 : result = 0    # 1 calls a dianogonal checker, 0 is an invalid move
      return result
    end
    return -1   # horizontal or vertical checker
  end

  def check_next_square_diagonal(start_square, end_square)
    # p "In Queen.check_next_square_diagonal Instance method"
    next_square = "  "
    # p "next square before: #{next_square}"

    next_square[1] = (end_square[1].to_i - 1).to_s if start_square[1] < end_square[1]
    next_square[1] = (end_square[1].to_i + 1).to_s if start_square[1] > end_square[1]

    next_square[0] = (end_square[0].ord - 1).chr if start_square[0].ord < end_square[0].ord
    next_square[0] = (end_square[0].ord + 1).chr if start_square[0].ord > end_square[0].ord

    next_square
  end

  def check_next_square_hv(start_square, end_square)
    # p "In Queen.check_next_square_hv Instance method!"
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
