def common_chars(first_id, second_id)
  "".tap do |common| 
    first_id.chars.each.with_index do |c, i|
      if second_id[i] == c
        common << c
      end
    end
  end
end

def compare_multiple(box_id, ids)
  "".tap do |common|
    ids.each do |id|
      common = common_chars(box_id, id)
      return common if common.length == box_id.length - 1 
    end
  end
end

def find_it(box_ids)
  box_ids.each.with_index do |box_id, i|
    the_id = compare_multiple(box_id, box_ids[i+1..box_ids.length-1])
    return the_id unless the_id.empty?
  end
  nil
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  puts find_it(File.open(filename).readlines)
end

main if __FILE__ == $PROGRAM_NAME
