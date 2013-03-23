require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r redlink.rb"
end

task default: :test
