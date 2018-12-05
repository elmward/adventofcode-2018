require 'rspec'
require './part1'

RSpec.describe "Advent of Code 2018 part 5" do
  describe "#complement?" do
    it "considers opposite case characters to be complements" do
      expect(complement?("a", "A")).to eq(true)
    end

    it "considers same case characters not to be complements" do
      expect(complement?("a", "a")).to eq(false)
    end

    it "considers different characters not to be complements" do
      expect(complement?("a", "Z")).to eq(false)
    end
  end

  describe "#react" do
    it "destroys complementary pairs" do
      expect(react("aA")).to eq("")
    end

    it "leaves non-complementary pairs intact" do
      expect(react("aZ")).to eq("aZ")
    end
  end

  describe "#react_first" do
    it "reacts the first complementary pair" do
      expect(react_first("dabAcCaCBAcCcaDA")).to eq("dabAaCBAcCcaDA")
    end
  end

  describe "#react_polymer" do
    it "repeatedly reacts the first complementary pair" do
      expect(react_polymer("dabAcCaCBAcCcaDA")).to eq("dabCBAcaDA")
    end
  end

  describe "#biggest_problem" do
    it "returns the value removed and the shortest polymer" do
      expect(biggest_problem("dabAcCaCBAcCcaDA")).to eq(["c", "daDA"])
    end
  end
end
