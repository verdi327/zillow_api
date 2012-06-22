# -*- encoding: utf-8 -*-
require File.expand_path('../lib/zillow_demographics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["michael verdi"]
  gem.email         = ["michael.v.verdi@gmail.com"]
  gem.description   = %q{wrapper for the zillow_demographics api}
  gem.summary       = %q{wrapper for the zillow_demographics api}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "zillow_demographics"
  gem.require_paths = ["lib"]
  gem.version       = ZillowDemographics::VERSION

  gem.add_runtime_dependency('faraday')
  gem.add_runtime_dependency('nokogiri')
  gem.add_development_dependency('rspec')
end
