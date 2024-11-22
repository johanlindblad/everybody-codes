input = "2 3 4 5
3 4 5 2
4 5 2 3
5 2 3 4"

input = "3 2 2 4
3 4 4 5
5 2 4 2
3 2 3 5
5 4 5 3"

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

input = "48 87 75 29
51 65 41 78
85 81 51 36
50 93 37 18
14 97 98 34
10 49 56 32
50 45 82 41
39 28 89 59
13 91 55 66
57 88 20 42
81 78 69 78
76 54 31 98
40 57 11 82
49 28 24 43
96 85 24 79
72 98 86 67
73 84 58 99
28 26 66 80
34 11 67 45
39 99 64 96
19 62 90 92
20 59 28 31
36 60 15 40
74 57 41 82
16 14 75 49
38 88 24 66
60 94 74 36
73 63 68 56
17 16 79 25
23 36 27 55
92 65 23 95
97 91 13 11
41 30 33 86
22 12 56 18
91 61 15 87
37 62 27 11
21 63 64 97
30 16 34 35
33 77 40 61
82 12 42 93
20 13 29 85
83 17 47 21
17 46 19 73
32 38 33 96
26 37 30 53
15 27 31 22
67 25 46 39
38 53 25 90
16 71 35 26
79 80 22 14
31 27 45 19
38 18 49 83
14 77 71 70
43 52 51 92
19 21 46 48
15 30 43 35
25 26 81 62
27 81 77 43
88 62 21 37
69 14 71 71
85 58 83 47
53 78 65 87
42 56 52 44
61 92 52 16
70 32 51 70
89 36 37 53
54 44 39 58
68 95 50 95
72 52 77 47
59 59 44 54
24 95 98 48
42 12 23 24
13 19 10 42
29 55 22 54
45 17 74 80
60 45 34 88
21 18 68 76
28 75 47 32
65 26 79 72
22 34 15 29
80 70 38 84
48 84 75 39
44 66 99 63
69 11 64 23
89 10 64 10
35 33 76 93
12 55 12 33
43 69 87 30
58 23 86 25
46 29 90 86
13 18 72 91
67 20 94 44
35 99 17 96
94 63 83 61
68 94 97 73
93 20 40 41
76 57 89 32
84 74 46 40
90 31 60 50"

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
  if counts[result] == 2024
    break result * round
  end
end

puts "Part 2:", answer


input = "2 3 4 5
6 7 8 9"

input = "6743 1002 1001 1008
1004 1006 1002 5888
4641 1001 1002 1002
1005 4947 4794 1006
1000 1005 1003 1002
1001 1000 1000 1005
1003 3494 1002 1003
1000 1006 1002 1005
1003 2606 1006 1006
1008 1004 1001 1006
1002 1005 3450 1006
9476 1001 1007 1003
1009 1007 1008 1003
1004 1000 1002 1008
1003 1001 1001 1003
1003 1003 1007 1005
1008 1003 4503 7296
1006 1005 1009 1005
1003 1005 1006 1002
1008 1008 1005 2093
1009 1009 1000 1008
1006 1000 1002 1005
1001 1005 1002 1003
1006 2635 1001 1002
1009 1000 1007 1004
1009 1004 1003 1001
1009 1008 1000 1001
1003 1002 1001 1005
1008 1009 1000 1006
1005 1001 9587 3183
1004 1004 1003 1004
1009 1007 1004 1001
1004 1000 1007 1003
1002 1000 1000 1001
1007 1000 1001 1003
1006 1008 1008 1008
1002 1000 1005 1007
1000 1002 1008 1001
1004 1004 4667 1006
1008 1004 1006 1008
1008 1008 1002 1001
1009 1006 1006 1001
1006 1002 1009 1003
1005 1005 1005 1001
2794 1007 1009 1001
1004 1000 1005 1005
1005 1009 1000 1008
1004 1005 1007 1004
7128 1002 1002 1005
1008 1000 3706 2837"

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

  if position >= target_length
    position = (2 * target_length) - position
  end

  input[target_column].insert(position, number)

  result = input.map(&:first).join("").to_i

  if result > max
    max = result
  end

  if counts.key?(input.inspect)
    break counts.values.max
  end

  counts[input.inspect] = result
end

puts "Part 3:", answer
