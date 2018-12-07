require './part1'

def region_closer_than(max_distance, coordinates)
  leftmost = leftmost(coordinates)
  rightmost = rightmost(coordinates)
  bottom = bottom(coordinates)
  top = top(coordinates)

  area = 0

  (bottom..top).map do |y|
    (leftmost..rightmost).map do |x|
      if coordinates.map { |coord| distance(coord, [x,y])}.sum < max_distance
        area += 1
      end
    end
  end
  area
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  coords = File.open(filename).readlines.map do |line|
    line.split(", ").map(&:to_i)
  end

  puts region_closer_than(10000, coords)
end

main if __FILE__ == $PROGRAM_NAME
