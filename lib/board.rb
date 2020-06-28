class Board
  attr_accessor :board

  def initialize
    @board = {}   # position => ['board piece', occupancy]
    populate_board_on_init
  end

  def populate_board_on_init
    row = [8,7,6,5,4,3,2,1]
    col = ['a','b','c','d','e','f','g','h']
    white = "|   "
    first_white = "   "
    black = "|###"
    first_black = "###"

    row.each_with_index do |num, i|
      col.each_with_index do |letter, j|
        i.even? ? flag = j.even? : flag = j.odd?
        k = ''
        k += letter
        k += num.to_s
        if j == 0
          flag ? @board[k] = [first_white, nil] : @board[k] = [first_black, nil]
        else
          flag ? @board[k] = [white, nil] : @board[k] = [black, nil]
        end
      end
    end
    @board
  end

  def print_board
    puts
    top_axis = "       a   b   c   d   e   f   g   h\n\n"
    bottom_axis = "\n       a   b   c   d   e   f   g   h"
    result = ""
    result += top_axis
    @board.each do |k, v|     # v = [board_piece, occupancy]
      result += "  #{k[1]}   " +  v[0] if k.include?('a')
      result +=  v[0] if !k.include?('a') && !k.include?('h')
      result +=  v[0] + "    #{k[1]}\n" if k.include?('h')
    end
    result += bottom_axis
    puts result
    puts
    return nil
  end

end
