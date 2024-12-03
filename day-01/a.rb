# frozen_string_literal: true

left = []
right = []

while (line = gets)
  values = line.split(/\s+/)
  left << values[0].to_i
  right << values[1].to_i
end

puts left.sort.zip(right.sort).inject(0) { |memo, (l, r)| memo + (l - r).abs }
