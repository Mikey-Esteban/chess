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
    loop do
      begin
        result = ask_for_move
        return result if result == 'q'
        start, fin = result
        flag = can_player_move?(start, fin)
        if flag == true
          player_move(start, fin)
          break
        end
        p flag
        puts ""
      rescue NoMethodError
        puts "Sorry, invalid move. Trying again.."
        puts ""
      end
    end

    players_colors = ['white', 'black']
    players_colors.each do |pc|
      king = grab_king(pc)
      boolean, node = is_check?(king)
      if boolean == true
        puts "#{pc.capitalize} is check by #{node.color.capitalize} #{node.name.capitalize}"
        possible_moves = moves_to_stop_check(node, node.position, king)
        p possible_moves
      end
    end

    populate_board
  end

  private

  def ask_for_move
    loop do
      cols = 'abcdefgh'
      rows = '12345678'
      puts "Play move from start square to end square eg. 'a5 to a6'"
      print "What is your move? (enter 'q' to quit): "

      player_decision = gets.chomp
      return player_decision if player_decision == 'q'
      if player_decision.length > 1
        start, fin = player_decision.split(' to ')
        if start.length == 2 && fin.length == 2
          return start, fin if cols.include?(start[0]) && rows.include?(start[1]) && cols.include?(fin[0]) && rows.include?(fin[1])
        end
      end
      puts "Sorry, please enter a valid input! :)"
      puts ""
    end
  end

  def moves_to_stop_check(attack_node, attack_square, king_node)
    puts "in moves_to_stop_check function"
    possible_moves = []
    defending_player = @player_white if attack_node.color == 'black'
    defending_player = @player_black if attack_node.color == 'white'
    # Can we block path to king_square
    queen_checker = attack_node.move_valid?(attack_square, king_node.position) if attack_node.is_a?(Queen)
    queen_checker = nil if !attack_node.is_a?(Queen)
    path_to_block = squares_between(attack_square, king_node.position, queen_checker)
    # p path_to_block

    # Can we take over attack square or put piece in path
    defending_player.each do |type, list_of_pieces|
      list_of_pieces.each do |piece|
        can_take = can_player_move?(piece.position, attack_square)
        if can_take == true
          move_to_make = [piece.position, attack_square]
          possible_moves << move_to_make
        end
        unless path_to_block.nil?
          unless piece.name == 'king'
            path_to_block.each do |square|
              can_block = can_player_move?(piece.position, square)
              if can_block == true
                move_to_make = [piece.position, square]
                possible_moves << move_to_make
              end
            end
          end
        end
      end
    end
    # Can we move king out of king square to non check square
    directions = ['left', 'right', 'up', 'down', 'up_left', 'up_right',
                  'down_left', 'down_right']

    directions.each do |direction|
      possible_square = king_node.check_next_square(king_node.position, direction)
      if possible_square != true
        possible_node = grab_node(possible_square)
        if possible_node.nil?
          # puts "checking to see if king can move here..."
          # puts "possible square #{possible_square}"
          temp_king = King.new(possible_square, king_node.color)
          boolean, node = is_check?(temp_king)
          if boolean == false
            puts "King can move to position #{possible_square}"
            move_to_make = [king_node.position, possible_square]
            possible_moves << move_to_make
          end
        end
      end
    end

    # return a list of these possible mvoes
    # if list is nil, checkmate??
    return possible_moves
  end

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

  def is_check?(king_node)
    # puts "IN METHOD IS_CHECK?"
    start_square = king_node.position
    # p start_square
    directions = ['left', 'right', 'up', 'down', 'up_left', 'up_right',
                  'down_left', 'down_right']

    directions.each do |direction|
      next_square = king_node.check_next_square(start_square, direction)
      # p next_square
      # next_square will equal true if check_next_square returns at end of board
      until next_square == true
        next_node = grab_node(next_square)
        if !next_node.nil?
          if next_node.color != king_node.color
            is_valid = next_node.move_valid?(next_square, start_square)
            # puts "This king is checked!"
            return [true, next_node] if is_valid == true  || is_valid != 0   # This is a check, queen is_valid returns 0, -1, 1
          elsif next_node.color == king_node.color
            next_square = true
          end
        elsif next_node.nil? # && not at end of the board
          next_square = king_node.check_next_square(next_square, direction)
        end
      end
    end

    return [false, nil]
  end

  def is_node_between?(start_square, end_square = nil, queen_checker = nil)
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

  def squares_between(start_square, end_square = nil, queen_checker = nil)
    start_node = @gb.board[start_square][1]
    list_of_squares = []

    if start_node.is_a?(Rook) || start_node.is_a?(Bishop)
      loop do
        next_square = start_node.check_next_square(start_square, end_square)
        # p next_square
        break if next_square == start_square
        list_of_squares << next_square
        end_square = next_square
      end
    elsif start_node.is_a?(Queen)
      loop do
        next_square = start_node.check_next_square_diagonal(start_square, end_square) if queen_checker == 1
        next_square = start_node.check_next_square_hv(start_square, end_square) if queen_checker == -1
        # p next_square
        break if next_square == start_square
        list_of_squares << next_square
        end_square = next_square
      end
    end

    return list_of_squares
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

  def grab_king(color)
    # puts "In grab_king method"
    return @player_white[:kings][0] if color == 'white'
    return @player_black[:kings][0] if color == 'black'
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
