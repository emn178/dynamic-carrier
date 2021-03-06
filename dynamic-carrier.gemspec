# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamic-carrier/version'

Gem::Specification.new do |spec|
  spec.name          = "dynamic-carrier"
  spec.version       = DynamicCarrier::VERSION
  spec.authors       = ["Chen Yi-Cyuan"]
  spec.email         = ["emn178@gmail.com"]

  spec.summary       = %q{An sms_carrier delivery method layer that decides the delivery method dynamically by your rules.}
  spec.description   = %q{An sms_carrier delivery method layer that decides the delivery method dynamically by your rules.}
  spec.homepage      = "https://github.com/emn178/dynamic-carrier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sms_carrier", ">= 0.1.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
