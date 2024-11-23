input = "**PCBS**
**RLNW**
BV....PT
CR....HZ
FL....JW
SG....MN
**FTZV**
**GMJH**"

input = File.read("./everybody_codes_e2024_q10_p1.txt")

input = input.split("\n").map(&:chars)
transposed = input.transpose
word = []

(0...input.length).each do |y|
  (0...input.first.length).each do |x|
    next unless input[y][x] == "."
    row_letters = input[y].sort.uniq - ["."]
    col_letters = transposed[x].sort.uniq - ["."]

    word.push(row_letters & col_letters)
  end
end

puts "Part 1:", word.join("")

input = "**PCBS**
**RLNW**
BV....PT
CR....HZ
FL....JW
SG....MN
**FTZV**
**GMJH**"

input = File.read("./everybody_codes_e2024_q10_p2.txt")

rows = input.split("\n\n")

maps = rows.flat_map do |row|
  row.split("\n").map { |line| line.split(" ") }.transpose
end

scores = maps.map do |input|
  input = input.map(&:chars)
  transposed = input.transpose
  word = []

  (0...input.length).each do |y|
    (0...input.first.length).each do |x|
      next unless input[y][x] == "."
      row_letters = input[y].sort.uniq - ["."]
      col_letters = transposed[x].sort.uniq - ["."]

      word.push((row_letters & col_letters).first)
    end
  end

  bases = ("A".."Z").map.with_index { |l, i| [l, i + 1]}.to_h
  score = word.map.with_index { |l, i| bases[l] * (i + 1) }

  score.sum
end

puts "Part 2:", scores.sum
