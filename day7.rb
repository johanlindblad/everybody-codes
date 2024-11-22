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

  [letter, power[1..].sum]
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

  [letter, power[1..].sum]
end

puts totals.inspect

puts "Part 2:", totals.sort_by(&:last).reverse.map(&:first).join("")

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

queue = [[1, 0]]
track_a = []
visited = Set.new
x, y = [1, 0]


loop do
  #x, y = queue.shift
  puts [x, y, track[y][x]].inspect
  track_a.push(track[y][x])
  visited.add([x, y])
  track[y][x] = "#"

  neigh = [[x + 1, y], [x, y + 1], [x - 1, y], [x, y - 1]]
    .reject { |pair| pair.first < 0 || pair.last < 0}
    .reject { |pair| pair.first >= track.first.length || pair.last >= track.length}
    .reject { |pair| track[pair.last][pair.first] == " "}
    .reject { |pair| track[pair.last][pair.first].nil? }
    .reject { |pair| visited.include?(pair)}
    #.first

  puts [:neigh, neigh, neigh.map { |pair| track[pair.last][pair.first] }].inspect

  neigh = neigh.first

  break if neigh.nil?

  x, y = neigh
end

puts track_a.join("")
