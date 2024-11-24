input = "2 3 4 5
3 4 5 2
4 5 2 3
5 2 3 4"

input = File.read("./everybody_codes_e2024_q05_p1.txt")

input = input.split("\n").map { |line| line.split(" ").map(&:to_i) }.transpose

answer = 1.upto(10).map do |round|
  target_column = round % input.length
  source_column = (round - 1) % input.length

  number = input[source_column].shift

  target_length = input[target_column].length

  if number <= target_length
    input[target_column].insert(number - 1, number)
  else
    # 2          5      - 3
    steps_left = number - target_length
    input[target_column].insert(-steps_left, number)
  end

  input.map(&:first).join("")
end.last

puts "Part 1:", answer

input = "2 3 4 5
6 7 8 9"

input = File.read("./everybody_codes_e2024_q05_p2.txt")

input = input.split("\n").map { |line| line.split(" ").map(&:to_i) }.transpose

counts = Hash.new { 0 }
round = 0

answer = loop do
  round += 1
  target_column = round % input.length
  source_column = (round - 1) % input.length

  number = input[source_column].shift

  target_length = input[target_column].length

  if number <= target_length
    input[target_column].insert(number - 1, number)
  else
    # 2          5      - 3
    minus_loops = number % (target_length + 1)
    steps_left = minus_loops - target_length
    input[target_column].insert(-steps_left, number)
  end

  result = input.map(&:first).join("").to_i

  counts[result] += 1
  break result * round if counts[result] == 2024
end

puts "Part 2:", answer

input = "2 3 4 5
6 7 8 9"

input = File.read("./everybody_codes_e2024_q05_p3.txt")

input = input.split("\n").map { |line| line.split(" ").map(&:to_i) }.transpose

counts = Hash.new { 0 }
round = 0

max = 0

answer = loop do
  round += 1
  target_column = round % input.length
  source_column = (round - 1) % input.length

  number = input[source_column].shift

  target_length = input[target_column].length

  position = (number - 1) % (target_length * 2)

  position = (2 * target_length) - position if position >= target_length

  input[target_column].insert(position, number)

  result = input.map(&:first).join("").to_i

  max = result if result > max

  break counts.values.max if counts.key?(input.inspect)

  counts[input.inspect] = result
end

puts "Part 3:", answer
