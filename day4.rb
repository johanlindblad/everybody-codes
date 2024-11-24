input = "3
4
7
8"

input = File.read("./everybody_codes_e2024_q04_p1.txt")

input = input.split("\n").map(&:to_i)

lowest = input.min

total = input.sum { |n| n - lowest }

puts "Part 1:", total

input = File.read("./everybody_codes_e2024_q04_p2.txt")
input = input.split("\n").map(&:to_i)
lowest = input.min

total = input.sum { |n| n - lowest }

puts "Part 2:", total

input = File.read("./everybody_codes_e2024_q04_p3.txt")

input = input.split("\n").map(&:to_i)

min_diff_to_others = input.min_by do |height|
  input.sum { |n| (n - height).abs }
end

hits = input.sum { |n| (n - min_diff_to_others).abs }

puts "Part 3:", hits
