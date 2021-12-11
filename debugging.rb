def output_with_color(color, *args)
  args.each do |arg|
    puts(('  ' * (caller.length - 4)) + Rainbow(arg).send(color))
  end
end

def debug(*args)
  output_with_color :yellow, *args
end

def info(*args)
  output_with_color :cyan, *args
end

def warning(*args)
  output_with_color :pink, *args
end

def error(*args)
  output_with_color :red, *args
end

def green(*args)
  output_with_color :green, *args
end

def assert(condition)
  raise "FAILED: #{read_code(caller[0])}" unless condition
end

def read_code(line)
  file_name, line_number = $1, $2.to_i if line =~ /(.*):(\d+):in/
  info line: line, file_name: file_name, line_number: line_number
  File.read(file_name).lines[line_number - 1].chomp
end
