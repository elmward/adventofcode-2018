class Step
  include Comparable
  attr_reader :name, :children, :parents

  def initialize(name)
    @name = name
    @children = Array.new
    @parents = Array.new
    @complete = false
  end

  def <=>(other)
    @name <=> other.name
  end

  def add_children(*steps)
    steps.each do |step|
      @children << step unless @children.include?(step)
      step.add_parents(self) unless step.parents.include?(self)
    end
  end

  def add_parents(*steps)
    steps.each do |step|
      @parents << step unless @parents.include?(step)
      step.add_children(self) unless step.children.include?(self)
    end
  end

  def complete!
    @complete = true
  end

  def complete?
    @complete
  end

  def available?
    parents.all? { |parent| parent.complete? }
  end

  def inspect
    "Step #{@name}"
  end
end

def available(steps)
  steps.select { |step| step.parents.empty? }
end

def order_of_operations(steps)
  available = available(steps).sort
  results = []

  "".tap do |operations|
    loop do
      break if available.empty?
      step = available.shift(1).first
      step.complete!
      results << step unless results.include?(step)

      newly_available = step.children.select do |child|
        child.parents.all? { |parent| parent.complete? }
      end

      available << newly_available
      available = available.flatten.sort
    end
  end

  results.reduce("") { |acc, result| acc << result.name }
end

def parse(input_string, steps)
  input_regex = /Step ([a-zA-Z]) must be finished before step ([a-zA-Z]) can begin\./
  matches = input_regex.match(input_string)
  first_name = matches[1]
  second_name = matches[2]
  # really looking like I should have just used a hash here
  first_step = steps.detect { |step| step.name == first_name } || Step.new(matches[1])
  second_step = steps.detect { |step| step.name == second_name } || Step.new(matches[2])
  first_step.add_children(second_step)
  steps << first_step unless steps.include?(first_step)
  steps << second_step unless steps.include?(second_step)
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  steps = []
  File.open(filename).readlines.each do |line|
    parse(line, steps)
  end

  puts order_of_operations(steps)
end

main if __FILE__ == $PROGRAM_NAME
