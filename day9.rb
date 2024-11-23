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
    if costs[start + stamp] > (costs[start] + 1)
      costs[start + stamp] = costs[start] + 1
    end
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
      if costs[start + stamp] > (costs[start] + 1)
        costs[start + stamp] = costs[start] + 1
      end
    end
  end

  mid = target / 2
  min = mid - 51
  max = mid + 51

  best = (min..mid).map do |i|
    other = target - i
    [i, other, costs[i] + costs[other], other - i]
    costs[i] + costs[other]
  end

  #puts costs[min..max].inspect

  #puts best.min
  #best.min_by { [_1[1], _1.last] }.map { _1[1]}
  best.min

  #max = (target / 2) + 100
  #puts costs[176245]
  #puts costs[176241]
  #puts [:minmax, min, max].inspect
  #puts costs[min..max].tally.inspect
end

puts res.sum
