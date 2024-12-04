# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :shell, all_on_start: true do
  solution_file = %r{/.\b(.*)\.rb$}

  watch(solution_file) do |m|
    if m[0]
      puts
      if run m[0], :sample, '-d' # rubocop: disable Style/IfUnlessModifier - the flow is relevant here
        run m[0], :real
      end
      nil
    end
  end
end

INPUT_FILES = {
  sample: 'input.sample',
  real: 'input'
}.freeze

def run(file, input_type, *flags)
  dir = File.dirname(file)
  input = INPUT_FILES.fetch(input_type)
  input_filename = File.join(dir, input)
  return unless File.exist?(file) && File.exist?(input_filename)

  puts "Running #{file} with #{input_type} input"
  system('ruby', *flags, file.to_s, input_filename)
end
