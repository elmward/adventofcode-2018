class Panel
  INPUT_REGEX = /\#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)/

  attr_accessor :overlaps
  attr_reader :id, :origin_x, :origin_y, :width, :height

  def initialize(input)
    match_data = INPUT_REGEX.match(input)
    @id = match_data[1].to_i
    @origin_x = match_data[2].to_i
    # Note that in a normal plane this would be -y, but we're measuring from the top
    @origin_y = match_data[3].to_i
    @width = match_data[4].to_i
    @height = match_data[5].to_i
    @overlaps = false
  end
end

class Sheet
  attr_reader :grid

  def initialize(x, y)
    # three-d array, final dimension is an array of Panels
    @grid = Array.new(y) { Array.new(x) { Array.new } }
  end

  def add(panel)
    grid[panel.origin_y..panel.origin_y + panel.height - 1].each.with_index(panel.origin_y) do |row, y|
      row[panel.origin_x..panel.origin_x + panel.width - 1].each.with_index(panel.origin_x) do |val, x|
        grid[y][x] << panel
        if grid[y][x].count > 1
          grid[y][x].each do |panel|
            panel.overlaps = true
          end
        end
      end
    end
  end

  def overlap
    overlap = 0
    grid.each do |row|
      row.each do |panels|
        overlap += 1 if panels.count > 1
      end
    end
    overlap
  end
end

def main
  if ARGV.count != 1
    puts "Run with exactly one argument, a filename of input values"
    exit
  end

  filename = ARGV[0]
  sheet = Sheet.new(1000, 1000)
  panels = []
  File.open(filename).readlines.each do |line|
    panel = Panel.new(line)
    sheet.add(panel)
    panels << panel
  end

  puts sheet.overlap
  puts panels.detect { |panel| !panel.overlaps }.id
end

main if __FILE__ == $PROGRAM_NAME
