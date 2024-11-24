require 'pqueue'

input = "#######
#6769##
S50505E
#97434#
#######"

input = File.read("./everybody_codes_e2024_q13_p1.txt")

NEIGHBORS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

def shortest(input, start = "S", goal = "E")
  input = input.split("\n").map(&:chars)

  map = (0...input.length).to_a.product((0...input.first.length).to_a).map do |pair|
    [pair, input[pair.first][pair.last]]
  end.to_h

  start = map.key(start)

  queue = [[start, 0, 0]]
  queue = PQueue.new([[start, 0, 0]]) do |a, b|
    a[1] < b[1]
  end
  visited = Hash.new { 1_000_000 }
  best = 1_000_000

  until queue.empty?
    item = queue.pop
    coord, distance, level = item
    y, x = coord
    letter = map[coord]

    best = [best, distance].min if letter == goal
    next if visited[coord] < distance
    next if distance > best

    visited[coord] = [distance, visited[coord]].min

    neighbors = NEIGHBORS.map do |pair|
      dy, dx = pair
      coord = [y - dy, x - dx]
      [coord, map[[y - dy, x - dx]]]
    end

    neighbors.each do |neighbor|
      coord, symbol = neighbor

      next if symbol.nil?
      next if symbol == "#"

      neighbor_level = map[coord]
      neighbor_level = 0 if neighbor_level == goal
      neighbor_level = neighbor_level.to_i
      level_adjust = neighbor_level - level
      extra_distance = 1 + [level_adjust.abs, 10 - level_adjust.abs].min
      new_distance = distance + extra_distance
      new_level = level_adjust + level

      next if visited[coord] <= new_distance

      visited[coord] = new_distance
      queue.push([coord, new_distance, new_level])
    end
  end

  best
end

puts "Part 1:", shortest(input).inspect

input = File.read("./everybody_codes_e2024_q13_p2.txt")

puts "Part 2:", shortest(input).inspect

input = "SSSSSSSSSSS
S674345621S
S###6#4#18S
S53#6#4532S
S5450E0485S
S##7154532S
S2##314#18S
S971595#34S
SSSSSSSSSSS"

input = File.read("./everybody_codes_e2024_q13_p3.txt")

puts "Part 3:", shortest(input, "E", "S").inspect
