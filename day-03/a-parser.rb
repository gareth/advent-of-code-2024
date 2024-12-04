# frozen_string_literal: true

require 'parslet'

class MemoryHandler < Parslet::Parser
  rule(:int) { match['0-9'].repeat(1).as(:int) }
  rule(:mult) { str('mul(') >> int.as(:left) >> str(',') >> int.as(:right) >> str(')') }
  rule(:mult_or_junk) { mult.as(:mult) | any }

  rule(:expression) { mult_or_junk.repeat }
  root(:expression)
end

class MemoryProcessor < Parslet::Transform
  rule(int: simple(:i)) { Integer(i) }
  rule(mult: { left: simple(:l), right: simple(:r) }) { l * r }
  rule(sequence(:x)) { x.inject(0) { |memo, i| memo + i } }
end

result = MemoryHandler.new.parse(ARGF.read)
p MemoryProcessor.new.apply(result)
