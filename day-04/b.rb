# frozen_string_literal: true

require_relative 'wordsearch'

class XWordsearch < Wordsearch
  def x_find(word)
    chars = word.chars

    # Each successful match results in a `1`, so we sum up all of the results across all starting positions in the grid
    (width - 2).times.sum do |i|
      x = i + 1
      (height - 2).times.sum do |j|
        y = j + 1
        puts "Checking #{x},#{y}" if $DEBUG
        positive_diagonal = scan(chars, x - 1, y - 1, 1, 1) + scan(chars.reverse, x - 1, y - 1, 1, 1)
        next 0 if positive_diagonal.zero?

        negative_diagonal = scan(chars, x + 1, y - 1, -1, 1) + scan(chars.reverse, x + 1, y - 1, -1, 1)
        next 0 if negative_diagonal.zero?

        1
      end
    end
  end
end

ws = XWordsearch.new(ARGF.readlines(chomp: true))
puts ws if $DEBUG
p ws.x_find('MAS')
