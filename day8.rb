input = 13
input = 4_098_489

total_blocks = 1
last_layer = 1

until total_blocks >= input
  last_layer += 2
  total_blocks += last_layer
end

missing = total_blocks - input

puts "Part 1:", missing * last_layer

available_blocks = 50
priests = 3
acolytes = 5

available_blocks = 20_240_000
priests = 452
acolytes = 1111

stacks = [1]

total_blocks = 1
last_thickness = 1

until total_blocks >= available_blocks
  thickness = (priests * last_thickness) % acolytes

  stacks.push(0)
  stacks.unshift(0)

  0.upto(stacks.length - 1).each do |i|
    stacks[i] += thickness
  end

  last_thickness = thickness
  total_blocks += thickness * stacks.length
end

extra_blocks = total_blocks - available_blocks

puts "Part 2:", extra_blocks * stacks.length

available_blocks = 125_820_926
priests = 2
acolytes = 5

available_blocks = 202_400_000
priests = 931_743
acolytes = 10

stacks = [1]
total_blocks = 0
last_thickness = 1
layers = 1

loop do
  layers += 1

  thickness = (priests * last_thickness) % acolytes
  thickness += acolytes

  stacks.push(0)
  stacks.unshift(0)

  0.upto(stacks.length - 1).each do |i|
    stacks[i] += thickness
  end

  last_thickness = thickness

  total_blocks = stacks.first + stacks.last

  1.upto(stacks.length - 2).each do |i|
    height = stacks[i]
    to_remove = (stacks.length * priests * height) % acolytes
    total_blocks += height - to_remove
  end

  break if total_blocks > available_blocks
end

puts "Part 3:", total_blocks - available_blocks
