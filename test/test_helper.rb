require 'rubygems'
require 'bundler'
Bundler.require :test
require 'minitest/autorun'
require 'mocha/setup'
require 'redlink'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class RedlinkTest < MiniTest::Unit::TestCase

end
