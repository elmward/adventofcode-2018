require './part1.rb'
require 'rspec'

RSpec.describe("Advent of Code 2018 Day 4") do
  let(:ordered_input) do
    [
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-05 00:55] wakes up",
    ]
  end

  let(:input) { ordered_input.shuffle.join("\n") }

  describe('#sort') do
    it "sorts based on timestamps" do
      expect(sort(input.split("\n"))).to eq(ordered_input)
    end
  end

  describe('#naps') do
    let(:dataset) do
      {
        "10" => [(05...25), (30...55), (24...29)],
        "99" => [(40...50), (36...46), (45...55)],
      }
    end

    it "identifies the Guards by number" do
      expect(naps(ordered_input).keys).to match_array(["10", "99"])
    end

    it "provides a list of ranges of minutes when the guards were asleep" do
      expect(naps(ordered_input)).to eq(dataset)
    end
  end
  
  context "solvers" do
    let(:nap_hash) { naps(ordered_input) }

    describe('#laziest_guard') do

      it "picks the guard with the longest total time asleep" do
        expect(laziest_guard(nap_hash)).to eq("10")
      end
    end

    describe('#sleepiest_minute') do
      it "picks the minute the guard is most likely to be asleep" do
        expect(sleepiest_minute("10", nap_hash)).to eq([24, 2])
        expect(sleepiest_minute("99", nap_hash)).to eq([45, 3])
      end
    end

    describe('#sleepiest_guard_on_single_minute') do
      it "picks the guard and minute with the most naps" do
        expect(sleepiest_guard_on_single_minute(nap_hash)).to eq[99, 45, 3])
      end
    end
  end
end
