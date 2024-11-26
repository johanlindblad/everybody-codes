input = "1,2,3

^_^ -.- ^,-
>.- ^_^ >.<
-_- -.- >.<
    -.^ ^_^
    >.>"

input = File.read("./everybody_codes_e2024_q16_p1.txt")

spins, wheels = input.split("\n\n")

spins = spins.split(",").map(&:to_i)

wheels = wheels.split("\n")

wheels = (0...wheels.first.length).each_with_object([[]]) do |x, groups|
  wheel = (0...wheels.length).map do |y|
    wheels[y][x]&.strip || ""
  end.reject(&:empty?)

  if wheel.empty?
    groups.push([])
  else
    groups.last.push(wheel)
  end
end

after_pulls = 1.upto(100).map do |n|
  wheels.zip(spins).map do |pair|
    wheel, spin = pair

    index = (n * spin) % wheel.first.length

    wheel.map do |faces|
      faces[index]
    end
  end
end

hundredth = after_pulls.last.map(&:join).join(" ")

puts "Part 1:", hundredth

input = "1,2,3

^_^ -.- ^,-
>.- ^_^ >.<
-_- -.- >.<
    -.^ ^_^
    >.>"

input = File.read("./everybody_codes_e2024_q16_p2.txt")

spins, wheels = input.split("\n\n")

spins = spins.split(",").map(&:to_i)

wheels = wheels.split("\n")

wheels = (0...wheels.first.length).each_with_object([[]]) do |x, groups|
  wheel = (0...wheels.length).map do |y|
    wheels[y][x]&.strip || ""
  end.reject(&:empty?)

  if wheel.empty?
    groups.push([])
  else
    groups.last.push(wheel)
  end
end.reject { |a| a == [] }

repeats_after = wheels.zip(spins).map do |pair|
  wheel, spin = pair

  length = wheel.first.length

  sequence = (1..).lazy.map { |s| (spin * s) % length }.take_while { |n| n != 0 }.to_a
  sequence.length + 1
end.reduce(&:lcm)

after_pulls = 1.upto(repeats_after).map do |n|
  wheels.zip(spins).map do |pair|
    wheel, spin = pair

    index = (n * spin) % wheel.first.length

    up = wheel.map do |faces|
      faces[index]
    end

    [up.first, up.last]
  end
end

coins = after_pulls.map do |after|
  after.flatten.tally.values.select { |n| n >= 3 }.sum { |n| n - 2 }
end

goal = 202_420_242_024

full = goal / repeats_after
rest = goal - (repeats_after * full)

for_full = full * coins.sum
for_rest = coins.take(rest).sum

result = for_full + for_rest

puts "Part 2:", result

input = "1,2,3

^_^ -.- ^,-
>.- ^_^ >.<
-_- -.- ^.^
    -.^ >.<
    >.>"

input = File.read("./everybody_codes_e2024_q16_p3.txt")

spins, wheels = input.split("\n\n")

spins = spins.split(",").map(&:to_i)

wheels = wheels.split("\n")

wheels =
  (0...wheels.first.length).reject { |n| n % 4 == 1 }.map do |x|
    (0...wheels.length).map do |y|
      wheels[y][x]&.strip || ""
    end.reject(&:empty?).join
  end.reject(&:empty?)

spins = spins.flat_map { |s| [s] * 2 }

repeats_after = wheels.map(&:length).uniq.reduce(&:lcm)

cache = {}

minmax_score = lambda do |prev_offset, spin_number, spins_left|
  if spins_left == 0
    [0, 0]
  elsif cache.key?([prev_offset, spin_number, spins_left])
    cache[[prev_offset, spin_number, spins_left]]
  else
    options = (-1..1).map do |offset|
      symbols = wheels.map.with_index do |wheel, wheel_index|
        wheel[((spins[wheel_index] * spin_number) + prev_offset + offset) % wheels[wheel_index].length]
      end

      score = symbols.tally.values.select { |n| n >= 3 }.sum { |n| n - 2 }

      minmax = minmax_score.call(prev_offset + offset, spin_number + 1, spins_left - 1)

      [score + minmax.first, score + minmax.last]
    end

    max = options.flatten.minmax
    cache[[prev_offset, spin_number, spins_left]] = max
    max
  end
end

minmax = minmax_score.call(0, 1, 256)

puts "Part 3:", minmax.reverse.join(" ")
