input = "..........
..###.##..
...####...
..######..
..######..
...####...
.........."

NEIGHBORS4 = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze
NEIGHBORS8 = [[0, 1], [0, -1], [1, 0], [-1, 0], [-1, -1], [1, 1], [-1, 1], [1, -1]].freeze

def part1(input, neighbors = NEIGHBORS4)
  level = Hash.new { 0 }
  digs = 0

  loop do
    dug = false

    0.upto(input.length - 1).each do |y|
      0.upto(input.first.length - 1).each do |x|
        next unless input[y][x] == "#"

        current_depth = level[[y, x]]

        can_dig = neighbors.map do |pair|
          dy, dx = pair
          [y + dy, x + dx]
        end.all? do |pair|
          level[pair] == current_depth || level[pair] == current_depth - 1
        end

        next unless can_dig

        level[[y, x]] -= 1
        dug = true
        digs += 1
      end
    end

    break unless dug
  end

  digs
end

input = File.read("./everybody_codes_e2024_q03_p1.txt")
input = input.split("\n").map(&:chars)

puts "Part 1:", part1(input)

input = File.read("./everybody_codes_e2024_q03_p2.txt")
input = input.split("\n").map(&:chars)

puts "Part 2:", part1(input)

input = File.read("./everybody_codes_e2024_q03_p3.txt")
input = input.split("\n").map(&:chars)

puts "Part 3:", part1(input, NEIGHBORS8)
