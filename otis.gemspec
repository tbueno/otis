# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'otis/version'

Gem::Specification.new do |spec|
  spec.name          = "otis"
  spec.version       = Otis::VERSION
  spec.authors       = ["Thiago Bueno"]
  spec.email         = ["tbueno@tbueno.com"]
  spec.description   = %q{A Ruby Api wrapper framework}
  spec.summary       = %q{A Ruby Api wrapper framework}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'savon', '~> 2.2.0'
  spec.add_dependency 'faraday'
  spec.add_dependency 'virtus'
end
