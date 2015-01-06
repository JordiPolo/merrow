# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'merrow/version'

Gem::Specification.new do |spec|
  spec.name          = "merrow"
  spec.version       = Merrow::VERSION
  spec.authors       = ["Jordi Polo"]
  spec.email         = ["mumismo@gmail.com"]
  spec.summary       = %q{Small tool to look at all you pending PR in Github.}
  spec.description   = %q{Small tool to look at all you pending PR in Github }
  spec.homepage      = "https://github.com/JordiPolo/merrow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'byebug', '~> 3.0'
  spec.add_dependency "octokit", "~> 3.0"
end
