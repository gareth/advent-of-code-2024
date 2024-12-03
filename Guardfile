# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :shell, all_on_start: true do
  watch(/\b(.)\.rb/) do |m|
    if m[0]
      puts
      if run m[0], :sample
        run m[0], :real
      end
      nil
    end
  end
end

INPUT_FILES = {
  sample: "input.sample",
  real: "input"
}

def run file, input_type
  dir = File.dirname(file)
  input = INPUT_FILES.fetch(input_type)
  input_filename = File.join(dir, input)
  if File.exist? input_filename
    puts "Running #{file} with #{input_type} input"
    system("ruby", file, input_filename)
  end
end
