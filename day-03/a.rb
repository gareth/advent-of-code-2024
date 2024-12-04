# frozen_string_literal: true

instructions = []

while (line = gets)
  line.scan(/mul\((\d+),(\d+)\)/).each { |r| instructions.push([r[0].to_i, r[1].to_i]) }
end

puts(instructions.sum { |a, b| (a * b) })
