# frozen_string_literal: true

require_relative 'wordsearch'

ws = Wordsearch.new(ARGF.readlines(chomp: true))
puts ws if $DEBUG
p ws.find('XMAS')
