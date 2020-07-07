class King
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'king'
    @position = position
    @color = color
    @has_moved = false
  end

  def move_valid?(start_square, end_square)
    # p "In King.move_valid Instance method!"
    column_diff = (end_square[0].ord - start_square[0].ord).abs
    row_diff = (end_square[1].to_i - start_square[1].to_i).abs

    return "King cant move that far away!" if column_diff > 1 || row_diff > 1

    @has_moved = true
    true
  end

  def check_knight_squares
    cols = 'abdcefgh'
    rows = '12345678'
    possible_knights = [
        {:col => 2, :row => 1 },
        {:col => 2, :row => -1 },
        {:col => -2, :row => 1 },
        {:col => -2, :row => -1 },
        {:col => 1, :row => 2 },
        {:col => -1, :row => 2 },
        {:col => 1, :row => -2 },
        {:col => -1, :row => -2},
    ]
    result = []

    possible_knights.each do |change|
      square = ''
      square += (@position[0].ord + change[:col]).chr
      square += (@position[1].to_i + change[:row]).to_s
      result << square if cols.include?(square[0]) && rows.include?(square[1]) && square.length == 2
    end

    result
  end

  def check_next_square(start_square, direction)
    # will either return end_of_board or next_square
    col = start_square[0]
    row = start_square[1]
    next_square = ''
    end_of_board = true

    if direction == 'left'
      # puts "checking left..."
      return end_of_board if start_square[0] == 'a'
      next_square += (col.ord - 1).chr
      next_square += row
    elsif direction == 'right'
      # puts "checking right..."
      return end_of_board if start_square[0] == 'h'
      next_square += (col.ord + 1).chr
      next_square += row
    elsif direction == 'up'
      # puts "checking up..."
      return end_of_board if start_square[1] == '8'
      next_square += col
      next_square += (row.to_i + 1).to_s
    elsif direction == 'down'
      # puts "checking down..."
      return end_of_board if start_square[1] == '1'
      next_square += col
      next_square += (row.to_i - 1).to_s
    elsif direction == 'up_left'
      # puts "checking upleft..."
      return end_of_board if start_square[0] == 'a' || start_square[1] == '8'
      next_square += (col.ord - 1).chr
      next_square += (row.to_i + 1).to_s
    elsif direction == 'up_right'
      # puts "checking upright..."
      return end_of_board if start_square[0] == 'h' || start_square[1] == '8'
      next_square += (col.ord + 1).chr
      next_square += (row.to_i + 1).to_s
    elsif direction == 'down_left'
      # puts "checking downleft..."
      return end_of_board if start_square[0] == 'a' || start_square[1] == '1'
      next_square += (col.ord - 1).chr
      next_square += (row.to_i - 1).to_s
    elsif direction == 'down_right'
      # puts "checking downright..."
      return end_of_board if start_square[0] == 'h' || start_square[1] == '1'
      next_square += (col.ord + 1).chr
      next_square += (row.to_i - 1).to_s
    end

    next_square
  end

end
