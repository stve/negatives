# encoding: utf-8
require File.expand_path('../lib/negatives/version', __FILE__)

Gem::Specification.new do |gem|
  gem.version     = Negatives::VERSION
  gem.name        = 'negatives'

  gem.author      = "Steve Agalloco"
  gem.email       = 'steve.agalloco@gmail.com'
  gem.homepage    = ''
  gem.description = %q{TODO: Write a gem description}
  gem.summary     = %q{TODO: Write a gem summary}

  gem.require_paths = ['lib']

  gem.add_dependency "faraday", "~> 0.7"
  gem.add_dependency "faraday-stack"
  gem.add_dependency 'nokogiri', '~> 1.5'
  gem.add_dependency 'roe'

  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdiscount', '~> 1.6'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'yard', '~> 0.7'
  gem.add_development_dependency 'webmock', '~> 1.7'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
end
