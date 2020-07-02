require "yaml"

class Save
  attr_reader :name, :game_object

  def initialize(name, game_object)
    @name = name
    @game_object = game_object
  end

  def to_s
    "In Save:\n    #{@name} #{@game_object}\n"
  end

  def save_game
    puts "save file: #{@name}"
    serialized_object = YAML::dump(self)
    puts serialized_object

    File.open("saves/#{@name}.yaml", "w") do |file|
      file.puts serialized_object
      file.puts ""
    end
  end

  def self.delete_file(f)
    File.open("saves/#{f}.yaml", 'r') do |f|
      File.delete(f)
    end
  end

  def self.check_for_file
    files = []
    Dir.foreach("saves") do |file|
      next if file == '.' || file == '..'
      puts "working on #{file}"

      files << file
    end
    files
  end

  def self.load_game
    save_files = []
    filenames = []

    Dir.foreach("saves") do |file|
      next if file == '.' || file == '..'
      puts "working on #{file}"

      $/="\n\n"     # used to properly read the YAML files
      File.open("saves/#{file}", "r").each do |object|
        puts "inside file"
        game = YAML::load(object)
        save_files << game
        filenames << game.name
      end
      $/="\n"
    end

    puts "Saved files:"
    filenames.each do |save|
      puts "            #{save}"
    end
    print "Which save file would you like to play?: "
    name = gets.chomp.downcase
    save_files.each do |file|
      if name == file.name
        game = file.game_object

        return game   #, file
      end
    end
  end

end
