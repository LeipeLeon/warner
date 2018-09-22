# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "warner/version"

Gem::Specification.new do |spec|
  spec.name          = "warner"
  spec.version       = Warner::VERSION
  spec.authors       = ["Leon Berenschot"]
  spec.email         = ["leipeleon@gmail.com"]

  spec.summary       = %q{Annotate your code w/ custom deprecation warnings}
  spec.description   = %q{for exampele when a newer version of a gem or rails is installed. Especially useful for monkeypatching.}
  spec.homepage      = "https://github.com/LeipeLeon/warner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rspec-autotest'
  spec.add_development_dependency 'autotest-standalone'
  spec.add_development_dependency 'autotest-fsevent'
  spec.add_development_dependency 'activesupport'
end
