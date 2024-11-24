stamps = [1, 3, 5, 10]

input = "2
4
7
16"

input = File.read("./everybody_codes_e2024_q09_p1.txt")

input = input.split("\n").map(&:to_i)

costs = input.map do |n|
  cost = 0

  stamps.reverse.each do |stamp|
    next if stamp > n

    used = n / stamp
    cost += used
    n -= (used * stamp)
  end

  cost
end

puts "Part 1:", costs.sum

stamps = [1, 3, 5, 10, 15, 16, 20, 24, 25, 30]

input = "33
41
55
99"

input = File.read("./everybody_codes_e2024_q09_p2.txt")

input = input.split("\n").map(&:to_i)

max = input.max

costs = Array.new(max + stamps.max + 1, 1_000_000)
costs[0] = 0

stamps.each do |stamp|
  0.upto(max).each do |start|
    costs[start + stamp] = costs[start] + 1 if costs[start + stamp] > (costs[start] + 1)
  end
end

puts "Part 2:", input.map { costs[_1] }.sum

stamps = [1, 3, 5, 10, 15, 16, 20, 24, 25, 30, 37, 38, 49, 50, 74, 75, 100, 101]

input = "156488
352486
546212"

input = File.read("./everybody_codes_e2024_q09_p3.txt")

input = input.split("\n").map(&:to_i)

res = input.map do |target|
  costs = Array.new((target / 2) + stamps.max + 100 + 1, 1_000_000_000)
  costs[0] = 0
  stamps.each do |stamp|
    0.upto(costs.length - 1 - stamp).each do |start|
      costs[start + stamp] = costs[start] + 1 if costs[start + stamp] > (costs[start] + 1)
    end
  end

  mid = target / 2
  odd = 0
  odd = 1 if target.odd?

  options = 0.upto(50 - odd).map do |i|
    costs[mid - i] + costs[mid + odd + i]
  end

  options.min
end

puts res.sum
