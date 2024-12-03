# frozen_string_literal: true

require_relative 'report'

class FixableReport < Report
  def safe?
    super || fixable?
  end

  def fixable?
    @levels.size.times.any? do |i|
      new_levels = @levels.slice(0, i) + @levels.slice((i + 1)..-1)
      Report.new(new_levels).safe?
    end
  end
end

count = 0

while (line = gets)
  report = FixableReport.from_line(line)
  puts format('%<report>s: %<safe>p %<error>s', { report:, safe: report.safe?, error: report.error }) if $DEBUG

  count += 1 if report.safe?
end

puts count
