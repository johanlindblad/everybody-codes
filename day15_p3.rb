def build_graph(input)
  graph = {}
  input.each.with_index do |row, y|
    row.each.with_index do |c, x|
      next if c == "#"

      graph[[y, x]] = {}

      neigh = [[1, 0], [-1, 0], [0, 1], [0, -1]].map do |ds|
        dy, dx = ds
        [y + dy, x + dx]
      end.reject do |ds|
        dy, dx = ds
        dy < 0 || dx < 0 || dy > input.length || dx > input.first.length
      end.reject do |ds|
        dy, dx = ds
        input[dy][dx] == "#"
      end

      neigh.each do |n|
        graph[[y, x]][n] = 1
        graph[n] ||= {}
        graph[n][[y, x]] = 1
      end
    end
  end
  graph
end

# Not used - needs some work
def compress_graph(graph, input)
  loop do
    mod = false

    graph.each do |node, neigh|
      y, x = node
      if neigh.length == 2 && input[y][x] == "."
        c1, c2 = neigh.keys
        d1 = neigh[c1]
        d2 = neigh[c2]

        graph[c1][c2] = d1 + d2
        graph[c2][c1] = d1 + d2
        graph[c1].delete(node)
        graph[c2].delete(node)
        graph.delete(node)
        mod = true
      end
    end

    break unless mod
  end
end

def shortest_path(input, start)
  graph = build_graph(input)

  all_letters = Set.new(input.flatten.sort.uniq - "#.~".chars)

  queue = []
  queue.push([start, 0, Set.new])
  visited = {}

  until queue.empty?
    yx, dist, collected = queue.shift

    if yx == start && dist > 0
      return dist
    end

    graph[yx].each do |n, d|
      c = collected
      ny, nx = n

      if all_letters.include?(input[ny][nx])
        c = c + [input[ny][nx]]
      end

      next if visited.key?([n, c])
      next if n == start && c != all_letters

      queue.push([n, dist + d, c])
      visited[[n, c]] = 0
    end
  end
end

input = File.read("./everybody_codes_e2024_q15_p3.txt")
input = input.split("\n").map(&:chars)

width = input.first.length
part_width = width / 3
height = input.length

parts = input.map do |line|
  line.each_slice(part_width).to_a
end.transpose

# the bottom of the middle section contains two of the same letter but we need both
parts[1][-2][-2] = "Z"

a = shortest_path(parts.first, [height - 2, part_width - 2])
b = shortest_path(parts.last, [height - 2, 1])

startx = parts[1].first.index(".")
c = shortest_path(parts[1], [0, startx])

# left and right, back and forth, three steps in between the parts
extra = 2 * 2 * 3

puts a + b + c + extra

