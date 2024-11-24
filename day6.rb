input = "RR:A,B,C
A:D,E
B:F,@
C:G,H
D:@
E:@
F:@
G:@
H:@"

input = File.read("./everybody_codes_e2024_q06_p1.txt")

graph = {}

input.split("\n").map { |line| line.split(":") }.each do |line|
  node, children = line

  graph[node] = children.split(",")
end

depths = {}

queue = [[["RR"], 0]]

until queue.empty?
  path, depth = queue.shift
  node = path.last

  next unless graph.key?(node)

  graph[node].each do |child|
    if child == "@"
      depths[depth] ||= []
      depths[depth].push(path + ["@"])
    else
      queue.push([path + [child], depth + 1])
    end
  end
end

puts "Part 1:", depths.values.find { |paths| paths.length == 1 }.first.join("")

input = File.read("./everybody_codes_e2024_q06_p2.txt")

graph = {}

input.split("\n").map { |line| line.split(":") }.each do |line|
  node, children = line

  graph[node] = children.split(",")
end

depths = {}

queue = [[["RR"], 0]]

until queue.empty?
  path, depth = queue.shift
  node = path.last

  next unless graph.key?(node)

  graph[node].each do |child|
    if child == "@"
      depths[depth] ||= []
      depths[depth].push(path + ["@"])
    else
      queue.push([path + [child], depth + 1])
    end
  end
end

puts "Part 2:", depths.values.find { |paths| paths.length == 1 }.first.map(&:chars).map(&:first).join("")

input = File.read("./everybody_codes_e2024_q06_p3.txt")
graph = {}

input.split("\n").map { |line| line.split(":") }.each do |line|
  node, children = line

  graph[node] = children.split(",")
end

depths = {}

queue = [[["RR"], 0]]

until queue.empty?
  path, depth = queue.shift
  node = path.last

  break if !depths.key?(depth) && depths.key?(depth - 1) && depths[depth - 1].length == 1

  next unless graph.key?(node)

  graph[node].each do |child|
    if child == "@"
      depths[depth] ||= []
      depths[depth].push(path + ["@"])
    else
      queue.push([path + [child], depth + 1])
    end
  end
end

puts "Part 3:", depths.values.find { |paths| paths.length == 1 }.first.map(&:chars).map(&:first).join("")
