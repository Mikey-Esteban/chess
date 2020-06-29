require './lib/chessmen/pawn.rb'
require './lib/chessmen/rook.rb'
require './lib/chessmen/bishop.rb'

class Chessmen
  attr_accessor :white, :black

  def initialize
    @white = {}
    @black = {}
    populate_chessmen('white')
    populate_chessmen('black')
  end

  def print_white
    @white.each do |k,v|
      p k
      v.each do |piece|
        print piece.position + ", "
      end
      puts
    end
  end

  def print_black
    @black.each do |k,v|
      p k
      v.each do |piece|
        print piece.position + ", "
      end
      puts
    end
  end

  private

  def populate_chessmen(color)
    col = ['a','b','c','d','e','f','g','h']
    chessmen = {
      :pawns => [],
      :rooks => [],
      :knights => [],
      :bishops => [],
      :queens => [],
      :kings => []
    }

    8.times do |i|
      position = col[i] + '2' if color == 'white'
      position = col[i] + '7' if color == 'black'
      pawn = Pawn.new(position, color)
      chessmen[:pawns] << pawn
      position = col[i] + '1' if color == 'white'
      position = col[i] + '8' if color == 'black'
      if col[i] == 'a' || col[i] == 'h'
        rook = Rook.new(position, color)
        chessmen[:rooks] << rook
      elsif col[i] == 'b' || col[i] ==  'g'
        knight = Knight.new(position, color)
        chessmen[:knights] << knight
      elsif col[i] == 'c' || col[i] ==  'f'
        bishop = Bishop.new(position, color)
        chessmen[:bishops] << bishop
      elsif col[i] == 'd'
        queen = Queen.new(position, color)
        chessmen[:queens] << queen
      elsif col[i] == 'e'
        king = King.new(position, color)
        chessmen[:kings] << king
      end
    end
    @white = chessmen if color == 'white'
    @black = chessmen if color == 'black'
  end

end

# class Pawn < Chessmen
#   attr_accessor :position, :name, :color
#
#   def initialize(position, color)
#     @name = 'pawn'
#     @position = position
#     @color = color
#   end
#
#   def move_valid?(start_square, end_square)
#     p "In Pawn.move_valid Instance method!"
#     diff = end_square[1].to_i - start_square[1].to_i
#
#     return false if start_square[0] != end_square[0]
#     return diff == 1 if self.color == 'white'
#     return diff == -1 if self.color == 'black'
#   end
#
#   def pawn_take_valid?(start_square, end_square)
#     p "In Pawn.pawn_take_valid Instance method!"
#     column_diff = end_square[0].ord - start_square[0].ord
#     row_diff = end_square[1].to_i - start_square[1].to_i
#
#     return false unless column_diff == 1 || column_diff == -1
#     return row_diff == 1 if self.color == 'white'
#     return row_diff == -1 if self.color == 'black'
#   end
# end

# class Rook < Chessmen
#   attr_accessor :position, :name, :color
#
#   def initialize(position, color)
#     @name = 'rook'
#     @position = position
#     @color = color
#   end
# end

class Knight < Chessmen
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'knight'
    @position = position
    @color = color
  end
end

# class Bishop < Chessmen
#   attr_accessor :position, :name, :color
#
#   def initialize(position, color)
#     @name = 'bishop'
#     @position = position
#     @color = color
#   end
# end

class Queen < Chessmen
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'queen'
    @position = position
    @color = color
  end
end

class King < Chessmen
  attr_accessor :position, :name, :color

  def initialize(position, color)
    @name = 'king'
    @position = position
    @color = color
  end
end
