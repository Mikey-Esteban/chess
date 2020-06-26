require './lib/chessmen.rb'

describe Chessmen do
  describe Pawn do
    describe '#move' do
      it 'moves a pawn up one spot if white' do
        pawn = Pawn.new('a2', 'white')
        pawn.move
        expect(pawn.position).to eq('a3')
      end

      it 'moves a pawn up down one spot if black' do
        pawn = Pawn.new('c7', 'black')
        pawn.move
        expect(pawn.position).to eq('c6')
      end
    end

    describe '#take' do
      it 'moves a pawn diagonal to eat a piece' do
        pawn = Pawn.new('b2', 'white')
        pawn.take('a3')
        expect(pawn.position).to eq('a3')
      end
    end
  end
end
