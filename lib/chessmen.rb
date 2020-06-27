class Chessmen
  # attr_accessor :white, :black

  def initialize
    @white = {}
    @black = {}
    # @pawn = Pawn.new()
  end

  def white
    @white.each do |k,v|
      p k
      v.each do |piece|
        print piece.position + ", "
      end
      puts
    end
  end

  def black
    @black.each do |k,v|
      p k
      v.each do |piece|
        print piece.position + ", "
      end
      puts
    end
  end

  def populate_white_chessmen
    col = ['a','b','c','d','e','f','g','h']
    row = ['1','2','3','4','5','6','7','8']
    chessmen = {
      :pawns => [],
      :rooks => [],
      :knights => [],
      :bishops => [],
      :queens => [],
      :kings => []
    }

    8.times do |i|
      position = col[i] + '2'
      pawn = Pawn.new(position, 'white')
      chessmen[:pawns] << pawn
      position = col[i] + '1'
      if col[i] == 'a' || col[i] == 'h'
        rook = Rook.new(position, 'white')
        chessmen[:rooks] << rook
      elsif col[i] == 'b' || col[i] ==  'g'
        knight = Knight.new(position, 'white')
        chessmen[:knights] << knight
      elsif col[i] == 'c' || col[i] ==  'f'
        bishop = Bishop.new(position, 'white')
        chessmen[:bishops] << bishop
      elsif col[i] == 'd'
        queen = Queen.new(position, 'white')
        chessmen[:queens] << queen
      elsif col[i] == 'e'
        king = King.new(position, 'white')
        chessmen[:kings] << king
      end
    end
    @white = chessmen
  end

  def populate_black_chessmen
  end
end

class Pawn < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'pawn'
    @position = position
    @color = color
  end

  def move
    if move_valid?
      @position[1] = (@position[1].to_i + 1).to_s if @color == 'white'
      @position[1] = (@position[1].to_i - 1).to_s if @color == 'black'
    else
      puts "Sorry cant move pawn there"
      nil
    end
  end

  def take(to_position)
    @position = to_position
  end
end

class Rook < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'rook'
    @position = position
    @color = color
  end
end

class Knight < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'knight'
    @position = position
    @color = color
  end
end

class Bishop < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'bishop'
    @position = position
    @color = color
  end
end

class Queen < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'queen'
    @position = position
    @color = color
  end
end

class King < Chessmen
  attr_accessor :position, :name

  def initialize(position, color)
    @name = 'king'
    @position = position
    @color = color
  end
end


chessmen = Chessmen.new
chessmen.populate_white_chessmen
chessmen.white
