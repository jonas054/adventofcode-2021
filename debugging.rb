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
