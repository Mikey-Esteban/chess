# create and populate an empty board

class Board
  attr_accessor :empty_board

  def initialize
    @empty_board = {}
    @pieces = {
      :rook   => 'r'  ,
      :knight => 'kn' ,
      :bishop => 'b'  ,
      :queen  => 'Q'  ,
      :king   => 'K'  ,
      :pawn   => 'p'
    }
    # self.populate_no_pieces
  end


  def populate_chessmen
    populate_no_pieces
    @empty_board.each do |k,v|
      if k.include?(7) || k.include?(2)
        if v.length == 3
          empty_board[k] = add_chessmen(3, :pawn, empty_board[k])
        else
          empty_board[k] = add_chessmen(4, :pawn, empty_board[k])
        end
      elsif k.include?(8)
        fill_pieces(k)
      elsif k.include?(1)
        fill_pieces(k)
      end
    end
    show_board_no_pieces
    @empty_board
  end

  private

  def fill_pieces(key)
    if key.include?('a')
      empty_board[key] = add_chessmen(3, :rook, empty_board[key])
    elsif key.include?('b') || key.include?('g')
      empty_board[key] = add_chessmen(4, :knight, empty_board[key])
    elsif key.include?('c') || key.include?('f')
      empty_board[key] = add_chessmen(4, :bishop, empty_board[key])
    elsif key.include?('d')
      empty_board[key] = add_chessmen(4, :queen, empty_board[key])
    elsif key.include?('e')
      empty_board[key] = add_chessmen(4, :king, empty_board[key])
    elsif key.include?('h')
      empty_board[key] = add_chessmen(4, :rook, empty_board[key])
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
board.populate_chessmen
