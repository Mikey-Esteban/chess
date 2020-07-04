require 'io/console'

require './lib/game.rb'
require './lib/save.rb'


print "Would you like to load a previous game? (y/n): "
asks_load = gets.chomp.downcase

if asks_load == 'y'
  game = Save.load_game
  if game
    puts "type 'q' to quit game"
    loop do
      print "'q' to quit: "
      char = STDIN.getch
      break if char == 'q'
      game.populate_board
      game.player_turn
    end
  else
    puts "Sorry we couldnt find that game :("
  end
else
  game = Game.new
  puts "type 'q' to quit game"
  loop do
    print "'q' to quit: "
    char = STDIN.getch
    break if char == 'q'
    game.populate_board
    game.player_turn
  end
end
print "Save game? (y/n): "
asks_save = gets.chomp.downcase
if asks_save == 'y'
  print "Enter name for save file: "
  name = gets.chomp.downcase
  p name
  save = Save.new(name, game)
  save.save_game
end
