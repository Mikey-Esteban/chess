# create and populate an empty board

class Board
  attr_accessor :empty_board

  def initialize
    @empty_board = {}
    self.populate_no_pieces
  end

  def populate_no_pieces
    row = [8,7,6,5,4,3,2,1]
    col = ['a','b','c','d','e','f','g','h']
    white = "|   "
    first_white = "   "
    black = "|###"
    first_black = "###"

    row.each_with_index do |num, i|
      col.each_with_index do |letter, j|
        i.even? ? flag = j.even? : flag = j.odd?
        k = [num, letter]
        # print " i:#{i},j:#{j} |"
        if j == 0
          flag ? @empty_board[k] = first_white : @empty_board[k] = first_black
        else
          flag ? @empty_board[k] = white : @empty_board[k] = black
        end
      end
    end
    @empty_board
  end

  def show_board_no_pieces
    result = ""
    @empty_board.each do |k,v|
      result += v unless k.include?('h')
      result += v+"\n" if k.include?('h')
    end
    puts result
    return nil
  end


end

board = Board.new
board.show_board_no_pieces
