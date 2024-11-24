input = ".............
.C...........
.B......T....
.A......T.T..
============="

input = File.read("./everybody_codes_e2024_q12_p1.txt")

input = input.split("\n").map(&:chars)

segments = (0...input.length).to_a.product((0...input.first.length).to_a).reject do |pair|
  "T=.".chars.include?(input[pair.first][pair.last])
end.map do |pair|
  [input[pair.first][pair.last], pair]
end.to_h

targets = (0...input.length).to_a.product((0...input.first.length).to_a).select do |pair|
  input[pair.first][pair.last] == "T"
end

letters = segments.map(&:first).sort

res = targets.map do |target|
  y, x = target

  options = segments.map do |segment|
    letter, coord = segment
    sy, sx = coord

    power = ((1..100).find do |p|
      initial_dx = (p * 2)
      initial_dy = -p

      new_y = sy + initial_dy
      new_x = sx + initial_dx

      y - new_y == x - new_x
    end)

    if power.nil?
      nil
    else
      power * (letters.index(letter) + 1)
    end
  end.reject(&:nil?)

  options.min
end

puts "Part 1:", res.sum

input = ".............
.C...........
.B......H....
.A......T.H..
============="

input = File.read("./everybody_codes_e2024_q12_p2.txt")

input = input.split("\n").map(&:chars)

segments = (0...input.length).to_a.product((0...input.first.length).to_a).reject do |pair|
  "TH=.".chars.include?(input[pair.first][pair.last])
end.map do |pair|
  [input[pair.first][pair.last], pair]
end.to_h

targets = (0...input.length).to_a.product((0...input.first.length).to_a).select do |pair|
  "TH".chars.include?(input[pair.first][pair.last])
end

letters = segments.map(&:first).sort

res = targets.map do |target|
  y, x = target
  type = input[y][x]

  options = segments.map do |segment|
    letter, coord = segment
    sy, sx = coord

    power = ((1..100).find do |p|
      initial_dx = (p * 2)
      initial_dy = -p

      new_y = sy + initial_dy
      new_x = sx + initial_dx

      y - new_y == x - new_x
    end)

    if power.nil?
      nil
    else
      power * (letters.index(letter) + 1)
    end
  end.reject(&:nil?)

  if type == "H"
    options.min * 2
  else
    options.min
  end
end

puts "Part 2:", res.sum

map = ".............
.C...........
.B......H....
.A......T.H..
============="

input = File.read("./everybody_codes_e2024_q12_p3.txt")

input = input.split("\n").map { |line| line.split(" ").map(&:to_i) }

map = map.split("\n").map(&:chars)
height = map.length

segments = (0...map.length).to_a.product((0...map.first.length).to_a).reject do |pair|
  "TH=.".chars.include?(map[pair.first][pair.last])
end.map do |pair|
  y, x = pair
  [map[pair.first][pair.last], [height - y - 2, x]]
end.to_h

targets = input.map do |pair|
  x, y = pair
  ay, ax = segments["A"]
  [y + ay, x + ax]
end

letters = segments.map(&:first).sort

best = targets.map do |pair|
  ty, tx = pair

  options = []

  segments.each do |letter, coord|
    sy, sx = coord

    # First, try hitting during first phase
    # Because they move along the same line, if it can hit it will at
    # 0 and at later times, but altitude is maximized with t=0
    # Power only needs to be just enough to stay in this phase until hit
    hits_during_first_stage = ty - sy == tx - sx
    required_power = (ty - sy) / 2
    y = sy + required_power
    even_diff = (ty - sy).odd?

    if hits_during_first_stage && even_diff
      ranking = required_power * (1 + letters.index(letter))
      options.push([ranking, y, letter])
    end

    # Next, try hitting during the horizontal phase
    # Different powers are possible but definitely not more than to
    # meet the target in the middle
    max_power = required_power
    1.upto(max_power).each do |p|
      t = ty - sy - p
      wt = sx + (2 * t) - tx

      y = sy + p

      sufficient_time = (p..(2 * p)).cover?(t)
      positive_waiting_time = wt >= 0

      next unless sufficient_time && positive_waiting_time

      ranking = p * (1 + letters.index(letter))
      options.push([ranking, y, letter])
    end

    # Lastly, try hitting during the downward phase
    max_power = (tx - sx) / 2

    max_power = required_power
    1.upto(max_power).each do |p|
      wt = ty - sy - (3 * p)
      t = (tx - sx + wt) / 2
      y = ty - t

      sufficient_time = t >= 2 * p
      positive_waiting_time = wt >= 0
      positive_altitude = y >= 0
      even_diff = (tx - sx + wt).even?

      next unless sufficient_time && positive_waiting_time && positive_altitude && even_diff

      ranking = p * (1 + letters.index(letter))
      options.push([ranking, y, letter])
    end
  end

  options.max_by do |option|
    ranking, altitude = option
    [altitude, -ranking]
  end.first
end

puts "Part 3:", best.sum
