# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpserver/version'

Gem::Specification.new do |spec|
  spec.name          = "httpserver"
  spec.version       = Httpserver::VERSION
  spec.authors       = ["Mark Gandolfo"]
  spec.email         = ["mark@aussiev8.com.au"]
  spec.description   = %q{Start a http server in any directory}
  spec.summary       = %q{Start a http server in any directory with one simple command}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
