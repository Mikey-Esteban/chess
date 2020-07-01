class Save
  attr_reader :name, :game_object

  def initialize(name, game_object, secret_word)
    @name = name
    @game_object = game_object
  end

  def to_s
    "In Save:\n    #{@name} #{@game_object}\n"
  end
end
