require 'rspec'
require './part1'

RSpec.describe("Advent of Code 2018 Day 6 Part 1") do
  let(:coords) do
    [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]]
  end

  describe('#distance') do
    it 'calculates the manhattan distance' do
      expect(distance([-3, 3], [6, -2])).to eq(14)
    end
  end

  describe('#leftmost') do
    it "returns the lowest x coordinate in the set" do
      expect(leftmost(coords)).to eq(1)
    end
  end

  describe('#rightmost') do
    it "returns the highest x coordinate in the set" do
      expect(rightmost(coords)).to eq(8)
    end
  end

  describe('#bottom') do
    it "returns the lowest y coordinate in the set" do
      expect(bottom(coords)).to eq(1)
    end
  end

  describe('#top') do
    it "returns the highest y coordinate in the set" do
      expect(top(coords)).to eq(9)
    end
  end

  describe('#infinites') do
    it "returns the indexes of coordinates that are at the edges" do
      expect(infinites(coords)).to match_array([0, 1, 2, 5])
    end

    context "with two coords on the same edge" do
      let(:coords) { [[1, 1], [1,3], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]] }

      it "can return more than four infinites" do
        expect(infinites(coords)).to match_array([0, 1, 2, 3, 6])
      end
    end
  end

  describe('#largest_area') do
    it "returns the area of the coordinate that has the most locations closest to it" do
      expect(largest_area(coords)).to eq(17)
    end
  end
end
