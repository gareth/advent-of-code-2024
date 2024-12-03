# frozen_string_literal: true

require_relative 'report'

count = 0

while (line = gets)
  report = Report.new(line)
  puts format('%<report>s: %<safe>p %<error>s', { report:, safe: report.safe?, error: report.error }) if $DEBUG

  count += 1 if report.safe?
end

puts count
