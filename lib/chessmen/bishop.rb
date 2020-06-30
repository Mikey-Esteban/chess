class Bishop
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'bishop'
    @position = position
    @color = color
  end

  def move_valid?(start_square, end_square)
    p "In Bishop.move_valid Instance method!"
    same_row = true if start_square[1] == end_square[1]
    same_column = true if start_square[0] == end_square[0]
    return "#{self.name} cant make a non diagonal move" if same_column || same_row

    column_diff =  (end_square[0].ord - start_square[0].ord).abs
    row_diff = (end_square[1].to_i - start_square[1].to_i).abs
    delta = column_diff - row_diff
    return "not a true diagonal" unless delta == 0

    true
  end

  def check_next_square(start_square, end_square)
    # p "In Bishop.check_next_square Instance method"
    next_square = end_square
    # p "next square before: #{next_square}"

    next_square[1] = (end_square[1].to_i - 1).to_s if start_square[1] < end_square[1]
    next_square[1] = (end_square[1].to_i + 1).to_s if start_square[1] > end_square[1]

    next_square[0] = (end_square[0].ord - 1).chr if start_square[0].ord < end_square[0].ord
    next_square[0] = (end_square[0].ord + 1).chr if start_square[0].ord > end_square[0].ord

    next_square
  end
end
