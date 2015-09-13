# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vin/version'
Gem::Specification.new do |spec|
  spec.name          = "vin"
  spec.version       = Vin::VERSION
  spec.authors       = ["mataya"]
  spec.email         = ["mataya@cleversafe.com"]
  spec.description   = ["This is a description."]
  spec.summary       = %q{This is a wine clube.}
  spec.homepage      = "https://github.com/mazen555/vin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"

end
