require 'rspec'
require './part2.rb'

RSpec.describe("Advent of Code 2018 Part 2") do
  describe "#common_chars" do
    it "returns empty string if no characters in common" do
      expect(common_chars("abcd", "dcba")).to eq("")
    end

    it "returns the full string if they're identical" do
      expect(common_chars("abcdef", "abcdef")).to eq("abcdef")
    end

    it "returns the correct substrings if there's an overlap" do
      expect(common_chars("abcdef", "abczxf")).to eq("abcf")
    end

    it "can deal with multiple different characters" do
      expect(common_chars("abXdeY", "abQdeZ")).to eq("abde")
    end
  end

  describe "#compare_multiple" do
    it "returns empty string if there are no common characters at the same positions" do
      expect(compare_multiple("abcdef", ["ghjkl", "zxpoij", "qwerty"])).to eq("")
    end 

    it "returns the common string that differs by 1 character" do
      expect(compare_multiple("abcdef", ["ghjkl", "zxpoij", "qwerty", "abZdef"])).to eq("abdef")
    end

    it "returns empty string if there are some common characers but no off-by-one" do
      expect(compare_multiple("abcdef", ["ghjkl", "zxpoij", "qwerty", "abZXef"])).to eq("")
    end
  end

  describe "#find_it" do
    it "returns the common string that differs by 1 character" do
      expect(find_it(["abcdef", "ghjkl", "zxpoij", "qwerty", "abZdef"])).to eq("abdef")
    end

    it "returns nil if there is no satisfactory id" do
      expect(find_it(["abcdef", "ghjkl", "zxpoij", "qwerty"])).to be_nil
    end
  end
end
