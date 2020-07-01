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

  def print_game_board
    @gb.board.each do |spot, value|
      result = ''
      result += spot
      result += ' => '
      result += value.join(',')
      p result
    end
  end

  def populate_board
    chessmen_attributes = grab_chessmen_position_name
    @gb.board.each do |position, value_pair|     # value pair = [board piece, occupancy]
      chessmen_attributes.each do |piece_attr|
        if piece_attr.include?(position)
          # p position
          value_pair[1] = piece_attr[1]   # occupancy = node
          value_pair[0] = place_chessmen(value_pair[0].length, piece_attr[1].name, value_pair[0])
        end
      end
    end
    @gb.print_board
    @gb.board
  end

  def player_turn
    cols = 'abcdefgh'
    rows = '12345678'

    while true
      puts "Play move from start square to end square eg. 'a5 to a6'"
      print "What is your move? "
      player_decision = gets.chomp
      start, fin = player_decision.split(' to ')
      break if cols.include?(start[0]) && rows.include?(start[1]) && cols.include?(fin[0]) && rows.include?(fin[1])
      puts "Sorry, please enter a valid input! :)"
    end

    flag = can_player_move?(start, fin)
    if flag == true
      player_move(start, fin)
    else
      p flag
    end
    populate_board
  end

  private

  def player_move(start_square, end_square)
    start_node = grab_node(start_square)
    end_node = grab_node(end_square)
    delete_chessman(end_node) if end_node

    update_start_square_block =  @gb.empty_board[start_square][0]
    update_start_square_node = @gb.empty_board[start_square][1]
    update_end_square_block = @gb.empty_board[end_square][0]
    update_end_square_node = start_node

    @gb.board[end_square][1] = update_end_square_node       # changing the node value of end_square occupancy to start_square occupancy
    @gb.board[end_square][1].position = end_square          # update the node position from start_square to end_square
    @gb.board[end_square][0] = update_end_square_block
    @gb.board[start_square][0] = update_start_square_block  # update the start_square block to equal its empty_board version block
    @gb.board[start_square][1] = update_start_square_node   # update the start_square node to equal its empty_board version node

    @gb.board
  end

  def can_player_move?(start_square, end_square)
    start_node = grab_node(start_square)
    end_node = grab_node(end_square)

    return "Your own piece is in the way!" if start_node && end_node && start_node.color == end_node.color

    if start_node.is_a?(Pawn) && !end_node.nil?
      is_valid = start_node.pawn_take_valid?(start_square, end_square)
      return is_valid if is_valid != true
      # p "dont need to check node between for #{start_node.name}"
    elsif start_node.is_a?(Queen)
      is_valid = start_node.move_valid?(start_square, end_square)
      return "Queen made a bad move!" if is_valid == 0
      if is_valid == 1
        result = is_node_between?(start_square, end_square, 1)
      elsif is_valid == -1
        result = is_node_between?(start_square, end_square, -1)
      end
      # p "is node between?: #{result}"
      return "#{start_node.name} cant make that move!" if result
    elsif start_node.is_a?(King) || start_node.is_a?(Knight) || start_node.is_a?(Pawn)
      is_valid = start_node.move_valid?(start_square, end_square)
      return is_valid if is_valid != true
      # p "dont need to check node between for #{start_node.name}"
    else    # for Rook, Bishop
      is_valid = start_node.move_valid?(start_square, end_square)
      return is_valid if is_valid != true
      result = is_node_between?(start_square, end_square)
      # p "is node between?: #{result}"
      return "#{start_node.name} cant make that move!" if result
    end

    p "Good move! #{start_node.name}:#{start_square} moves to #{end_square}"
    return true

  end

  def is_node_between?(start_square, end_square, queen_checker = nil)
    start_node = @gb.board[start_square][1]

    if start_node.is_a?(Rook) || start_node.is_a?(Bishop)
      next_square = start_node.check_next_square(start_square, end_square)
      next_node = grab_node(next_square)
      return false if next_square == start_square
      return true unless next_node.nil?
      is_node_between?(start_square, next_square)
    elsif start_node.is_a?(Queen)
      next_square = start_node.check_next_square_diagonal(start_square, end_square) if queen_checker == 1
      next_square = start_node.check_next_square_hv(start_square, end_square) if queen_checker == -1
      next_node = grab_node(next_square)
      return false if next_square == start_square
      return true unless next_node.nil?
      is_node_between?(start_square, next_square, queen_checker)
    end
  end

  def delete_chessman(node)
    # # MAKE INTO A NEW FUNCTION
    player = @player_black if node.color == 'black'
    player = @player_white if node.color == 'white'
    player.each do |k,v|
      if v.include?(node)
        # p "found a node in array!!"
        v.each_with_index do |chessman, i|
          if chessman == node
            # p "found a match!"
            v.delete_at(i)
          end
        end
      end
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
