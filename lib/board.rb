# create and populate an empty board
require "./lib/chessmen.rb"
require "./lib/pawn.rb"

class Board
  attr_accessor :board, :player_white, :player_black, :chessmen

  def initialize
    @board = {}   # position => ['board piece', occupancy]
    @pieces = {
      "rook"   => 'r'  ,
      "knight" => 'kn' ,
      "bishop" => 'b'  ,
      "queen"  => 'Q'  ,
      "king"   => 'K'  ,
      "pawn"   => 'p'
    }
    @chessmen = Chessmen.new
    @player_white = @chessmen.white
    @player_black = @chessmen.black
    populate_board_on_init
  end


  def populate_board
    chessmen_attributes = grab_chessmen_position_name
    @board.each do |position, value_pair|     # value pair = [board piece, occupancy]
      chessmen_attributes.each do |piece_attr|
        if piece_attr.include?(position)
          value_pair[1] = piece_attr[1]   # occupancy = name
          value_pair[0] = place_chessmen(value_pair[0].length, piece_attr[1], value_pair[0])
        end
      end
    end
    print_board
    @board
  end

  private

  def grab_chessmen_position_name
    players = [self.player_white, self.player_black]
    attributes = []
    players.each do |player|
      player.each do |type, pieces|
        pieces.each do |piece|
          name = piece.name
          position = piece.position
          attributes << [position, name]
        end
      end
    end
    return attributes
  end

  def place_chessmen(length, type, board_piece)
    if length == 3
      if type == "knight"   # special case for knight -> 'kn'
        first = board_piece[0]
        second = @pieces[type][0]
        third = @pieces[type][1]
      else
        first = board_piece[0]
        second = @pieces[type]
        third = board_piece[2]
      end
      result = first+second+third
    else
      if type == "knight"
        first = board_piece[0]
        second = board_piece[1]
        third = @pieces[type][0]
        fourth = @pieces[type][1]
      else
        first = board_piece[0]
        second = board_piece[1]
        third = @pieces[type]
        fourth = board_piece[3]
      end
      result = first+second+third+fourth
    end
    result
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
        # print " i:#{i},j:#{j} |"
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

board = Board.new
board.populate_board
