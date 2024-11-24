input = "A:+,-,=,=
B:+,=,-,+
C:=,-,+,+
D:=,=,=,+"

input = File.read("./everybody_codes_e2024_q07_p1.txt")

input = input.split("\n")

totals = input.map do |plan|
  letter, steps = plan.split(":")
  steps = steps.split(",")

  power = steps.cycle.take(10).inject([10]) do |prev, step|
    new = case step
          when "+"
            prev.last + 1
          when "-"
            prev.last - 1
          when "="
            prev.last
          end

    prev + [new]
  end

  [letter, power.drop(1).sum]
end

puts "Part 1:", totals.sort_by(&:last).reverse.map(&:first).join("")

track = "S+===
-   +
=+=-+"

track = "S-=++=-==++=++=-=+=-=+=+=--=-=++=-==++=-+=-=+=-=+=+=++=-+==++=++=-=-=--
-                                                                     -
=                                                                     =
+                                                                     +
=                                                                     +
+                                                                     =
=                                                                     =
-                                                                     -
--==++++==+=+++-=+=-=+=-+-=+-=+-=+=-=+=--=+++=++=+++==++==--=+=++==+++-"

track = track.split("\n").map(&:chars)

track = [
  track.first,
  track.transpose.last,
  track.last.reverse,
  track.transpose.first.reverse
].map { _1[1..-1] }.flatten

input = "A:+,-,=,=
B:+,=,-,+
C:=,-,+,+
D:=,=,=,+"

input = File.read("./everybody_codes_e2024_q07_p2.txt")

input = input.split("\n")
loops = 10

totals = input.map do |plan|
  letter, steps = plan.split(":")
  steps = steps.split(",")
  len = track.length * loops

  power = steps.cycle.take(len).zip(track.cycle.take(len)).inject([10]) do |prev, pair|
    step, track_step = pair

    new = case [step, track_step]
          in [_, "+"]
            prev.last + 1
          in [_, "-"]
            prev.last - 1
          in ["+", _]
            prev.last + 1
          in ["-", _]
            prev.last - 1
          in _
            prev.last
          end

    prev + [new]
  end

  [letter, power.drop(1).sum]
end

puts totals.inspect

puts "Part 2:", totals.sort_by(&:last).reverse.map(&:first).join("")

input = File.read("./everybody_codes_e2024_q07_p3.txt")
input = input.split("\n")

track = "S+= +=-== +=++=     =+=+=--=    =-= ++=     +=-  =+=++=-+==+ =++=-=-=--
- + +   + =   =     =      =   == = - -     - =  =         =-=        -
= + + +-- =-= ==-==-= --++ +  == == = +     - =  =    ==++=    =++=-=++
+ + + =     +         =  + + == == ++ =     = =  ==   =   = =++=
= = + + +== +==     =++ == =+=  =  +  +==-=++ =   =++ --= + =
+ ==- = + =   = =+= =   =       ++--          +     =   = = =--= ==++==
=     ==- ==+-- = = = ++= +=--      ==+ ==--= +--+=-= ==- ==   =+=    =
-               = = = =   +  +  ==+ = = +   =        ++    =          -
-               = + + =   +  -  = + = = +   =        +     =          -
--==++++==+=+++-= =-= =-+-=  =+-= =-= =--   +=++=+++==     -=+=++==+++-"

track = track.split("\n")

steps = input.first.split(":").last.split(",")

track_a = []
visited = Set.new
x = 1
y = 0

loop do
  track_a.push(track[y][x])
  visited.add([x, y])
  track[y][x] = "#"

  neigh = [[x + 1, y], [x, y + 1], [x - 1, y], [x, y - 1]]
          .reject { |pair| pair.first < 0 || pair.last < 0 }
          .reject { |pair| pair.first >= track.first.length || pair.last >= track.length }
          .reject { |pair| track[pair.last][pair.first] == " " }
          .reject { |pair| track[pair.last][pair.first].nil? }
          .reject { |pair| visited.include?(pair) }

  neigh = neigh.first

  break if neigh.nil?

  x, y = neigh
end

loops = 2024
loops = 11
track_length = track_a.length
total_length = loops * track_length
len = total_length

power = steps.cycle.take(len).zip(track_a.cycle.take(len)).inject([10]) do |prev, pair|
  step, track_step = pair

  new = case [step, track_step]
        in [_, "+"]
          prev.last + 1
        in [_, "-"]
          prev.last - 1
        in ["+", _]
          prev.last + 1
        in ["-", _]
          prev.last - 1
        in _
          prev.last
        end

  prev + [new]
end

competitor = power.drop(1).sum
puts "Competitor:", competitor

i = 0

queue = [[[], "+++++---===".chars]]

1.upto(11).each do |i|
  new_queue = Set.new

  queue.each do |prev|
    existing, options = prev
    options.uniq.each do |option|
      index = options.index(option)
      new_options = options.dup
      new_options.delete_at(index)
      new_queue.add([existing + [option], new_options])
    end
  end

  queue = new_queue.to_a
end

permutations = queue.map(&:first)

num = permutations.count do |steps|
  puts i if i % 1_000 == 0
  i += 1

  power = steps.cycle.take(len).zip(track_a.cycle.take(len)).inject([10]) do |prev, pair|
    step, track_step = pair
    new = case [step, track_step]
          in [_, "+"]
            prev.last + 1
          in [_, "-"]
            prev.last - 1
          in ["+", _]
            prev.last + 1
          in ["-", _]
            prev.last - 1
          in _
            prev.last
          end

    prev + [new]
  end

  power.drop(1).sum > competitor
end

puts "Part 3:", num.inspect
