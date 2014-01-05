# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lockdown/version'

Gem::Specification.new do |spec|
  spec.name          = "lockdown"
  spec.version       = Lockdown::VERSION
  spec.authors       = ["Logan Serman"]
  spec.email         = ["loganserman@gmail.com"]
  spec.description   = %q{Simple loading/authorization plugin for Ruby on Rails.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/lserman/lockdown"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "activesupport", '>= 4'

end
