def first_repeat(changes)
  current_freq = 0
  frequencies = {current_freq: 1}
  i = 0

  loop do
    current_freq += changes[i]
    break if frequencies[current_freq]
    frequencies[current_freq] = 1

    if i == changes.count - 1
      i = 0
    else
      i += 1
    end
  end

  current_freq
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  changes = File.open(filename).readlines.map(&:to_i)
  puts first_repeat(changes)
end

main if __FILE__ == $PROGRAM_NAME
