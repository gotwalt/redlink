# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redlink/version'

Gem::Specification.new do |gem|
  gem.name          = 'redlink'
  gem.version       = Redlink::VERSION
  gem.authors       = ['Aaron Gotwalt']
  gem.email         = ['gotwalt@gmail.com']
  gem.description   = 'Control Redlink home thermostats'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/gotwalt/redlink'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.2'
  gem.add_dependency 'savon', '~> 2.0.2'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'thor'
end
