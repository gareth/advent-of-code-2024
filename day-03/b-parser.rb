# frozen_string_literal: true

require 'parslet'

class MemoryHandler < Parslet::Parser
  rule(:int) { match['0-9'].repeat(1).as(:int) }
  rule(:mult) { str('mul(') >> int.as(:left) >> str(',') >> int.as(:right) >> str(')') }

  rule(:enable) { str('do()') }
  rule(:disable) { str("don't()") }

  rule(:atom) { mult.as(:mult) | enable.as(:enable) | disable.as(:disable) | any }
  rule(:expression) { atom.repeat }
  root(:expression)
end

class MemoryProcessor < Parslet::Transform
  rule(int: simple(:i)) { Integer(i) }
  rule(mult: { left: simple(:l), right: simple(:r) }) { AST::Mult.new(l * r) }
  rule(enable: subtree(:any)) { AST::Enable.new }
  rule(disable: subtree(:any)) { AST::Disable.new }
end

module AST
  Mult = Struct.new(:value)
  Enable = Struct.new
  Disable = Struct.new
end

class Evaluator
  def initialize(nodes)
    @nodes = nodes
  end

  def evaluate(initial = 0) # rubocop:disable Metrics/MethodLength
    enabled = true
    total = initial
    @nodes.each do |node|
      case node
      when AST::Enable then enabled = true
      when AST::Disable then enabled = false
      when AST::Mult
        total += node.value if enabled
      end
    end

    total
  end
end

MemoryHandler
  .new.parse(ARGF.read)
  .then { |tree| MemoryProcessor.new.apply(tree) }
  .then { |expressions| p Evaluator.new(expressions).evaluate }
