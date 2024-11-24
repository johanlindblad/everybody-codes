input = "#####.#####
#.........#
#.######.##
#.........#
###.#.#####
#H.......H#
###########"

input = File.read("./everybody_codes_e2024_q15_p1.txt")

input = input.split("\n").map(&:chars)

entry = input.first.index(".")

queue = [[[0, entry], 0]]
visited = Set.new

NEIGHBORS = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

until queue.empty?
  coord, dist = queue.shift
  y, x = coord
  visited.add([y, x])

  if input[y][x] == "H"
    puts "Part 1:", dist * 2
    break
  end

  neigh = NEIGHBORS.map do |d|
    dy, dx = d
    [y + dy, x + dx]
  end.reject do |d|
    dy, dx = d
    dy < 0 || dx < 0 || dy >= input.length || dx >= input.length
  end.reject do |d|
    dy, dx = d
    input[dy][dx] == "#"
  end.reject do |d|
    visited.include?(d)
  end

  neigh.each do |n|
    queue.push([n, dist + 1])
  end
end

input = "##########.##########
#...................#
#.###.##.###.##.#.#.#
#..A#.#..~~~....#A#.#
#.#...#.~~~~~...#.#.#
#.#.#.#.~~~~~.#.#.#.#
#...#.#.B~~~B.#.#...#
#...#....BBB..#....##
#C............#....C#
#####################"

input = File.read("./everybody_codes_e2024_q15_p2.txt")

input = input.split("\n").map(&:chars)

entry = input.first.index(".")

all_letters = input.join("").chars.sort.uniq - "#.~".chars

entry = input.first.index(".")
input[0][entry] = "H"

queue = []
queue.push([[0, entry], 0, Set.new])
visited = Set.new

until queue.empty?
  coord, dist, collected = queue.shift
  y, x = coord
  visited.add([y, x, collected])

  if all_letters.include?(input[y][x])
    collected = collected.dup
    collected.add(input[y][x])
  end

  if input[y][x] == "H" && dist != 0
    puts "Part 2:", dist
    break
  end

  neigh = NEIGHBORS.map do |d|
    dy, dx = d
    [y + dy, x + dx]
  end.reject do |d|
    dy, dx = d
    dy < 0 || dx < 0 || dy >= input.length || dx >= input.first.length
  end.reject do |d|
    dy, dx = d
    input[dy][dx] == "#" || input[dy][dx] == "~"
  end.reject do |d|
    visited.include?(d + [collected])
  end

  neigh.each do |n|
    ny, nx = n
    if input[ny][nx] != "H" || collected.length == all_letters.length
      queue.push([n, dist + 1, collected])
      visited.add(n + [collected])
    end
  end
end
