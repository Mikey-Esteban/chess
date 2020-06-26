# create and populate an empty board

class Board
  attr_accessor :board

  def initialize
    @board = {}
    @pieces = {
      :rook   => 'r'  ,
      :knight => 'kn' ,
      :bishop => 'b'  ,
      :queen  => 'Q'  ,
      :king   => 'K'  ,
      :pawn   => 'p'
    }
  end


  def populate_chessmen
    populate_no_pieces
    @board.each do |k,v|
      if k.include?(7) || k.include?(2)
        if v.length == 3
          board[k] = add_chessmen(3, :pawn, board[k])
        else
          board[k] = add_chessmen(4, :pawn, board[k])
        end
      elsif k.include?(8)
        fill_pieces(k)
      elsif k.include?(1)
        fill_pieces(k)
      end
    end
    show_board_no_pieces
    @board
  end

  private

  def fill_pieces(key)
    if key.include?('a')
      board[key] = add_chessmen(3, :rook, board[key])
    elsif key.include?('b') || key.include?('g')
      board[key] = add_chessmen(4, :knight, board[key])
    elsif key.include?('c') || key.include?('f')
      board[key] = add_chessmen(4, :bishop, board[key])
    elsif key.include?('d')
      board[key] = add_chessmen(4, :queen, board[key])
    elsif key.include?('e')
      board[key] = add_chessmen(4, :king, board[key])
    elsif key.include?('h')
      board[key] = add_chessmen(4, :rook, board[key])
    end
  end

  def add_chessmen(length, piece, key)
    if length == 3
      if piece == :knight
        first = key[0]
        second = @pieces[piece][0]
        third = @pieces[piece][1]
      else
        first = key[0]
        second = @pieces[piece]
        third = key[2]
      end
      result = first+second+third
    else
      if piece == :knight
        first = key[0]
        second = key[1]
        third = @pieces[piece][0]
        fourth = @pieces[piece][1]
      else
        first = key[0]
        second = key[1]
        third = @pieces[piece]
        fourth = key[3]
      end
      result = first+second+third+fourth
    end
    result
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
        k = [letter, num]
        # print " i:#{i},j:#{j} |"
        if j == 0
          flag ? @board[k] = first_white : @board[k] = first_black
        else
          flag ? @board[k] = white : @board[k] = black
        end
      end
    end
    @board
  end

  def show_board_no_pieces
    puts
    top_axis = "       a   b   c   d   e   f   g   h\n\n"
    bottom_axis = "\n       a   b   c   d   e   f   g   h"
    result = ""
    result += top_axis
    @board.each do |k,v|
      result += "  #{k[1]}   " + v if k.include?('a')
      result += v if !k.include?('a') && !k.include?('h')
      result += v + "    #{k[1]}\n" if k.include?('h')
    end
    result += bottom_axis
    puts result
    puts
    return nil
  end

end
