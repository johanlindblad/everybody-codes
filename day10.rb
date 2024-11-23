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

input = "**XFZB**DCST**
**LWQK**GQJH**
?G....WL....DQ
BS....H?....CN
P?....KJ....TV
NM....Z?....SG
**NSHM**VKWZ**
**PJGV**XFNL**
WQ....?L....YS
FX....DJ....HV
?Y....WM....?J
TJ....YK....LP
**XRTK**BMSP**
**DWZN**GCJV**"

input = File.read("./everybody_codes_e2024_q10_p3.txt")
input = input.split("\n").map(&:chars)
total_score = 0

word_scores = {}

loop do
  startx = 0
  starty = 0
  total_score = word_scores.values.sum
  loop do 
    startx = 0
    loop do
      unhandled = []

      ((starty + 2)..(starty + 5)).each do |y|
        ((startx + 2)..(startx + 5)).each do |x|
          row_options =
            [[y, startx], [y, startx + 1], [y, startx + 6], [y, startx + 7]]
            .map { input[_1.first][_1.last] }
          col_options =
            [[starty, x], [starty + 1, x], [starty + 6, x], [starty + 7, x]]
            .map { input[_1.first][_1.last] }

          common = row_options & col_options

          if common.length == 1
            input[y][x] = common.first
          else
            unhandled.push([y, x])
          end
        end
      end

      row_options = lambda do |dy|
        [0, 1, 6, 7].map  do |dx|
          input[starty + 2 + dy][startx + dx]
        end - ["?"]
      end

      col_options = lambda do |dx|
        [0, 1, 6, 7].map  do |dy|
          input[starty + dy][startx + 2 + dx]
        end - ["?"]
      end

      row_used = lambda do |dy|
        0.upto(3).map do |dx|
          input[dy + starty + 2][dx + startx + 2]
        end - ["."]
      end

      col_used = lambda do |dx|
        0.upto(3).map do |dy|
          input[dy + starty + 2][dx + startx + 2]
        end - ["."]
      end

      fill_blank = lambda do |y, x, val|
        [0, 1, 6, 7].each do |dx|
          if input[y][startx + dx] == "?"
            input[y][startx + dx] = val
          end
        end

        [0, 1, 6, 7].each do |dy|
          if input[starty + dy][x] == "?"
            input[starty + dy][x] = val
          end
        end
      end

      unhandled.each do |yx|
        y, x = yx

        row = y - starty - 2
        col = x - startx - 2

        unused_row = row_options[row] - row_used[row]
        unused_col = col_options[col] - col_used[col]

        options = (unused_row + unused_col).uniq

        if options.length == 1
          option = options.first
          input[y][x] = option
          fill_blank.(y, x, option)
        end
      end

      word = 0.upto(3).map do |y|
        row_used[y].join("")
      end.join("").chars

      incomplete = word.length < 16

      unless incomplete
        bases = ("A".."Z").map.with_index { |l, i| [l, i + 1]}.to_h
        score = word.map.with_index { |l, i| bases[l] * (i + 1) }

        word_scores[[starty, startx]] = score.sum unless incomplete
      end

      startx += 6
      break if startx + 8 > input.first.length
    end

    starty += 6
    break if starty + 8 > input.length
  end

  break if word_scores.values.sum == total_score
end

# puts input.map(&:join)
puts "Part 3:", total_score
