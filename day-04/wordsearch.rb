# frozen_string_literal: true

class Wordsearch
  attr_reader :lines, :width, :height

  def self.from_lines(lines)
    new(lines)
  end

  def self.directions
    9.times.map { |i| [(i / 3) - 1, (i % 3) - 1] }.reject { |dir| dir == [0, 0] }.to_enum
  end

  def initialize(lines)
    @lines = lines
    @width = @lines.first.size
    @height = @lines.size
  end

  def find(word)
    chars = word.chars
    directions = self.class.directions

    # Each successful match results in a `1`, so we sum up all of the results across all starting positions in the grid
    width.times.sum do |x|
      height.times.sum do |y|
        directions.each.sum do |w, h|
          scan chars, x, y, w, h
        end
      end
    end
  end

  private

  # Scan the grid for a word starting at an initial position and moving by a given offset for each character
  # Returns 1 if the chars were all found, 0 otherwise
  def scan(chars, init_x, init_y, offset_w, offset_h)
    puts format('Scanning %<x>i,%<y>i %<w>i,%<h>i', x: init_x, y: init_y, w: offset_w, h: offset_h) if $DEBUG

    catch(:result) do
      chars.each.with_index do |c, i|
        check c, init_x + (offset_w * i), init_y + (offset_h * i)
      end

      1
    end
  end

  # Check for the presence of a given character in a given location
  # Throws :result, 0 if not found, allowing the search to continue if it is
  def check(char, target_x, target_y)
    throw :result, 0 if target_x.negative? || target_x >= width
    throw :result, 0 if target_y.negative? || target_y >= height

    target = lines[target_y][target_x]

    puts format(' %<tx>i,%<ty>i/%<c>s: %<target>s', tx: target_x, ty: target_y, c: char, target:) if $DEBUG
    throw :result, 0 if target != char
  end

  def to_s
    format("(%<width>ix%<height>i)\n%<grid>s", width:, height:, grid: @lines.join("\n"))
  end
end
