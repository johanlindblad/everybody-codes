require 'pqueue'

input = "*...*
..*..
.....
.....
*.*.."

# input = File.read("./everybody_codes_e2024_q17_p1.txt")
# input = File.read("./everybody_codes_e2024_q17_p2.txt")

input = input.split("\n").map(&:chars)

positions = (0...input.length).flat_map do |y|
  (0...input.first.length).filter_map do |x|
    [input.length - y, x + 1] if input[y][x] == "*"
  end
end

graph = {}
edges = []

positions.each.with_index do |p, i|
  positions.each.with_index do |p2, i2|
    next if p == p2

    y1, x1 = p
    y2, x2 = p2

    dist = [(y1 - y2).abs, (x1 - x2).abs].sum

    graph[i] ||= {}
    graph[i2] ||= {}
    graph[i][i2] = dist
    edges.push([i, i2, dist])
  end
end

vertices = Set.new([0])
mst = []

loop do
  min = edges.select do |e|
    vertices.include?(e[0]) ^ vertices.include?(e[1])
  end.min_by(&:last)

  mst.push(min)

  vertices.add(min[0])
  vertices.add(min[1])

  break if vertices.length == graph.length
end

puts "Part 1/2:", mst.sum(&:last) + graph.length

input = ".......................................
..*.......*...*.....*...*......**.**...
....*.................*.......*..*..*..
..*.........*.......*...*.....*.....*..
......................*........*...*...
..*.*.....*...*.....*...*........*.....
......................................."

input = File.read("./everybody_codes_e2024_q17_p3.txt")

input = input.split("\n").map(&:chars)

positions = (0...input.length).flat_map do |y|
  (0...input.first.length).filter_map do |x|
    [input.length - y, x + 1] if input[y][x] == "*"
  end
end

graph = {}

positions.each.with_index do |p1, i1|
  positions.each.with_index do |p2, i2|
    next if p1 == p2

    weight = p1.zip(p2).sum { |cs| (cs.first - cs.last).abs }

    edge = [i1, i2].sort
    edge += [weight]

    graph[i1] ||= []
    graph[i2] ||= []
    graph[i1].push(edge)
    graph[i2].push(edge)
  end
end

visited = Set.new
clusters = []

loop do
  first = graph.keys.reject { |k| visited.include?(k) }.first

  break if first.nil?

  vertices = Set.new([first])
  mst = []

  queue = PQueue.new { |edge1, edge2| edge1.last < edge2.last }

  graph[first].each { |edge| queue.push(edge) unless edge.last >= 6 }

  until queue.empty?
    min_edge = queue.pop

    next if vertices.include?(min_edge[0]) && vertices.include?(min_edge[1])

    mst.push(min_edge)

    vertices.add(min_edge[0])
    vertices.add(min_edge[1])

    [min_edge[0], min_edge[1]].each do |from_node|
      graph[from_node].each do |edge|
        from, to, weight = edge
        both_visited = vertices.include?(from) && vertices.include?(to)
        queue.push(edge) unless both_visited || weight >= 6 || queue.include?(edge)
      end
    end

    break if vertices.length == graph.length
  end

  clusters.push(mst.sum(&:last) + vertices.length)
  visited += vertices
end

product = clusters.sort.max(3).inject(&:*)

puts "Part 3:", product.inspect
