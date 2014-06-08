require 'rake'

task :default => :d

task :a do
  puts "Task a"
end

task :b => :a do
  puts "Task b"
end

task :c => :a do
  puts "Task c"
end

task :d => [:b, :c] do
  puts "Task d"
end

file 'Rakefile'

file :'dag.json' => ['Rakefile'] do
  status = system 'rake --dry-run --trace 2>&1 | ./dag.rb > dag.json'
end
