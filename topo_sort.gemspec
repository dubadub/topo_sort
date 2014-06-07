# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'topo_sort/version'

Gem::Specification.new do |spec|
  spec.name          = "topo_sort"
  spec.version       = TopoSort::VERSION
  spec.authors       = ["Alexey Dubovskoy"]
  spec.email         = ["dubovskoy.a@gmail.com"]
  spec.summary       = %q{Coding exercise for weareadam.com}
  spec.homepage      = "https://github.com/dubadub"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
