def complement?(a, b)
  a.swapcase == b
end

def react(pair)
  complement?(pair[0], pair[1]) ? "" : pair
end

def react_first(polymer)
  polymer.chars.each.with_index do |unit, i|
    if i < polymer.length - 1 && unit.swapcase == polymer[i+1]
      polymer[i] = polymer[i+1] = "0"
      break
    end
  end
  polymer.chars.reject { |c| c == "0" }.join
end

def react_polymer(polymer)
  # FIXME: on both of the real problem sets, this produced a string that was one character too long.
  i = 0
  loop do
    old_polymer = polymer
    polymer = react_first(polymer)
    i+=1
    if i % 25 == 0
      puts "#{i}th reaction cycle, #{polymer.length} units remain"
    end
    break if polymer == old_polymer
  end
  polymer
end

def biggest_problem(polymer)
  solutions = []
  ('a'..'z').each do |letter|
    puts "eliminating #{letter} and reacting"
    simplified_polymer = polymer.delete(letter).delete(letter.upcase)
    reacted_polymer = react_polymer(simplified_polymer)
    solutions << [letter, reacted_polymer]
  end

  solutions.min_by { |solution| solution[1].length }
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  polymer = File.open(filename).read
  problem = biggest_problem(polymer)
  puts problem
  puts problem[1].length
end

main if __FILE__ == $PROGRAM_NAME
