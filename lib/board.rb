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


end
