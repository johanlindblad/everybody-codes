input = "U5,R3,D2,L5,U4,R5,D2"
input = File.read("./everybody_codes_e2024_q14_p1.txt")

input = input.split(",").map(&:chars)

x = 0
y = 0
z = 0
maxz = 0

input.each do |step|
  dir = step[0]
  num = step.drop(1).join.to_i

  case dir
  when "U"
    z += num
  when "D"
    z -= num
  when "L"
    y -= num
  when "R"
    y += num
  when "F"
    x += num
  when "B"
    x -= num
  end

  maxz = [z, maxz].max
end

puts "Part 1:", maxz

input = "U5,R3,D2,L5,U4,R5,D2
U6,L1,D2,R3,U2,L1"

input = File.read("./everybody_codes_e2024_q14_p2.txt")
input = input.split("\n")

segments = Set.new

input.each do |plant|
  x = 0
  y = 0
  z = 0

  plant.split(",").map(&:chars).each do |step|
    dir = step[0]
    num = step.drop(1).join.to_i

    ox = x
    oy = y
    oz = z

    case dir
    when "U"
      z += num
      (oz..z).each { |nz| segments.add([x, y, nz]) }
    when "D"
      z -= num
      (z..oz).each { |nz| segments.add([x, y, nz]) }
    when "L"
      y -= num
      (y..oy).each { |ny| segments.add([x, ny, z]) }
    when "R"
      y += num
      (oy..y).each { |ny| segments.add([x, ny, z]) }
    when "F"
      x += num
      (ox..x).each { |nx| segments.add([nx, y, z]) }
    when "B"
      x -= num
      (x..ox).each { |nx| segments.add([nx, y, z]) }
    end
  end
end

puts "Part 2:", segments.length - 1

input = "U20,L1,B1,L2,B1,R2,L1,F1,U1
U10,F1,B1,R1,L1,B1,L1,F1,R2,U1
U30,L2,F1,R1,B1,R1,F2,U1,F1
U25,R1,L2,B1,U1,R2,F1,L2
U16,L1,B1,L1,B3,L1,B1,F1"

input = File.read("./everybody_codes_e2024_q14_p3.txt")
input = input.split("\n")

segments = Set.new

leaves = Set.new

input.each do |plant|
  x = 0
  y = 0
  z = 0

  plant.split(",").map(&:chars).each do |step|
    dir = step[0]
    num = step.drop(1).join.to_i

    ox = x
    oy = y
    oz = z

    case dir
    when "U"
      z += num
      (oz..z).each { |nz| segments.add([x, y, nz]) }
    when "D"
      z -= num
      (z..oz).each { |nz| segments.add([x, y, nz]) }
    when "L"
      y -= num
      (y..oy).each { |ny| segments.add([x, ny, z]) }
    when "R"
      y += num
      (oy..y).each { |ny| segments.add([x, ny, z]) }
    when "F"
      x += num
      (ox..x).each { |nx| segments.add([nx, y, z]) }
    when "B"
      x -= num
      (x..ox).each { |nx| segments.add([nx, y, z]) }
    end
  end

  leaves.add([x, y, z])
end

minz = leaves.map(&:last).min
maxz = leaves.map(&:last).max

OFFSETS = [
  [1, 0, 0], [-1, 0, 0],
  [0, 1, 0], [0, -1, 0],
  [0, 0, 1], [0, 0, -1]
].freeze

min_dist = (minz..maxz).map do |tap_z|
  leaves_found = {}

  queue = [[[0, 0, tap_z], 0]]
  visited = Set.new
  min_dist = 1_000_000

  until queue.empty?
    coord, dist = queue.shift
    next if visited.include?(coord)

    visited.add(coord)

    if leaves.include?(coord) && !leaves_found.key?(coord)
      leaves_found[coord] = dist
      break if leaves_found.length == leaves.length
    end

    OFFSETS.map do |ds|
      coord.zip(ds).map(&:sum)
    end.select do |new_coord|
      segments.include?(new_coord) && !visited.include?(new_coord)
    end.each do |new_coord|
      queue.push([new_coord, dist + 1])
    end
  end

  leaves_found.values.sum
end

puts "Part 3:", min_dist.min
