# create and populate an empty board
require "./lib/chessmen/chessmen.rb"
require "./lib/board.rb"

class Game
  attr_accessor :gb, :player_white, :player_black, :chessmen

  def initialize
    @gb = Board.new
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
  end


  def populate_board
    chessmen_attributes = grab_chessmen_position_name
    @gb.board.each do |position, value_pair|     # value pair = [board piece, occupancy]
      chessmen_attributes.each do |piece_attr|
        if piece_attr.include?(position)
          value_pair[1] = piece_attr[1]   # occupancy = node
          value_pair[0] = place_chessmen(value_pair[0].length, piece_attr[1].name, value_pair[0])
        end
      end
    end
    @gb.print_board
    @gb.board
  end

  def player_turn
    puts "Play move from start square to end square eg. 'a5 to a6'"
    print "What is your move? "
    player_move = gets.chomp
    start, fin = player_move.split(' to ')
    player_move(start, fin)
  end

  def player_move(start_square, end_square)
    start_node = grab_node(start_square)
    end_node = grab_node(end_square)

    return "Your own piece is in the way!" if start_node && end_node && start_node.color == end_node.color

    if start_node.is_a?(Pawn) && !end_node.nil?
      is_valid = start_node.pawn_take_valid?(start_square, end_square)
      return is_valid if is_valid != true
      p "dont need to check node between for #{start_node.name}"
    elsif start_node.is_a?(Queen)
      is_valid = start_node.move_valid?(start_square, end_square)
      return "Queen made a bad move!" if is_valid == 0
      if is_valid == 1
        result = is_node_between?(start_square, end_square, 1)
      elsif is_valid == -1
        result = is_node_between?(start_square, end_square, -1)
      end
      p "is node between?: #{result}"
      return "#{start_node.name} cant make that move!" if result
    elsif start_node.is_a?(King) || start_node.is_a?(Knight) || start_node.is_a?(Pawn)
      is_valid = start_node.move_valid?(start_square, end_square)
      return is_valid if is_valid != true
      p "dont need to check node between for #{start_node.name}"
    else    # for Rook, Bishop
      is_valid = start_node.move_valid?(start_square, end_square)
      return is_valid if is_valid != true
      result = is_node_between?(start_square, end_square)
      p "is node between?: #{result}"
      return "#{start_node.name} cant make that move!" if result
    end

    return "Good move! #{start_node.name}:#{start_square} moves to #{end_square}"
  end

  private

  def is_node_between?(start_square, end_square, queen_checker = nil)
    start_node = @gb.board[start_square][1]

    return false if start_square == end_square

    if start_node.is_a?(Rook) || start_node.is_a?(Bishop)
      next_square = start_node.check_next_square(start_square, end_square)
      next_node = grab_node(next_square)

      return true unless next_node.nil?
      is_node_between?(start_square, next_square)
    elsif start_node.is_a?(Queen)
      next_square = start_node.check_next_square_diagonal(start_square, end_square) if queen_checker == 1
      next_square = start_node.check_next_square_hv(start_square, end_square) if queen_checker == -1
      next_node = grab_node(next_square)

      return true unless next_node.nil?
      is_node_between?(start_square, next_square, queen_checker)
    end
  end

  def grab_node(square)
    @gb.board[square][1]
  end

  def grab_chessmen_position_name
    players = [self.player_white, self.player_black]
    attributes = []
    players.each do |player|
      player.each do |type, pieces|
        pieces.each do |piece|
          # name = piece.name
          position = piece.position
          node = piece
          attributes << [position, node]
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
end

game = Game.new
# p game.gb.board
game.populate_board

# node = game.grab_node('d2')
# p node.is_a?(Pawn)
# p game.gb.board

p game.player_turn
