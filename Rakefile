task :default do
  newest = Dir['[0-9b]*.rb'].max_by { File.new(_1).mtime }
  sh "rubocop -A #{newest}"
  ruby "-I../2020 -rrainbow -rdebugging #{newest}"
end