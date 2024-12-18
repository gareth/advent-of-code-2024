# frozen_string_literal: true

left = []
right = []

while (line = gets)
  values = line.split(/\s+/)
  left << values[0].to_i
  right << values[1].to_i
end

multipliers = right.group_by(&:itself).transform_values(&:size)

puts(left.sum { |l| l * multipliers.fetch(l, 0) })
