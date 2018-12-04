require './part2.rb'

RSpec.describe('Advent of Code Part 2') do
  let(:values) { [0] }

  describe('#first_repeat') do
    it 'starts at frequency zero' do
      expect(first_repeat(values)).to eq(0)
    end

    context 'first repeat is on first loop' do
      let(:values) { [-1, 2, -2, 4, 5] }
      it 'finds the first repeat' do
        expect(first_repeat(values)).to eq(-1)
      end
    end

    context 'first repeat is on second loop' do
      let(:values) { [2, -1] }
      it 'finds the first repeat' do
        expect(first_repeat(values)).to eq(2)
      end
    end
  end
end
