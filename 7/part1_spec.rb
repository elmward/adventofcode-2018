require 'rspec'
require './part1'

RSpec.describe(Step) do
  subject(:step) { Step.new("A") }

  it "has a list of children" do
    expect(step.children).to eq([])
  end

  it "allows you to add children" do
    b = Step.new("B")
    step.add_children(b)
    expect(step.children).to eq([b])
    expect(b.parents).to eq([step])
  end

  example "adding steps is idempotent" do
    b = Step.new("B")
    2.times do
      step.add_children(b)
    end

    expect(step.children).to eq([b])
  end

  it "allows you to add multiple steps at once" do
    b = Step.new("B")
    c = Step.new("C")
    step.add_children(b,c)
    expect(step.children).to eq([b,c])
  end

  it "implements comparability based on the name" do
    b = Step.new("B")
    a = Step.new("A")
    expect(step).to be < b
    expect(b).to be > step
    expect(a).to eq(step)
  end

  it "has a list of parents" do
    b = Step.new("B")
    b.add_parents(step)
    expect(b.parents).to eq([step])
    expect(step.children).to eq([b])
  end

  it "can be marked complete" do
    step.complete!
    expect(step.complete?).to eq(true)
  end

  describe "#available?" do
    let(:b) { Step.new("B") }
    let(:c) { Step.new("C") }

    it "is true if all parents have been completed" do
      step.add_parents(b, c)
      b.complete!
      c.complete!

      expect(step.available?).to eq(true)
    end

    it "is false of any parent has not been completed" do
      step.add_parents(b, c)
      b.complete!

      expect(step.available?).to eq(false)
    end
  end
end

RSpec.describe("Advent of Code 2018 Day 7 functions") do
  let(:step_a) { Step.new("A") }
  let(:step_b) { Step.new("B") }
  let(:step_c) { Step.new("C") }
  let(:step_d) { Step.new("D") }
  let(:step_e) { Step.new("E") }
  let(:step_f) { Step.new("F") }
  let(:steps) do
    step_c.add_children(step_a, step_f)
    step_a.add_children(step_b, step_d)
    step_b.add_children(step_e)
    step_d.add_children(step_e)
    step_f.add_children(step_e)
    [step_a, step_b, step_c, step_d, step_e, step_f] 
  end

  describe("#available") do
    it "finds the step or steps that don't depend on any other step" do
      expect(available(steps)).to eq([step_c])
    end
  end

  describe("#order_of_operations") do
    it "correctly orders steps based on dependency and alphabetical order" do
      expect(order_of_operations(steps)).to eq("CABDFE")
    end
  end

  describe("#parse") do
    it "adds a new step with a dependency" do
      steps = []
      parse("Step C must be finished before step A can begin.", steps)
      expect(steps).to eq([Step.new("C"), Step.new("A")])
      expect(steps[0].children).to eq([Step.new("A")])
    end
  end
end
