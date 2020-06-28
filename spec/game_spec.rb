require './lib/game.rb'

describe Game do
  describe '#populate_board' do
    it "returns an 8x8 hash ['0-8' rows, 'a-h' cols] of a chess board with pieces in starting positions" do
      game = Game.new
      expect(game.populate_board).to eq(
        {
          'a8'=>[" r ", "rook"], 'b8'=>["|#kn", "knight"], 'c8'=>["| b ", "bishop"], 'd8'=>["|#Q#", "queen"], 'e8'=>["| K ", "king"], 'f8'=>["|#b#", "bishop"], 'g8'=>["| kn", "knight"], 'h8'=>["|#r#", "rook"],
          'a7'=>["#p#", "pawn"], 'b7'=>["| p ", "pawn"], 'c7'=>["|#p#", "pawn"], 'd7'=>["| p ", "pawn"], 'e7'=>["|#p#", "pawn"], 'f7'=>["| p ", "pawn"], 'g7'=>["|#p#", "pawn"], 'h7'=>["| p ", "pawn"],
          'a6'=>["   ", nil], 'b6'=>["|###", nil], 'c6'=>["|   ", nil], 'd6'=>["|###", nil], 'e6'=>["|   ", nil], 'f6'=>["|###", nil], 'g6'=>["|   ", nil], 'h6'=>["|###", nil],
          'a5'=>["###", nil], 'b5'=>["|   ", nil], 'c5'=>["|###", nil], 'd5'=>["|   ", nil], 'e5'=>["|###", nil], 'f5'=>["|   ", nil], 'g5'=>["|###", nil], 'h5'=>["|   ", nil],
          'a4'=>["   ", nil], 'b4'=>["|###", nil], 'c4'=>["|   ", nil], 'd4'=>["|###", nil], 'e4'=>["|   ", nil], 'f4'=>["|###", nil], 'g4'=>["|   ", nil], 'h4'=>["|###", nil],
          'a3'=>["###", nil], 'b3'=>["|   ", nil], 'c3'=>["|###", nil], 'd3'=>["|   ", nil], 'e3'=>["|###", nil], 'f3'=>["|   ", nil], 'g3'=>["|###", nil], 'h3'=>["|   ", nil],
          'a2'=>[" p ", "pawn"], 'b2'=>["|#p#", "pawn"], 'c2'=>["| p ", "pawn"], 'd2'=>["|#p#", "pawn"], 'e2'=>["| p ", "pawn"], 'f2'=>["|#p#", "pawn"], 'g2'=>["| p ", "pawn"], 'h2'=>["|#p#", "pawn"],
          'a1'=>["#r#", "rook"], 'b1'=>["| kn", "knight"], 'c1'=>["|#b#", "bishop"], 'd1'=>["| Q ", "queen"], 'e1'=>["|#K#", "king"], 'f1'=>["| b ", "bishop"], 'g1'=>["|#kn", "knight"], 'h1'=>["| r ", "rook"]
        }
      )
    end
  end
end
