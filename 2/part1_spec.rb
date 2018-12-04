require 'rspec'
require './part1.rb'

RSpec.describe("Advent of Code 2018 Part 2") do
  describe "#double_value" do
    it "is 1 if one letter is repeated exactly twice" do
      expect(double_value("ajkeponawq")).to eq(1)
    end

    it "is 1 if several letters are repeated exactly twice" do
      expect(double_value("jkjkabab")).to eq(1)
    end

    it "is 0 if no letters are repeated" do
      expect(double_value("abcdefghijklmnopqrstuvwxyz")).to eq(0)
    end

    it "is 0 if one letter is repeated three or more times" do
      expect(double_value("bcadeafghajk")).to eq(0)
    end
  end

  describe "#triple_value" do
    it "is 1 if one letter appears exactly three times" do
      expect(triple_value("bnjklopithaaa")).to eq(1)
    end

    it "is 1 if several letters appear exactly three times" do
      expect(triple_value("abababjkjkjk")).to eq(1)
    end

    it "is 0 if one letter appears more than three times" do
      expect(triple_value("bnjaaklopaaith")).to eq(0)
    end

    it "is 0 if one letter appears twice" do
      expect(triple_value("bnaklopitha")).to eq(0)
    end
  end

  describe "#count" do
    it "is zero if there are no doubled or tripled characters" do
      expect(count("lwknfgur")).to eq(0)
    end

    it "is 1 if there are doubled characters" do
      expect(count("hkpoawera")).to eq(1)
    end

    it "is 1 if there are tripled characters" do
      expect(count("hkapoawera")).to eq(1)
    end

    it "is 2 if there are both doubled and tripled characters" do
      expect(count("whwhiopiopiop")).to eq(2)
    end
  end

  describe "#checksum" do
    it "handles the example input" do
      values = %w[
        abcdef 
        bababc 
        abbcde
        abcccd
        aabcdd
        abcdee
        ababab 
      ]
      expect(checksum(values)).to eq(12)
    end
  end
end
