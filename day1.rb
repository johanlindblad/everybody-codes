input = "ABBAC"
input = File.read("./everybody_codes_e2024_q01_p1.txt")

tally = input.split("").tally

costs = { "A" => 0, "B" => 1, "C" => 3 }

puts "Part 1:", tally["B"] + (costs["C"] * tally["C"])

input = "AxBCDDCAxD"
input = File.read("./everybody_codes_e2024_q01_p2.txt")

costs["D"] = 5

part2 = input.split("").each_slice(2).map do |slice|
  a, b = slice
  num = [a, b].map { |x| costs[x] }.reject(&:nil?)

  if num.length == 2
    num.sum + 2
  else
    num.sum
  end
end

puts "Part2:", part2.sum

input = "xBxAAABCDxCC"
input = File.read("./everybody_codes_e2024_q01_p3.txt")

part3 = input.split("").each_slice(3).map do |slice|
  a, b, c = slice
  num = [a, b, c].map { |x| costs[x] }.reject(&:nil?)

  if num.length == 3
    num.sum + 6
  elsif num.length == 2
    num.sum + 2
  else
    num.sum
  end
end

puts "Part 3:", part3.sum
