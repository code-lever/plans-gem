# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plans/version'

Gem::Specification.new do |spec|
  spec.name          = "plans"
  spec.version       = Plans::VERSION
  spec.authors       = ["Gabriel Cook"]
  spec.email         = ["gabe@codelever.com"]

  spec.summary       = %q{Command line application for creating markdown documents from templates and publishing them in MS Word.}
  spec.description   = %q{Command line application for creating markdown documents from templates and publishing them in MS Word.}
  spec.homepage      = "https://github.com/code-lever/plans-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "aruba"

  spec.add_dependency 'thor'
end
