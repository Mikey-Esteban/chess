require './lib/chessmen.rb'

describe Chessmen do
  describe Pawn do
    describe '#move' do
      it 'moves a pawn up one spot if white, down one spot if black' do
        pawn = Pawn.new('a2', 'white')
        pawn.move
        expect(pawn.position).to eq('a3')
      end
    end
  end
end
