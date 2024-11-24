input = "WORDS:THE,OWE,MES,ROD,HER

AWAKEN THE POWER ADORNED WITH THE FLAMES BRIGHT IRE"

input = File.read("./everybody_codes_e2024_q02_p1.txt")

words, only_sentence = input.split("\n\n")

words = words.split(":").last.split(",")

matches = words.map do |word|
  only_sentence.scan(/#{word}/).length
end

puts "Part 1:", matches.sum

input = "WORDS:THE,OWE,MES,ROD,HER,QAQ

AWAKEN THE POWE ADORNED WITH THE FLAMES BRIGHT IRE
THE FLAME SHIELDED THE HEART OF THE KINGS
POWE PO WER P OWE R
THERE IS THE END
QAQAQ"

input = File.read("./everybody_codes_e2024_q02_p2.txt")

words, sentences = input.split("\n\n")
sentences = sentences.split("\n")

words = words.split(":").last.split(",")

words += words.map(&:reverse)

matches = sentences.sum do |sentence|
  indices = Set.new

  words.each do |word|
    (0..(sentence.length - word.length)).count do |i|
      if word == sentence[i...i + word.length]
        (i...i + word.length).each do |j|
          indices.add(j)
        end
      end
    end
  end

  indices.length
end

puts "Part 2:", matches

input = "WORDS:THE,OWE,MES,ROD,RODEO

HELWORLT
ENIGWDXL
TRODEOAL"

input = File.read("./everybody_codes_e2024_q02_p3.txt")

words, sentences = input.split("\n\n")
sentences = sentences.split("\n")

words = words.split(":").last.split(",")
words += words.map(&:reverse)

indices = Set.new

sentences.each.with_index do |sentence, row|
  words.each do |word|
    sentence_pad = sentence + sentence[0...(word.length - 1)]

    (0...sentence_pad.length).each do |col|
      next unless word == sentence_pad[col...col + word.length]

      (col...col + word.length).each do |j|
        indices.add([row, j % sentence.length])
      end
    end
  end
end

sentences = sentences.map(&:chars).transpose.map(&:join)

sentences.each.with_index do |sentence, row|
  words.each do |word|
    sentences.each.with_index do |_sentence, col|
      next unless word == sentence[col...col + word.length]

      (col...col + word.length).each do |j|
        indices.add([j % sentence.length, row])
      end
    end
  end
end

puts "Part 3:", indices.length
