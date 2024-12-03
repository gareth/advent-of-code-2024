instructions = []

while line = gets
  line.scan(/mul\((\d+),(\d+)\)/).each { |r| instructions.push([r[0].to_i, r[1].to_i]) }
end

puts instructions.inject(0) { |memo, (a, b)| memo + ( a * b ) }
