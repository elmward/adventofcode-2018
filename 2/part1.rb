def double_value(box_id)
  if box_id.chars.sort.chunk { |c| c }.any? { |_, chunk| chunk.length == 2 } 
    1
  else 
    0
  end
end

def triple_value(box_id)
  if box_id.chars.sort.chunk { |c| c }.any? { |_, chunk| chunk.length == 3 } 
    1
  else 
    0
  end
end

def count(box_id)
  double_value(box_id) + triple_value(box_id)
end

def checksum(values)
  values.map { |id| double_value(id) }.sum * values.map { |id| triple_value(id) }.sum
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  puts checksum(File.open(filename).readlines)
end

main if __FILE__ == $PROGRAM_NAME
