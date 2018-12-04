require 'rspec'
require './part1.rb'

RSpec.describe(Panel) do
  let(:input) { '#123 @ 3,2: 5x4' }
  it 'parses an input string' do
    expect(Panel.new(input).id).to eq(123)
  end
end

RSpec.describe(Sheet) do
  subject { Sheet.new(20, 20) }
  it 'starts out with a totally empty grid' do
    expect(subject.grid.length).to eq(20)
    expect(subject.grid.all? { |row| row.all? { |x| x == 0 } }).to eq(true)
  end

  it 'allows you to add a panel' do
    subject.add(Panel.new('#123 @ 3,2: 5x4'))
    expect(subject.overlap).to eq(0)
  end

  it 'calculates overlap' do
    subject.add(Panel.new('#123 @ 3,2: 5x4'))
    subject.add(Panel.new('#124 @ 3,2: 4x3'))
    expect(subject.overlap).to eq(12)
  end

  it 'calculates overlap with different origins' do
    subject.add(Panel.new('#123 @ 3,2: 5x4'))
    subject.add(Panel.new('#124 @ 4,3: 4x3'))
    expect(subject.overlap).to eq(12)
  end

  it 'calculates overlap with non-completely overlapping rectangles' do
    subject.add(Panel.new('#123 @ 0,0: 5x4'))
    subject.add(Panel.new('#124 @ 3,3: 6x6'))
    expect(subject.overlap).to eq(2)
  end

  it "doesn't find overlap on non-overlapping rectangles" do
    subject.add(Panel.new('#123 @ 0,0: 2x2'))
    subject.add(Panel.new('#124 @ 3,3: 4x4'))
    expect(subject.overlap).to eq(0)
  end
end
