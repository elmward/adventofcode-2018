require 'rspec'
require './part2'

RSpec.describe(Step) do
  subject { Step.new("A") }
  let(:z) { Step.new("Z") }

  it "has a duration based on the step letter" do
    expect(subject.duration).to eq(61)
    expect(z.duration).to eq(86)
  end

  it "accepts a base time to modify its durations" do
    expect(Step.new("A", 0).duration).to eq(1)
  end

  it "keeps track of time that it has been worked" do
    expect(subject.time_worked).to eq(0)
  end
end

RSpec.describe("Advent of Code 2018 Day 7 Part 2") do
  let(:step_a) { Step.new("A", 0) }
  let(:step_b) { Step.new("B", 0) }
  let(:step_c) { Step.new("C", 0) }
  let(:step_d) { Step.new("D", 0) }
  let(:step_e) { Step.new("E", 0) }
  let(:step_f) { Step.new("F", 0) }
  let(:steps) do
    step_c.add_children(step_a, step_f)
    step_a.add_children(step_b, step_d)
    step_b.add_children(step_e)
    step_d.add_children(step_e)
    step_f.add_children(step_e)
    [step_a, step_b, step_c, step_d, step_e, step_f] 
  end

  describe "#time_in_parallel" do
    it "follows the example" do
      expect(time_in_parallel(steps, 2)).to eq(15)
    end
  end
end
