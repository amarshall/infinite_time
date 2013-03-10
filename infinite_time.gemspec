# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infinite_time/version'

Gem::Specification.new do |spec|
  spec.name          = 'infinite_time'
  spec.version       = InfiniteTime::VERSION
  spec.authors       = ['Andrew Marshall']
  spec.email         = ['andrew@johnandrewmarshall.com']
  spec.description   = %q{Provides a representation of a (positively or negatively) infinite time.}
  spec.summary       = %q{Provides a representation of a (positively or negatively) infinite time.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
