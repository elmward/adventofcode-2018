def distance(coord_a, coord_b)
  (coord_a[0] - coord_b[0]).abs + (coord_a[1] - coord_b[1]).abs
end

def leftmost(coords)
  coords.min_by { |coordinate| coordinate[0] }[0]
end

def rightmost(coords)
  coords.max_by { |coordinate| coordinate[0] }[0]
end

def bottom(coords)
  coords.min_by { |coordinate| coordinate[1] }[1]
end

def top(coords)
  coords.max_by { |coordinate| coordinate[1] }[1]
end

def infinites(coordinates)
  leftmost = leftmost(coordinates)
  rightmost = rightmost(coordinates)
  bottom = bottom(coordinates)
  top = top(coordinates)

  coordinates.each.with_index.select do |coordinate, i|
    [leftmost(coordinates), rightmost(coordinates)].include?(coordinate[0]) ||
      [top(coordinates), bottom(coordinates)].include?(coordinate[1])
  end.map { |coord_and_index| coord_and_index[1] }
end

def largest_area(coordinates)
  leftmost = leftmost(coordinates)
  rightmost = rightmost(coordinates)
  bottom = bottom(coordinates)
  top = top(coordinates)

  infinites = infinites(coordinates)
  areas = Array.new(coordinates.length, 0)

  (bottom..top).map do |y|
    (leftmost..rightmost).map do |x|
      distances = coordinates.map { |coord| distance(coord, [x,y]) }
      # if distances.sort.chunk { |x| x }.to_a[0][1].count > 1
        # if we're closest to two or more coords
        # puts "skipping #{[x,y]}"
      if distances.sort[0] == distances.sort[1]
        next
      end

      closest_coordinate = coordinates.each.with_index.min_by do |coordinate, i|
        distance(coordinate, [x,y])
      end[1]

      # puts "#{[x,y]} is closest to #{coordinates[closest_coordinate]}"
      # print "#{closest_coordinate}"
      areas[closest_coordinate] += 1
    end
  end

  # since we've pinned the entire coordinate system to the outermost coordinates,
  # it's extremely unlikely one of the infinites is the largest. The below two lines
  # will eliminate them just in case.
  # areas.each.with_index.map { |area, i| puts "#{i}: #{coordinates[i]}, #{area}" }
  areas.each.with_index.map { |area, i| areas[i] = 0 if infinites.include?(i) }
  areas.reject { |area| area == 0 }.max
  # FIXME: somehow my max area in here is way too high and the second-highest area is the correct one. :|
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

  puts largest_area(coords)
end

main if __FILE__ == $PROGRAM_NAME
