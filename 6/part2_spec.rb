require 'rspec'
require './part2'

RSpec.describe("Advent of Code 2018 Day 6 Part 2") do
  let(:coords) do
    [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]]
  end

  describe ("#region_closer_than") do
    it "calculates the area less than specified distance from all coordinates" do
      expect(region_closer_than(32, coords)).to eq(16)
    end
  end
end
