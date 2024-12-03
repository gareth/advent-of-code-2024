# frozen_string_literal: true

class Report
  def self.from_line(line)
    new line.split(/\s+/).map(&:to_i)
  end

  def initialize(levels)
    @levels = levels
  end

  def error
    diffs = @levels.each_cons(2).map { |a, b| b - a }
    return :unordered unless diffs.map { |d| d / d.abs }.uniq.size == 1
    return :jump unless diffs.all? { |d| d.abs <= 3 }

    nil
  rescue ZeroDivisionError
    :duplicates
  end

  def safe?
    !error
  end

  def to_s
    @levels.to_s
  end
end
