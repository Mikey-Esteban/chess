require './lib/chessmen.rb'

class Pawn < Chessmen
  attr_accessor :position, :name, :color

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
