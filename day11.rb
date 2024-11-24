input = "A:B,C
B:C,A
C:A"

input = File.read("./everybody_codes_e2024_q11_p1.txt")

input = input.split("\n").map { |line| line.split(":") }

graph = {}

input.each do |line|
  parent, children = line
  children = children.split(",")
  graph[parent] = children
end

pop = ["A"]

1.upto(4).each do
  pop = pop.flat_map do |parent|
    graph[parent]
  end
  puts pop.inspect
end

puts "Part 1:", pop.length

input = File.read("./everybody_codes_e2024_q11_p2.txt")

input = input.split("\n").map { |line| line.split(":") }

graph = {}

input.each do |line|
  parent, children = line
  children = children.split(",")
  graph[parent] = children
end

pop = ["Z"]

1.upto(10).each do
  pop = pop.flat_map do |parent|
    graph[parent]
  end
  puts pop.inspect
end

puts "Part 2:", pop.length

input = File.read("./everybody_codes_e2024_q11_p3.txt")

input = input.split("\n").map { |line| line.split(":") }

graph = {}

input.each do |line|
  parent, children = line
  children = children.split(",")
  graph[parent] = children
end

res = graph.keys.map do |start|
  pop = [start].tally
  new_pop = {}

  1.upto(20).each do |n|
    new_pop = {}
    pop.each do |key, num|
      result = graph[key]
      result.each do |r|
        new_pop[r] ||= 0
        new_pop[r] += num
      end
    end

    pop = new_pop.dup
    puts n
  end

  pop.values.sum
end

puts "Part 3:", res.minmax.reverse.inject(&:-)
