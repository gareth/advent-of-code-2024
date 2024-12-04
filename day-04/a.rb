# frozen_string_literal: true

class Wordsearch
  attr_reader :lines, :width, :height

  def self.from_lines(lines)
    new(lines)
  end

  def initialize(lines)
    @lines = lines
    @width = @lines.first.size
    @height = @lines.size
  end

  def find(word)
    chars = word.chars
    directions = self.class.directions

    width.times.sum do |x|
      height.times.sum do |y|
        directions.each.sum do |w, h|
          puts format('Checking %<x>i,%<y>i %<w>i,%<h>i', x:, y:, w:, h:) if $DEBUG

          result = catch(:result) do
            chars.each.with_index do |c, i|
              tx = x + (w * i)
              throw :result, 0 if tx.negative? || tx >= width

              ty = y + (h * i)
              throw :result, 0 if ty.negative? || ty >= height

              target = lines[ty][tx]

              puts format(' %<tx>i,%<ty>i/%<c>s: %<target>s', tx:, ty:, c:, target:) if $DEBUG
              throw :result, 0 if target != c
            end

            1
          end

          result
        end
      end
    end
  end

  def self.directions
    9.times.map { |i| [(i / 3) - 1, (i % 3) - 1] }.reject { |dir| dir == [0, 0] }.to_enum
  end

  def to_s
    format("(%<width>ix%<height>i)\n%<grid>s", width:, height:, grid: @lines.join("\n"))
  end
end

ws = Wordsearch.new(ARGF.readlines(chomp: true))
puts ws if $DEBUG
p ws.find('XMAS')
