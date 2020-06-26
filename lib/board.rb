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

    row.each do |num|
      col.each do |letter|
        k = [num, letter]
        @empty_board[k] = "[ ]"
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
