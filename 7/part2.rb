require './part1'

class Step
  attr_accessor :time_worked

  def initialize(name, base_time=60)
    @name = name
    @children = Array.new
    @parents = Array.new
    @base_time = base_time
    @time_worked = 0
  end

  def duration
    @base_time + @name.bytes[0] - 64
  end

  def complete?
    @time_worked == duration
  end
end

def time_in_parallel(steps, workers)
  available = available(steps).sort
  steps_in_progress = available.shift(workers)
  t = 0

  loop do
    break if steps.all? { |step| step.complete? }
    step = steps_in_progress.sort_by { |step| step.duration - step.time_worked }.first
    time_passed = step.duration - step.time_worked
    t += time_passed
    steps_in_progress.map { |step| step.time_worked += time_passed }

    completed_steps = steps_in_progress.select { |step| step.complete? }
    completed_steps.each do |step|
      newly_available = step.children.select do |child|
        child.parents.all? { |parent| parent.complete? }
      end

      available << newly_available
      available = available.flatten.sort
    end

    steps_in_progress = steps_in_progress.reject { |step| step.complete? }
    steps_in_progress << available.shift(workers - steps_in_progress.length)
    steps_in_progress = steps_in_progress.flatten
  end
  t
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

  puts time_in_parallel(steps, 5)
end

main if __FILE__ == $PROGRAM_NAME
